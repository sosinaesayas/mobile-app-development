enum SignUpStatus{
  requested, 
  NetworkFailure , 
  unknown,
  signupSuccess
}

class SignupState{
  SignupState({this.usersignup : SignUpStatus.unknown , this.companysignup : SignUpStatus.unknown});
  final SignUpStatus usersignup;
 final SignUpStatus companysignup;

  SignupState copyWith(
   { SignUpStatus ? usersignup , 
     SignUpStatus ? companysignup
   }

  )=> SignupState(usersignup: usersignup ?? this.usersignup , 
  companysignup : companysignup ?? this.companysignup
  );
}