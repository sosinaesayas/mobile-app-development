import 'package:equatable/equatable.dart';

abstract class UserNotificationFailure extends Equatable {
  const UserNotificationFailure();

  @override
  List<Object?> get props => [];
}

class NetworkFailure extends UserNotificationFailure {
  final String message;

  NetworkFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class InvalidCredentialsFailure extends UserNotificationFailure {
  final String message;

  InvalidCredentialsFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class DatabaseFailure extends UserNotificationFailure{
    final String message;

  DatabaseFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends UserNotificationFailure{
  final String message;
  UnknownFailure(this.message);
  
  @override
  List<Object?> get props => [message];
}