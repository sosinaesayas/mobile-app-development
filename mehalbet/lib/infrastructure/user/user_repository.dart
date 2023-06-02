import 'package:dartz/dartz.dart';
import 'package:jobportal/domain/user/repository.dart';
import 'package:jobportal/domain/user/user_failure.dart';
import 'package:jobportal/domain/user/user_model.dart';
import 'package:jobportal/infrastructure/user/data_sources/api_data_source.dart';
import 'package:jobportal/infrastructure/company/data_base.dart';

class UserRepository implements UserFacade{

  // final AuthModel authModel;
  // AuthRepository({required this.authModel});

  UserApiDataSource api = UserApiDataSource();
  @override
  Future<Either<UserFailure , UserModel>> getUser() async {
      return await api.getUser();
  } 
  Future<Either<UserFailure , UserModel>> updateProfile({required Map<String, dynamic> usermodel})async{
      return await api.updateProfile(model: usermodel);
  }

@override
  Future<Either<UserFailure, List<UserModel>>> getLocalFreelancers() async{
   
     return await CompanyDatabase.getInstance.fetchFreelancers();
    
}


 Future<Either<UserFailure, List<UserModel>>> getRandomFreelancers() async{
   
     return await api.getRandomFreelancers();
    
}



}