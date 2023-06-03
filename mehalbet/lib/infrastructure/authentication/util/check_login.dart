import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isAdmin() async {
  
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("admin");
  return token != null;
}

Future<bool> isFreelancer() async {
  
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  return token != null;
}


Future<bool> isCompany() async {
  
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("company_token");
  return token != null;
}


