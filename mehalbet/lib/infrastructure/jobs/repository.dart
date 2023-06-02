
import 'package:dartz/dartz.dart';
import 'package:jobportal/domain/job/model/job_failure.dart';
import 'package:jobportal/domain/job/model/job_model.dart';
import 'package:jobportal/domain/job/model/repository.dart';
import 'package:jobportal/infrastructure/company/data_base.dart';
import 'package:jobportal/infrastructure/jobs/data_sources/api_data_source.dart';
class JobRepository implements JobFacade{
    JobDataSource api = JobDataSource();
  @override 
    Future<Either<JobFailure , List<Job>>> getJobs( )async{
    
      return await api.getJobs();
    }
  @override
  Future<Either<JobFailure , List<Job>>> searchJobs(query)async{
    return await api.searchJobs(query);
  }

  Future<Either<JobFailure, bool>> ApplyToJob(jobId)async{
    return await api.ApplyToJob(jobId);    
  }

  Future<bool> checkApplied(jobId) async{
     return await api.checkApplied(jobId);  
  }

  Future<Either<JobFailure , List<Job>>> getpostedjobs()async{
    try {
      List<Job> postedjobs = await CompanyDatabase.getInstance.getPostedJobs();
      return right(postedjobs);
    } catch (e) {
      return left(LocalDbfailure("failed to access"));
    }

  }


}