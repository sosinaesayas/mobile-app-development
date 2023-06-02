import 'package:json_annotation/json_annotation.dart';


class UserNotification{
  UserNotification({ required this.message , required this.companyName , required this.unread});

  final String message;
  final String companyName;
  final bool unread;

   Map<String, dynamic> toJson() {
    return {
      'message': message,
      'companyName' : companyName , 
      'unread' : unread
    };
  }



  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification( message :  json['message'],
      companyName: json['companyName'], 
      unread : json['unread'] as bool
    );
  }
}

