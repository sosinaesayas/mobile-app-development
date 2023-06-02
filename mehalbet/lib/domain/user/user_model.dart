
import 'package:json_annotation/json_annotation.dart';


part 'user_model.g.dart';
@JsonSerializable(nullable: false)
class UserModel{
  
  // final String token;
  final String firstName;
  final String lastName;
  final String id;
  final String email;
  // final String experience ;
  final  String description ; 
  final String  department;
  final String phone;
  final String acceptance;
  
  UserModel({
    // required this.token  ,
           required this.firstName , 
           required this.lastName ,
           required this.id, 
           required this.email , 
          //  required this.experience , 
           required this.description , 
           required this.department,
            this.phone = "", 
            this.acceptance = ""
            });
  factory   UserModel.fromJson(Map<String,dynamic> json)=> _$UserModelFromJson(json);
  Map<String ,  String> toMap(){
    return {
   
    "email" : this.email , 
    "id" : this.id, 
    "firstName" : this.firstName , 
    "lastName" : this.lastName,
    "phone" :this.phone,
    "department" : this.department , 
    "description" : this.description , 
    "acceptance" : this.acceptance
   
    };

    
  }
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      
      phone: map['phone'],
      department: map['department'],
      description: map['description'],
      acceptance: map["acceptance"] ?? ""

    );
  }
}