import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/auth_bloc/bloc/auth_bloc.dart';
import 'package:jobportal/presentation/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: ()async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return  BlocProvider<AuthBloc>(
                    create: (context) => AuthBloc(),
                    child: Login(),
                  )
                  
                  
                  ;
                },
              ),
            );
          
      }, child: Text("Log out")),
    );
  }
}