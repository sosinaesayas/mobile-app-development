import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:jobportal/domain/auth/auth_failure.dart';
import 'package:jobportal/domain/auth/model.dart';
import 'package:jobportal/domain/auth/repository.dart';
import 'package:jobportal/domain/company/company_model.dart';
import 'package:jobportal/domain/user/user_model.dart';
import 'package:jobportal/infrastructure/util/base_url.dart';
import 'package:jobportal/infrastructure/company/data_base.dart';
import 'package:jobportal/infrastructure/util/data_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiDataSource implements AuthenticationFacade{

Future<void> clearSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

late http.Client httpClient = http.Client();
String url = BaseUrlAddress().url;
  @override
   Future<Either<AuthFailure, Map<String, dynamic>>> authenticateUser(AuthModel authModel) async {
    final Map<String, dynamic> jsonBody = authModel.toJson();
    
    try {
       

         Map<String, String> headers = {
       'Content-Type': 'application/json'};
        var response = await http.post(Uri.parse('$url/freelancer/login'), body: jsonEncode(jsonBody) , headers: headers);
      
       if (response.statusCode == 200) {
        await clearSharedPreferences();

        final parsed = jsonDecode(response.body);
       
        if(parsed["entity"] == "freelancer"){
        print(parsed);
        final model =  UserModel.fromMap(parsed); 
        await MehalbetDatabase.getInstance.insertUser(model); 
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", parsed['token']);

       
        }else{
        final model =  Company.fromJson(parsed); 
        await CompanyDatabase.getInstance.insertCompany(model) ;  
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("company_token", model.token);
        }
        
        return right(parsed);}
       
        
        
       else if(response.statusCode == 403) {
        return left(InvalidCredentialsFailure('Invalid email or password'));
      }
      return left(NetworkFailure("'Failed. Please check your network connection.'"));
    } catch (e) {
      print(e);
      return left(NetworkFailure('Failed to authenticate user. Please check your network connection.'));
    }
  }

  Future<bool> logoutUser()async{

      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');

         await MehalbetDatabase.getInstance.removeUser();
          print("cleared");
         return true;
       
      } catch (e) {
        print(e);
        return false;
      }
  }


  Future<Either<AuthFailure ,bool>> updatePassword(Map<String , dynamic> passwordData ) async{
     SharedPreferences prefs= await SharedPreferences.getInstance();
            String ? token = prefs.getString("token");
            Map<String , String> headers = {
              "x-access-token" : token ??"" , 
              "Content-Type"  : "application/json"
            };
     final reqBody = jsonEncode(passwordData);
     String url  = BaseUrlAddress().url;
     try {
       final response = await httpClient.post(Uri.parse("$url/freelancer/updatepassword") , headers: headers, body: reqBody );
      print(response.statusCode);
      if(response.statusCode == 200){
        return right(true);
      }else if(response.statusCode == 401){
        return right(false);
      }
      return left(NetworkFailure("Network failed"));
     } catch (e) {
       print(e);
       throw e;
     }
  }

}