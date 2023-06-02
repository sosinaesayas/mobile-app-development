
class Message{
 

  static notification({required String kind,  required String email , required String name}){
      String msg;
        if(kind == "connect"){
          msg = "${name} company wants to contact you. Please check their email , ${email}";
          }
          else if(kind =="accept"){
              msg = "${name} company accepted your job application. Please check their email , ${email}";
          }
          else if(kind == "decline"){
              msg = "Sorry, ${name} company didn't accept your job application.";
          }
          else{
              msg = " ";
          }
          return msg;
  }
}