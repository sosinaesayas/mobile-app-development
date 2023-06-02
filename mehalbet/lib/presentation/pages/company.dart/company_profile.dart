import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: ()async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          
      }, child: Text("Log out")),
    );
  }
}