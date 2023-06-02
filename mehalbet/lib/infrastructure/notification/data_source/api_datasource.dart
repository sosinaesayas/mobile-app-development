import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:jobportal/domain/company/company_model.dart';
import 'package:jobportal/domain/notification/model/notification_failure.dart';
import 'package:jobportal/domain/notification/model/notifications.dart';
import 'package:jobportal/domain/notification/repository.dart';
import 'package:jobportal/infrastructure/notification/util/message.dart';
import 'package:jobportal/infrastructure/util/base_url.dart';
import 'package:jobportal/infrastructure/company/data_base.dart';
import 'package:jobportal/infrastructure/company/util/company_header.dart';
import 'package:jobportal/infrastructure/util/data_base.dart';
import 'package:shared_preferences/shared_preferences.dart';



class UserNotificationDataSource implements UserNotificationFacade {
  
    late http.Client httpClient = http.Client();
    String url = BaseUrlAddress().url;
  @override
   Future<Either<UserNotificationFailure , List<UserNotification>>> getUserNotifications() async {
    
    
    try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");
      
       Map<String, String> headers = {
              'Content-Type': 'application/json' , 
              'x-access-token' : token?? ""};
    
      var response = await http.get(Uri.parse('$url/freelancer/notifications'),  headers: headers);
  
      if (response.statusCode == 200) {
         
        final parsed = jsonDecode(response.body) as List;
       
       
       List<UserNotification> notifications = List<UserNotification>.from(
           parsed.map((json) => UserNotification.fromJson(json as Map<String, dynamic>)),
);

        MehalbetDatabase.getInstance.insertUserNotifications(notifications); 
         
        return right(notifications);

        
      } else {
        return left( InvalidCredentialsFailure('Invalid email or password') );
      }
    } catch (e) {

      return left(NetworkFailure('Failed to authenticate usernotification. Please check your network connection.'));
    }
  }



  Future<Either<UserNotificationFailure , bool>> createNotification({required String kind , required String userId})async{
      
      Company ? company = await CompanyDatabase.getInstance.fetchCompany();
      String companyName = company?.name ?? " ";
      String email  = company?.email ?? " ";
      String msg = Message.notification(kind: kind, email: email, name: companyName);
      Map<String, String> header = await CompanyHeader.companyHeader();
      Map<String, String> reqBody =  {
            "companyName" : companyName, 
            "message" : msg , 
            "email" :email , 
            "kind" : kind
    
        };

      final response = await httpClient.post(Uri.parse("$url/freelancer/createnotification/$userId") ,
       headers:  header  , 
       body : jsonEncode(reqBody)
       );

       if(response.statusCode == 200){
        return right(true);
       }else if(response.statusCode == 401){
          return left(InvalidCredentialsFailure("Unauthorized"));

       }else{
        return left(NetworkFailure("Please check your connection"));
       }
  }



    Future<Either<UserNotificationFailure , bool>> CheckConnection({required freelancerId})async{
         
          Map<String, String> header = await CompanyHeader.companyHeader();
         try {
            final response = await httpClient.get(Uri.parse("$url/freelancer/checkconnection/$freelancerId") , headers: header );
          final parsed = jsonDecode(response.body) as Map<String, dynamic>;
          if(response.statusCode == 200 && parsed["ok"]){
            
            await CompanyDatabase.getInstance.insertConnectedFreelancer(freelancerId);
            return  right(true);
            
          }else if(response.statusCode == 200){
            
            return right(false);
          }
          else if(response.statusCode == 401){
            return left(InvalidCredentialsFailure("Unauthorised!")); 
          }
          return left(NetworkFailure("Please check your connection"));
         } catch (e) {
          print(e);
           return left(UnknownFailure("Please check your connection"));
         }
    }
  } 
