



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
 

   factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      id: json['id'],
      email: json['email'],
      description: json['description'] ,
      department: json['department'],
      phone: json['phone'] ?? "",
      acceptance: json['acceptance'] ?? "",
    );
  }


   UserModel copyWith({
    String? firstName,
    String? lastName,
    int? id,
    String? email,
    String? description,
    String? department,
    String? phone,
    String? acceptance,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      id:  this.id,
      email: email ?? this.email,
      description: description ?? this.description,
      department: department ?? this.department,
      phone: phone ?? this.phone,
      acceptance:  this.acceptance,
    );
  }
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