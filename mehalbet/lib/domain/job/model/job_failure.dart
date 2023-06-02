import 'package:equatable/equatable.dart';

abstract class JobFailure extends Equatable {
  const JobFailure();

  @override
  List<Object?> get props => [];
}

class NetworkFailure extends JobFailure {
  final String message;

  NetworkFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class InvalidCredentialsFailure extends JobFailure {
  final String message;

  InvalidCredentialsFailure(this.message);

  @override
  List<Object?> get props => [message];
}


class LocalDbfailure extends JobFailure {
  final String message;

  LocalDbfailure(this.message);

  @override
  List<Object?> get props => [message];
}
