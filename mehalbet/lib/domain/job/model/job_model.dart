



class Job {
  String title;
  String dateCreated;
  String description;
  String status;
  String companyName;
  String id;
  String location;
  String deadline;
  // String phone;
  int appliedPeople;
  Job({
    required this.title,
    required this.dateCreated,
    required this.description,
     this.status ="",
    required this.companyName,
    required this.id,
    this.location  = "", 
    required this.deadline,
    // this.phone = "" , 
    this.appliedPeople = 0
  }  );

 factory Job.fromJson(Map<String, dynamic> json) {
    return  Job(
      title: json['title'] as String,
      dateCreated: json['dateCreated'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      companyName: json['companyName'] as String,
      id: json['id'] as String,
      location: json['location'] as String,
      deadline: json['deadline'] as String,
      // phone  : json["phone"] ?? "" , 
      appliedPeople: json['appliedpeople'] as int? ?? 0
    );
  }
  Map<String, dynamic> toJson() =><String, dynamic>{
      'title': this.title,
      'dateCreated': this.dateCreated,
      'description': this.description,
      'status': this.status,
      'companyName': this.companyName,
      "id": this.id , 
      "location" : this.location , 
      "deadline" : this.deadline , 
      // "phone" : this.phone 
    };


    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      "dateCreated" : dateCreated,
      "status" : status,
      " companyName" :  companyName , 
      "location" : location , 
      "deadline" : deadline,
      // "phone" : phone , 
      "appliedpeople" : appliedPeople
 
    };
  }



}
