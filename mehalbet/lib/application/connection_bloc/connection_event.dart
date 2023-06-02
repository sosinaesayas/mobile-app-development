

abstract class ConnectionEvent {}


class CheckConnectionEvent implements ConnectionEvent{
  CheckConnectionEvent({required this.freelancerId });
  final String freelancerId;
  
}

class CancelConnection implements ConnectionEvent{}

class MakeConnection implements ConnectionEvent{
    MakeConnection({required this.freelancerId });
  final String freelancerId;
  
}