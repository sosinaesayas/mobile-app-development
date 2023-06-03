import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:jobportal/application/job/bloc/job_state.dart';
import 'package:jobportal/application/job/bloc/job_event.dart';
import 'package:jobportal/domain/job/model/job_failure.dart';
import 'package:jobportal/infrastructure/jobs/data_sources/api_data_source.dart';
import 'package:jobportal/domain/job/model/job_model.dart';
import 'package:jobportal/infrastructure/jobs/repository.dart';
import 'package:jobportal/infrastructure/util/data_base.dart';

class JobBloc extends Bloc<JobEvent, JobsState> {

  JobBloc() : super(JobsState()) {
    on<JobEvent>((event, emit) {});
    on<JobsRequested>(_handleJobsRequested);
     on< AppliedJobsRequested>(_handleAppliedJobsRequested);
     on<JobsSearchRequested>(_handleSearchJobsRequested);
    on<PostJobRequested>(_handlePostJobRequested);
    on<PostedJobsRequested>(_handlePostedJobsRequested);
    on<deleteJobRequest>(_handledeleteJobsRequest);
  }

  Future<void> _handleJobsRequested(JobsRequested event , Emitter<JobsState> emit)async {
 
   
    JobDataSource jobapi = new JobDataSource();
    List<Job> ? localJobs = await MehalbetDatabase.getInstance.getAllJobs("jobs");
    try {
         emit(state.copyWith(
        status: JobsStatus.requestInProgress , 
        jobs: localJobs
      ));
      
      
      final Either<JobFailure, List<Job>> response = await jobapi.getJobs();
      print("response is $response");

      response.fold(
        (failure) {
          if (failure is InvalidCredentialsFailure) {
          
            print(failure.message);
            emit(state.copyWith(status: JobsStatus.authenticationFailed , jobs : localJobs));
          } else if (failure is NetworkFailure) {
            
            print(failure.message);
            emit(state.copyWith(status: JobsStatus.NetworkFailure , jobs: localJobs));
          } else {
           
            emit(state.copyWith(status: JobsStatus.unknown , jobs: localJobs));
          }
        },
        (jobs) {
        
          emit(state.copyWith(status: JobsStatus.requestSuccess , 
          jobs: jobs
          ));
        });

    } catch (e) {
      print(e);
         print("Network error! or something else");
      emit(state.copyWith(status: JobsStatus.unknown));

    }


    


    
  }


  
     Future<void> _handleAppliedJobsRequested(AppliedJobsRequested event , Emitter<JobsState> emit)async {
    
    JobDataSource jobapi = new JobDataSource();
List<Job> ? localJobs = await MehalbetDatabase.getInstance.getAllJobs("myjobs");
    try {
         emit(state.copyWith(
        status: JobsStatus.requestInProgress , 
        appliedjobs: localJobs
      ));
      final Either<JobFailure, List<Job>> response = await jobapi.appliedJobs();
      

      response.fold(
        (failure) {
          if (failure is InvalidCredentialsFailure) {
            print("Invalid credentials!");
            print(failure.message);
            emit(state.copyWith(status: JobsStatus.authenticationFailed));
          } else if (failure is NetworkFailure) {
            print("Network error!");
            print(failure.message);
            emit(state.copyWith(status: JobsStatus.NetworkFailure));
          } else {
            print("Unknown failure occurred");
            emit(state.copyWith(status: JobsStatus.unknown));
          }
        },
        (jobs) {
          print("Authenticated!");
          print(jobs);
          emit(state.copyWith(status: JobsStatus.requestSuccess , 
          appliedjobs: jobs
          ));
        });

    } catch (e) {
      
         print("Network error!");
      emit(state.copyWith(status: JobsStatus.unknown));

    }
}




 Future<void> _handleSearchJobsRequested(JobsSearchRequested event , Emitter<JobsState> emit)async {
    /// 
    
    JobDataSource jobapi = new JobDataSource();

    try {
         emit(state.copyWith(
        status: JobsStatus.requestInProgress
      ));
      final Either<JobFailure, List<Job>> response = await jobapi.searchJobs(event.keyword);
      

      response.fold(
        (failure) {
          if (failure is InvalidCredentialsFailure) {
            print("Invalid credentials!");
            print(failure.message);
            emit(state.copyWith(status: JobsStatus.authenticationFailed));
          } else if (failure is NetworkFailure) {
            print("Network error!");
            print(failure.message);
            emit(state.copyWith(status: JobsStatus.NetworkFailure));
          } else {
            print("Unknown failure occurred");
            emit(state.copyWith(status: JobsStatus.unknown));
          }
        },
        (jobs) async{
          
          emit(state.copyWith(status: JobsStatus.requestSuccess , 
          jobs: jobs
          ));

          
        }
        );

    } catch (e) {
      
         print("Network error!");
      emit(state.copyWith(status: JobsStatus.unknown));

    }


    


    
  }

  Future<bool> hasAppliedForJob(id)async{
       JobDataSource jobapi = JobDataSource();
       print("Checking application ......");
      try {
          var  response =  await jobapi.checkApplied(id);
      print("checking applied!");
      print(response);
        if(!response){
          return false;
        } return true;
        
      } catch (e) {
        print(e);
        return false;
      }
  }
    void _handlePostJobRequested(PostJobRequested event, Emitter<JobsState> emit)async{
        JobDataSource api = JobDataSource();
        try {
          final response = await api.Postjob(job: event.jobInput);
          emit(state.copyWith(postjob : JobsStatus.requestInProgress));
          response.fold((l){
               emit(state.copyWith(postjob : JobsStatus.requestFailed));
          }, (r){
             if(r) {
            
               emit(state.copyWith(postjob : JobsStatus.requestSuccess));}else{
                emit(state.copyWith(postjob: JobsStatus.NetworkFailure));
               };
          });

        } catch (e) {
          print(e);
        }
    }


    _handlePostedJobsRequested(PostedJobsRequested event , Emitter<JobsState> emit)async{
        
        JobDataSource remoteapi = JobDataSource();
        JobRepository localjobds  = JobRepository();
        emit(state.copyWith(
          status: JobsStatus.requestInProgress
        ));
       final localjobs = await localjobds.getpostedjobs();
       localjobs.fold((l){}, (r) {
        emit(state.copyWith(jobs:  r));
       });

       final remotejobs = await remoteapi.getPostedJobs();
      remotejobs.fold(
        (l) {
          emit(state.copyWith( postedjobsrequest:  JobsStatus.requestFailed));
        },
       (r) {
      emit(state.copyWith(jobs:  r , postedjobsrequest:  JobsStatus.requestSuccess));
       });



    }


_handledeleteJobsRequest(deleteJobRequest event , Emitter<JobsState> emit) async{
   JobDataSource api  = JobDataSource();
    try {
      print("here");
      final response = await api.deleteJobs(event.jobId);
      response.fold((l) {emit(state.copyWith(deletejobs: JobsStatus.requestFailed));}, (r) => emit(state.copyWith(
            deletejobs: JobsStatus.requestSuccess
      )));
      print(response);
    } catch (e) {
      print(e);
    }
}

}