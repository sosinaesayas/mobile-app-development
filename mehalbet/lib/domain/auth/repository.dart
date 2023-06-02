import 'package:dartz/dartz.dart';
import 'package:jobportal/domain/auth/auth_failure.dart';
import 'package:jobportal/domain/auth/model.dart';

abstract class AuthenticationFacade{
  
  Future<Either<AuthFailure , Map<String, dynamic> >> authenticateUser(AuthModel authModel);
}