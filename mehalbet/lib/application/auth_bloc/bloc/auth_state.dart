

enum AuthStatus {
  authenticationPending,
  authenticationFailed,
  authenticationSuccess,
  unknown , 
  freelancer, 
  company , 
  NetworkFailure , 

}



class AuthState {
  //AuthModel authModel = AuthModel(email: "", password: "");
  AuthState({
    
    this.status = AuthStatus.unknown,
    this.entity = AuthStatus.unknown,
    this.message = ""
  });

  // final AuthModel authModel;
  final AuthStatus status;
  final AuthStatus entity;
  final String message;
  AuthState copyWith(
   { AuthStatus? status ,
    AuthStatus ? entity , 
    String ? message
   }
  ) => AuthState(status: status?? this.status , 
  entity: entity ?? this.entity,
  message: message ?? this.message
  
  );
}
