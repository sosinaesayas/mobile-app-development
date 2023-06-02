import 'package:shared_preferences/shared_preferences.dart';

class CompanyHeader{
 static Future<Map<String , String>> companyHeader() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String , String> header = {
      "Content-type" : "application/json", 
      "x-access-token" : prefs.getString("company_token") ?? ""
    };

    return header;
}
}