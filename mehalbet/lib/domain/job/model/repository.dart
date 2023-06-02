import 'package:dartz/dartz.dart';
import 'package:jobportal/domain/job/model/job_failure.dart';
import 'package:jobportal/domain/job/model/job_model.dart';
abstract class JobFacade{
  
  Future<Either<JobFailure , List<Job>>> getJobs();
  Future<Either<JobFailure , List<Job>>> searchJobs(String query);
}