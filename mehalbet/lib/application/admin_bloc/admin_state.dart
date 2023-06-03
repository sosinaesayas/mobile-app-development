enum DeclineStatus {
  requestInProgress, 
  requestSuccess ,
  requestFailed,
  unknown, 
  unauthorised

}

class DeclineState  {
  DeclineState({
    this.status = DeclineStatus.unknown,
    this.confirm = DeclineStatus.unknown
  });

  final DeclineStatus status ;
 final DeclineStatus confirm;
  DeclineState copyWith(
    {DeclineStatus ? status , 
      DeclineStatus ? confirm
    }
  )=> DeclineState(
      status: status ?? this.status , 
      confirm: confirm ?? this.confirm
  );
}

