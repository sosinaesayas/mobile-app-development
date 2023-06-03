import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_bloc.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_event.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_state.dart';
import 'package:jobportal/route_names.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(),
      child: DeleteProfile(),
    );
  }
}

class DeleteProfile extends StatefulWidget {
  const DeleteProfile({super.key});

  @override
  State<DeleteProfile> createState() => _DeleteProfileState();
}

class _DeleteProfileState extends State<DeleteProfile> {
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
           TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Enter your password',
              ),
              obscureText: true,
            ),
            TextButton(
              onPressed: () {
                // Perform delete account action here
                BlocProvider.of<ProfileBloc>(context).add(deleteAccountRequested(passwordData: _passwordController.text));

              },
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  
           
                  if(state.deleteAccont == ProfileStatus.authenticationFailed){
                    return Text("deleting ... " );
                  }else if(state.deleteAccont == ProfileStatus.authenticationFailed){
                    return Text("Incorrect password" , style: TextStyle(color: Colors.red));
                  }else if(state.deleteAccont == ProfileStatus.requestSuccessed){
                       WidgetsBinding.instance.addPostFrameCallback((_) async{
                        BlocProvider.of<ProfileBloc>(context).add(LogoutRequested());
                          context.goNamed(RouteNames.login);
                       });
                  };
                           return Text('Delete' , style: TextStyle(color: Colors.red),);
                },
              ),
            ),
          
            
        ],
      ),
    );
  }
}