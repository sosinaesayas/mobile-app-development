import 'package:jobportal/domain/job/model/job_failure.dart';
import 'package:jobportal/domain/job/model/job_model.dart';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:jobportal/domain/user/user_model.dart';
import 'package:jobportal/infrastructure/company/data_base.dart';
import 'package:jobportal/infrastructure/company/util/company_header.dart';
import 'package:jobportal/infrastructure/util/base_url.dart';
import 'package:jobportal/infrastructure/util/data_base.dart';
import 'package:shared_preferences/shared_preferences.dart';



class JobDataSource {
   String url = BaseUrlAddress().url;
   
  
  late http.Client httpClient = http.Client();


  
   Future<Either<JobFailure, List<Job>>> getJobs() async {
      
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final userToken= prefs.getString("token");
    
    
        try {
     
      var response = await httpClient.get(Uri.parse('$url/job/departmentjob') , headers: <String , String>{
        "x-access-token" : userToken ?? ""
      } ,);

      if (response.statusCode == 200) {
         
        final parsed = jsonDecode(response.body) as List;
        print(parsed);
        List<Job> jobs = parsed.map((json)=> Job.fromJson(json)).toList();
        await MehalbetDatabase.getInstance.insertJobs(jobs: jobs , tableName: "jobs" );
        return right(jobs);

        
      } else {
       
        return left(InvalidCredentialsFailure('Invalid email or password'));
      }
    } catch (e) {
      print(e);
      return left(NetworkFailure('Failed to authenticate user. Please check your network connection.'));
    }
  }



   Future<Either<JobFailure, List<Job>>> searchJobs(query) async{

            try {
     
      var response = await http.get(Uri.parse('$url/jobs/$query') ); // ,  headers: headers implement
      print(response);
      if (response.statusCode == 200) {
         
        final parsed = jsonDecode(response.body) as List;
        List<Job> jobs = parsed.map((json)=> Job.fromJson(json)).toList();
       
        return right(jobs);

        
      } else {
        return left(InvalidCredentialsFailure('Invalid email or password'));
      }
    } catch (e) {
      print(e);
      return left(NetworkFailure('Failed to authenticate user. Please check your network connection.'));
    }
  }



   
    Future<bool> checkApplied(jobId) async{
       
   

         SharedPreferences prefs = await SharedPreferences.getInstance();   
        final token = prefs.getString("token");
        
        String newUrl = "${BaseUrlAddress().url}/freelancer/checkapplied/$jobId";
        final response = await httpClient.get(Uri.parse(newUrl) , headers : {
              "x-access-token" : token?? "", 
             "Content-type" : "application/json"
        });

        var parsed = jsonDecode(response.body);

        if(parsed['ok'] == true){
          return true;
        }else{
          return false;
        }

    }


    Future<Either<JobFailure , bool>> ApplyToJob(jobId)async{
    
        
   try {
     UserModel ? user = await MehalbetDatabase.getInstance.getUser();
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String ?token = prefs.getString("token");
     print("user id is .........");
    
     Map<String , String> reqBody = {
      "email" : user!.email ,
      // "token" : user.token, 
      "userId" : user.id , 
      "jobId" : jobId };
      print(reqBody);


      print(reqBody.toString());
      Map<String , String> header = {
        "x-access-token" : token  ?? "", 
        "Content-type" : "application/json"
      };
      var response = await http.post(Uri.parse('$url/job/applytojob')  , headers: header , body: json.encode(reqBody)); // ,  headers: headers implement
      print(response.statusCode);
      if (response.statusCode == 200) {
         
        final parsed = jsonDecode(response.body) as Map<String, dynamic>;
        
    
        return right(parsed['ok']);

        
      } else {
        
        return left(InvalidCredentialsFailure('Invalid email or password'));
      }
    } catch (e) {
      print("the error is");
      print(e);
     
      return left(NetworkFailure('Failed to authenticate user. Please check your network connection.'));
    }

         

    }


 
  Future<Either<JobFailure, List<Job>>> appliedJobs() async{
          
    try {
         SharedPreferences prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("token");
     print("the token is  : $token");
      var response = await httpClient.get(Uri.parse('$url/freelancer/appliedjobs') , headers: <String , String>{
        "x-access-token" : token ?? "" , 
        "Content-type" : "application/json"
      } ); 
  print("status code is ${response.statusCode}")  ;
  if (response.statusCode == 200) {
         
        final parsed = jsonDecode(response.body) as List;
        // print(parsed);
        List<Job> jobs = parsed.map((json)=> Job.fromJson(json)).toList();
           
        await MehalbetDatabase.getInstance.insertJobs(jobs: jobs , tableName: "myjobs" );
        return right(jobs);

        
      } else {
        return left(InvalidCredentialsFailure('Invalid email or password'));
      }
    } catch (e) {
      print(e);
      return left(NetworkFailure('Failed to authenticate user. Please check your network connection.'));
    }
  
}
    Future<Either<JobFailure , bool>> Postjob({required Map<String, String> job}) async{
      final jsonPost = jsonEncode(job);
      
      Map<String, String> header = await CompanyHeader.companyHeader();
      try {
        final response = await  httpClient.post(Uri.parse("$url/job/postjob") , headers:  header, body: jsonPost);
        print(response.statusCode);
        if(response.statusCode == 201){

         
          
          return right(true);
        } else if(response.statusCode == 401){
          return left(InvalidCredentialsFailure("unauthorised!"));
        }
      return left(NetworkFailure("Please check your connection again"));
      } catch (e) {
        print(e);
         return left(NetworkFailure("Please check your connection again"));
      }
    }

   Future<Either<JobFailure, List<Job>>> getPostedJobs() async {
    final header = await CompanyHeader.companyHeader();
        try {
            var response = await httpClient.get(Uri.parse('$url/company/jobsposted') , headers: header,); // ,  headers: headers implement

      if (response.statusCode == 200) {
        
        final parsed = jsonDecode(response.body) as List;
      
        List<Job> jobs = parsed.map((json)=> Job.fromJson(json)).toList();
        await CompanyDatabase.getInstance.deletePostedJobsTable();
        await CompanyDatabase.getInstance.insertPostedJobs(jobs);
      
        return right(jobs);

        
      } else {
        return left(InvalidCredentialsFailure('Authentication failed'));
      }
    } catch (e) {
      print(e);
      return left(NetworkFailure('Failed to authenticate user. Please check your network connection.'));
    }
  }


  Future<Either<JobFailure , bool>> CloseJob(jobId)async{
        final header = await CompanyHeader.companyHeader();
        try {
            final response = await httpClient.patch(Uri.parse('$url/job/closejob/$jobId') , headers: header); 
            if(response.statusCode == 200){
              await CompanyDatabase.getInstance.updatePostedJobStatus(jobId);

             
                return right(true);
            }else if(response.statusCode == 401){
              return left(InvalidCredentialsFailure("Authentication Failed"));
            }
          }catch(e){
              print(e);
              
          }
        return(left(NetworkFailure("Network connection error")));


}

  Future<Either<JobFailure , bool>> OpenJob(jobId)async{
        final header = await CompanyHeader.companyHeader();
        try {
            final response = await httpClient.patch(Uri.parse('$url/job/openjob/$jobId') , headers: header); 
            if(response.statusCode == 200){
              await CompanyDatabase.getInstance.updatePostedJobStatus(jobId);

             
                return right(true);
            }else if(response.statusCode == 401){
              return left(InvalidCredentialsFailure("Authentication Failed"));
            }
          }catch(e){
              print(e);
              
          }
        return(left(NetworkFailure("Network connection error")));


}
    Future<Either< JobFailure , bool>> deleteJobs(jobId)async{
       final headers= await CompanyHeader.companyHeader();
      final response = await httpClient.get(Uri.parse("${BaseUrlAddress().url}/job/deletejob/$jobId") , headers:  headers);
      if(response.statusCode == 200){
        return right(true);
      }else{
        return left(NetworkFailure("network connection"));
      }
    } 
}