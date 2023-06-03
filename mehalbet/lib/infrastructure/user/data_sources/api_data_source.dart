import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:jobportal/domain/company/company_model.dart';
import 'package:jobportal/domain/user/user_failure.dart';
import 'package:jobportal/domain/user/user_model.dart';
import 'package:jobportal/infrastructure/company/util/company_header.dart';
import 'package:jobportal/infrastructure/util/base_url.dart';
import 'package:jobportal/infrastructure/company/data_base.dart';
import 'package:jobportal/infrastructure/util/data_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserApiDataSource {
     late http.Client httpClient = http.Client();
    final  String uri = BaseUrlAddress().url;

      Future<Either<UserFailure , UserModel>> getUser()async{
        try {
          final user  = await MehalbetDatabase.getInstance.getUser();
          print(user);
          if(user != null){
            return right(user);
          }
         return left( DatabaseFailure("Database failed!"));
        } catch (e) {
          print(e);
          return left( DatabaseFailure("Database failed!"));
        }
      }

      // Future<UserModel?> getCurrentUser()async{
      //     return await MehalbetDatabase.getInstance.getUser();
      // }
      Future<Either<UserFailure , UserModel>> updateProfile({required Map<String , dynamic> model})async{
            try {
              SharedPreferences prefs= await SharedPreferences.getInstance();
            String ? token = prefs.getString("token");
            Map<String , String> headers = {
              "x-access-token" : token ??"" , 
              "Content-Type"  : "application/json"
            };

            final requestBody = jsonEncode(model);
             
            print("here");
            final response = await httpClient.post(Uri.parse("${BaseUrlAddress().url}/freelancer/updateprofile") , headers: headers , body: requestBody);
             

            

          print(response.statusCode);
          print(response.statusCode == 200);
          if (response.statusCode == 200) {
       
                final parsed = jsonDecode(response.body) as Map<String, dynamic>;
                    UserModel? user = await MehalbetDatabase.getInstance.getUser();
                    final model =  user!.copyWith(
                      firstName: parsed['firstName'], 
                      lastName: parsed['lastName'],
                      email: parsed['email'], 
                      phone : parsed['phone']
                    );
                  await MehalbetDatabase.getInstance.deleteUserTable();

                  await MehalbetDatabase.getInstance.insertUser(model);
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString("token", parsed["token"] ?? "");
                        return right(model);}  } 
                        catch (e) {
                          print(e);
              return left(NetworkFailure("network not available"));
            }
            return left(DatabaseFailure("failed to connect with the database"));

      }


      Future<Either<UserFailure , List<UserModel>>> getRandomFreelancers()async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("company_token");
        final response = await httpClient.get(Uri.parse("${BaseUrlAddress().url}/freelancer/random", )  ,

       headers:  <String, String>{
        "x-access-token" : token ?? "" ,
        "Content-Type" : "application/json" 
       }
        );


        
       try {
          if(response.statusCode == 200){
          print(response.body);
          final parsed = jsonDecode(response.body) as List;
          print(parsed);
          List<UserModel> freelancers = parsed.map((freelancer) => UserModel.fromMap(freelancer)).toList();
          await CompanyDatabase.getInstance.addFreelancers(freelancers);
          return right(freelancers);

        }else if(response.statusCode == 400){
         return  left(UnAuthorizedAccessFailure("server responded with 400"));
        }
       } catch (e) {
         print(e);
       }
        return left(NetworkFailure("Please check your connection and try again"));

        
      }

    


      Future<Either<UserFailure , List<UserModel>>> getAppliedFreelancers(String jobId)async{
        final header = await CompanyHeader.companyHeader();
        final response = await httpClient.get(Uri.parse("${BaseUrlAddress().url}/job/appliedpeople/${jobId}") , headers: header);

        
       try {
          if(response.statusCode == 200){
          print(response.body);
          final parsed = jsonDecode(response.body) as List;
          print(parsed);
          List<UserModel> freelancers = parsed.map((freelancer) => UserModel.fromMap(freelancer)).toList();
          // await CompanyDatabase.getInstance.insertOrUpdateAppliedFreelancers(jobId , freelancers);
          return right(freelancers);

        }else if(response.statusCode == 401){
         return  left(UnAuthorizedAccessFailure("server responded with 400"));
        }
       } catch (e) {
        //  print(e);
       }
        return left(NetworkFailure("Please check your connection and try again"));

        
      }


  Future<Either<UserFailure , bool>> signupCompany(Map<String , dynamic> userdata)async{
    final parsed = jsonEncode(userdata);
    final response = await httpClient.post(Uri.parse("${BaseUrlAddress().url}/company/signin") ,
     headers: <String, String>{
      "Content-type" : "application/json"
     }, body: parsed);

    
    if(response.statusCode == 201){
        try {   
          print("returned");
          return right(true);
        } catch (e) {
        
         throw (e); 
        }
    }
    else{
      return left(NetworkFailure("Network error"));
    }
}

   Future< Either<UserFailure , bool> > acceptFreelancer(jobId , freelancerId) async{
    Company company = await CompanyDatabase.getInstance.getCompany();
    final header = await CompanyHeader.companyHeader();
    String name = company.name;
    String email  = company.email;
    String message = "$name company accepted your job application. Please check their email , ${email}";
    Map<String, dynamic> data = {
       "jobId" : jobId  ,
        "freelancerId" :  freelancerId ,
        "contain"  : {
            "message" : message , 
            "kind" : "accept"} };

    final response = await httpClient.post(Uri.parse("${BaseUrlAddress().url}/job/acceptfreelancer") , headers: header , body: jsonEncode(data));
    if(response.statusCode == 200){
      return right(true);
    }else if(response.statusCode == 401){
      return left(UnAuthorizedAccessFailure("You aren't authorised"));
    }
    return left(NetworkFailure("Please check your network"));

  
  
  
   }
  

    Future<Either<UserFailure , bool>> signupuser(Map<String , dynamic> userdata)async{
    final parsed = jsonEncode(userdata);
    final response = await httpClient.post(Uri.parse("${BaseUrlAddress().url}/freelancer/signin") ,
     headers: <String, String>{
      "Content-type" : "application/json"
     }, body: parsed);

    if(response.statusCode == 200){
        try {
        
     
       
        return right(true);
        } catch (e) {
         print(e);
         throw (e); 
        }
    }
    else{
      return left(NetworkFailure("Network error"));
    }
}


 Future<Either<UserFailure , List<UserModel>>> getPendingFreelncers()async{
      SharedPreferences prefs =await SharedPreferences.getInstance();
      
        // final header = await <String , String>{
        //   "content-Type" : "application/json" , 
        //   // "x-access-token" : prefs.getString('admin') ?? ""
        // };
        final response = await httpClient.get(Uri.parse("${BaseUrlAddress().url}/freelancer/pendingfreelancers"));

        print(response.statusCode);
       try {
          if(response.statusCode == 200){
          print(response.body);
          final parsed = jsonDecode(response.body) as List;
          print(parsed);
          List<UserModel> freelancers = parsed.map((freelancer) => UserModel.fromMap(freelancer)).toList();
          // await CompanyDatabase.getInstance.insertOrUpdateAppliedFreelancers(jobId , freelancers);
          return right(freelancers);

        }else if(response.statusCode == 401){
         return  left(UnAuthorizedAccessFailure("server responded with 400"));
        }
       } catch (e) {
        //  print(e);
       }
        return left(NetworkFailure("Please check your connection and try again"));

        
      }

Future<Either<UserFailure , bool>> confirmFreelancer(id)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
   final response = await httpClient.post(Uri.parse("${BaseUrlAddress().url}/freelancer/confirm") ,
     headers: <String, String>{
      "Content-type" : "application/json", 
      "x-access-token" : prefs.getString('token') ?? ""
     }, body: jsonEncode({"id" : id}));

   if(response.statusCode == 201){
        try {
        
     
       
        return right(true);
        } catch (e) {
         print(e);
         throw (e); 
        }
    }
    else{
      return left(NetworkFailure("Network error"));
    }
 }


Future<Either<UserFailure , bool>> declineFreelancer(id)async{
   final response = await httpClient.post(Uri.parse("${BaseUrlAddress().url}/freelancer/decline") ,
     headers: <String, String>{
      "Content-type" : "application/json"
     }, body: jsonEncode({"id" : id}));

   if(response.statusCode == 200){
        try {
        
     
       
        return right(true);
        } catch (e) {
         print(e);
         throw (e); 
        }
    }
    else{
      return left(NetworkFailure("Network error"));
    }
 }

Future<Either<UserFailure , bool>> confirmCompany(id)async{
   final response = await httpClient.post(Uri.parse("${BaseUrlAddress().url}/company/confirm") ,
     headers: <String, String>{
      "Content-type" : "application/json"
     }, body: jsonEncode({"id" : id}));

   if(response.statusCode == 200){
        try {
        
     
       
        return right(true);
        } catch (e) {
         print(e);
         throw (e); 
        }
    }
    else{
      return left(NetworkFailure("Network error"));
    }
 }


Future<Either<UserFailure , bool>> declineCompany(id)async{
   final response = await httpClient.post(Uri.parse("${BaseUrlAddress().url}/company/decline") ,
     headers: <String, String>{
      "Content-type" : "application/json"
     }, body: jsonEncode({"id" : id}));

   if(response.statusCode == 200){
        try {
        
     
       
        return right(true);
        } catch (e) {
         print(e);
         throw (e); 
        }
    }
    else{
      return left(NetworkFailure("Network error"));
    }
 }


  } 

   