

enum AuthStatus {
  authenticationPending,
  authenticationFailed,
  authenticationSuccess,
  unknown , 
  freelancer, 
  company
}



class AuthState {
  //AuthModel authModel = AuthModel(email: "", password: "");
  AuthState({
    
    this.status = AuthStatus.unknown,
    this.entity = AuthStatus.unknown,
  });

  // final AuthModel authModel;
  final AuthStatus status;
  final AuthStatus entity;
  AuthState copyWith(
   { AuthStatus? status ,
    AuthStatus ? entity
   }
  ) => AuthState(status: status?? this.status , entity: entity ?? this.entity);
}
