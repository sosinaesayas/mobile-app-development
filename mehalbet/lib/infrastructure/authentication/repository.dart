import 'package:dartz/dartz.dart';
import 'package:jobportal/domain/auth/auth_failure.dart';
import 'package:jobportal/domain/auth/model.dart';
import 'package:jobportal/domain/auth/repository.dart';
import 'package:jobportal/infrastructure/authentication/data_sources/api_datasource.dart';

class AuthRepository implements AuthenticationFacade{

  // final AuthModel authModel;
  // AuthRepository({required this.authModel});

  ApiDataSource api = ApiDataSource();
  @override
  Future<Either<AuthFailure , Map<String, dynamic>>> authenticateUser(AuthModel authModel) async {
      return await api.authenticateUser(authModel);
  }
  Future<bool> logoutUser()async{
        return api.logoutUser();
  }
}