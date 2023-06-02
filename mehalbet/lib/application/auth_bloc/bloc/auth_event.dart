import 'package:jobportal/domain/auth/model.dart';



abstract class AuthEvent {}


class AuthenticationRequestSent implements AuthEvent{
  AuthenticationRequestSent({required  this.authModel});
  final AuthModel authModel;
}

class AuthenticationFailed implements AuthEvent{
  
}

class AuthenticationSuccess implements AuthEvent{

}


class UnauthenticateUser implements AuthEvent{
  
}