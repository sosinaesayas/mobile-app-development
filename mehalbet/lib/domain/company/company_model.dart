class Company {
  String name;
  String email;
  String token;
  String id;

  Company({
    required this.name,
    required this.email,
    required this.token,
    required this.id
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'token': token,
      'id' : id
    };
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      id : json['id'] as String
    );
  }
}
