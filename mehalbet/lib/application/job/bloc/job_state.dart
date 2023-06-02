import 'package:jobportal/application/job/bloc/job_event.dart';
import 'package:jobportal/domain/job/model/job_model.dart';

enum JobsStatus{
    unknown, 
    requestInProgress , 
    requestSuccess , 
    authenticationFailed , 
    NetworkFailure , 
    appliedjobId , 
    jobPostRequested, 
    jobPostSuccess, 
    jobPostFailed, 
    requestFailed , 

    }

class JobsState{
  
  JobsState({
    this.jobs = const [] ,
     this.appliedjobs = const [] ,
    this.status = JobsStatus.unknown,
    this.appliedjobId = "",
    this.postjob = JobsStatus.unknown , 
    this.postedjobsrequest = JobsStatus.unknown,
    this.deletejobs = JobsStatus.unknown
  });

  final  List<Job> jobs;
  final  List<Job> appliedjobs;
  final JobsStatus status;
  final String appliedjobId;
  final JobsStatus postedjobsrequest;
  final JobsStatus postjob;
  final JobsStatus deletejobs;

  JobsState copyWith(
      {List<Job> ? jobs ,
      List<Job> ? appliedjobs,
      JobsStatus ? status , 
      String ? appliedjobId, 
      JobsStatus ? postjob , 
      JobsStatus ? postedjobsrequest ,
      JobsStatus  ? deletejobs
      } )=>JobsState(
       jobs : jobs ?? this.jobs, 
        appliedjobs : appliedjobs ?? this.appliedjobs, 
      status : status ?? this.status  ,
      appliedjobId: appliedjobId ?? this.appliedjobId  ,
      postjob: postjob ?? this.postjob, 
      postedjobsrequest: postedjobsrequest  ?? this.postedjobsrequest, 
      deletejobs:  deletejobs ?? this.deletejobs

    );
}


