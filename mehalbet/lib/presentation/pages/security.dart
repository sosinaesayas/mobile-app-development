import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_bloc.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_event.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_state.dart';
import 'package:jobportal/presentation/views/delete_account.dart';
// import 'package:path/path.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    
      return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(),
      child: PasswordChange(),
   
    );
  }
}



class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void submitPasswordData() {
   
    final passwordData = {
      'oldPassword': _oldPasswordController.text,
      'newPassword': _newPasswordController.text,
    };
   
      BlocProvider.of<ProfileBloc>(context).add(UpdatePasswordRequested(profileData: passwordData));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      print(state.updatepassword);
      if (state.updatepassword == ProfileStatus.unknown || state.updatepassword == ProfileStatus.authenticationFailed) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Change password"),
          ),
          body: Center(
            child: Column(
              children: [
                buildFieldWithIcon(
                  icon: Icons.key_off,
                  label: 'Old password',
                  controller: _oldPasswordController,
                  isInvalid: state.isFirstNameValid,
                ),
                buildFieldWithIcon(
                  icon: Icons.person,
                  label: 'New password',
                  controller: _newPasswordController,
                  isInvalid: state.isLastNameValid,
                ),
                ElevatedButton(
                  onPressed: submitPasswordData,
                  child: state.updatepassword == ProfileStatus.authenticationFailed ? Text('Passwords did not match') : Text("Submit")
                ),
                TextButton(onPressed: (){
                  showDeleteAccountDialog(context , BlocProvider.of<ProfileBloc>(context) , ProfileState());
                }, child: Text("delete account"  , style: TextStyle(color: Colors.red),))
              ],
            ),
          ),
        );
      } else if(state.updatepassword == ProfileStatus.requestSuccessed){
        return  Scaffold(
          appBar: AppBar(
            title: Text("Change password"),
          ),
          body: const Center(
          child: Text("Successfully Updated" , style: 
          TextStyle(
            fontSize: 25 , 
            color: Colors.green
          )
          ,),
        )
          
          );
      }
      return Scaffold(
          appBar: AppBar(
            title: Text("Change password"),
          ),
          body: const Center(
          child: Text("Successfully Updated" , style: 
          TextStyle(
            fontSize: 25 , 
            color: Colors.green
          )
          ,),
        )
          
          );
    });
  }
}





Widget buildFieldWithIcon({
  required IconData icon,
  required String label,
  required TextEditingController controller,
  // required String initialValue,
  required bool isInvalid,
  // required String invalidMessage,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon),
          SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: controller,
              // initialValue: initialValue,
              decoration: InputDecoration(
                labelText: label,
                errorText: !isInvalid ? "Please enter a valid field" : null,
              ),
            ),
          ),
        ],
      ),
      if (!isInvalid)
        Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            "please enter a valid field",
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ),
    ],
  );
}



  void showDeleteAccountDialog(BuildContext  context , ProfileBloc profileBloc , ProfileState profileState) {
    TextEditingController _passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Confirm Account Deletion'),
          content: Text('Are you sure you want to delete your account?'),
          actions: [
             DeleteAccount() , 
               TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('Cancel'),)
          ],
        );
      },
    );
  }

