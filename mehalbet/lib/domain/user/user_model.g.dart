// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      // token: json['token'] as String,
      firstName : json['firstName'] as String,
      lastName: json['lastName'] as String, 
      id : json['id'] as String, 
      email: json["email"] as String,
      description:  json["description"] as String, 
      // experience: json['experience'] as String, 
      department: json['department'] as String,
      // phone: json["phone"] as String,
      acceptance: json["acceptance"] 


    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      // 'token': instance.token,
      'firstName' : instance.firstName , 
      'lastName' : instance.lastName, 
      'id' : instance.id , 
      'email' : instance.email , 
      "department" :instance.department , 
      "description" : instance.description , 
      // "experience" : instance.experience.toString()
      // "phone" : instance.phone
      "acceptance"  : instance.acceptance
    };
