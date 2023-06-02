

abstract class SignupEvent {}

class UserSignUpRequested implements SignupEvent{
  UserSignUpRequested({
   required this.userdata
  });
  final  Map<String , dynamic> userdata;
}


class CompanySignUpRequested implements SignupEvent{
  CompanySignUpRequested({
   required this.userdata
  });
  final  Map<String , dynamic> userdata;
}
