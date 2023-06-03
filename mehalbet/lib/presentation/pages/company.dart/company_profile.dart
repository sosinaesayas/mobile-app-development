import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/auth_bloc/bloc/auth_bloc.dart';
import 'package:jobportal/presentation/login.dart';
import 'package:go_router/go_router.dart';
import 'package:jobportal/route_names.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../application/profile_bloc/bloc/profile_bloc.dart';
import '../../../application/profile_bloc/bloc/profile_state.dart';



class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
 @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Center(
          child: ElevatedButton(onPressed: ()async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();

         
          context.goNamed(RouteNames.login);
    
      }, child: Text("Log out")),
    );
      },
    );
  }
}