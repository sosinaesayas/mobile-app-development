import 'package:dartz/dartz.dart';
import 'package:jobportal/domain/user/user_failure.dart';
import 'package:jobportal/domain/user/user_model.dart';

abstract class UserFacade{
  
  Future<Either<UserFailure ,UserModel >> getUser();
  // Future<Either<JobFailure , List<Job>>> searchJobs(String query);
  Future<Either<UserFailure , List<UserModel>>> getLocalFreelancers();
}

