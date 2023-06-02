enum ConnectionStatus{
  requested , 
  notRequested,
  unknown , 
  requestInProgress , 
  requestFailed

}


class UserConnectionState {
  UserConnectionState(
    {
      this.status  = ConnectionStatus.unknown
    }
  );

  final ConnectionStatus status;
  UserConnectionState copyWith({
    ConnectionStatus ? status
  }) => UserConnectionState (
        status : status ?? this.status
    );

}

