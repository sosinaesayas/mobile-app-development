

import 'package:equatable/equatable.dart';

class AuthModel extends Equatable{
  String email;
  String password;
  AuthModel({required this.email , required this.password});
  factory AuthModel.fromJson(Map<String,String> json)=>  AuthModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );

   Map<String, String> toJson() =>  <String, String>{
      'email': this.email,
      'password': this.password,
    } ;
  @override
   List<Object> get props => [email, password];
}