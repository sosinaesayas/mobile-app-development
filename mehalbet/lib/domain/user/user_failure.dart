import 'package:equatable/equatable.dart';

abstract class UserFailure extends Equatable {
  const UserFailure();

  @override
  List<Object?> get props => [];
}

class DatabaseFailure extends UserFailure {
  final String message;

  DatabaseFailure(this.message);

 
  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends UserFailure{
    final String message;  
   NetworkFailure(this.message);
  
  @override
  List<Object?> get props => [message];


}

class UnAuthorizedAccessFailure extends UserFailure{
   final String message;  
   UnAuthorizedAccessFailure(this.message);
  
  @override
  List<Object?> get props => [message];
}