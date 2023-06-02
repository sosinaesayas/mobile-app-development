import 'package:equatable/equatable.dart';

abstract class AuthFailure extends Equatable {
  const AuthFailure();

  @override
  List<Object?> get props => [];
}

class NetworkFailure extends AuthFailure {
  final String message;

  NetworkFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class InvalidCredentialsFailure extends AuthFailure {
  final String message;

  InvalidCredentialsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
