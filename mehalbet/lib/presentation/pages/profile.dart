import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobportal/application/auth_bloc/bloc/auth_bloc.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_bloc.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_event.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_state.dart';
import 'package:jobportal/presentation/login.dart';
import 'package:jobportal/presentation/pages/security.dart';
import 'package:jobportal/route_names.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(create: (context) => ProfileBloc(), child: Profile(),);
  }
}



class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  

  @override
  void initState() {
    super.initState();
    // Request initial profile data
    requestProfileData();
  }

  void requestProfileData() {
    // Add an event to request profile data
    BlocProvider.of<ProfileBloc>(context).add(ProfileRequested());
  }

  void submitProfileData() {
    // Prepare profile data to be submitted
    final profileData = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'email': _emailController.text,
      'phoneNumber': _phoneNumberController.text,
    };

   
    BlocProvider.of<ProfileBloc>(context).add(ProfileSubmitRequested(profileData: profileData));
    
   

   
    
  }

  void resetProfileData() {
    // Add an event to reset the profile data
    BlocProvider.of<ProfileBloc>(context).add(ProfileResetRequested());
  }


  void logout(){
    BlocProvider.of<ProfileBloc>(context).add(LogoutRequested());
  }
 void editProfileRequested(){
       BlocProvider.of<ProfileBloc>(context).add(ProfileEditRequested());
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if(state.loginStatus == ProfileStatus.loggedOut){
             context.goNamed(RouteNames.login);
   
            
          }
          if (state.isEditing ) {
            return SingleChildScrollView(
              
              child: Column(
                children: [
                  buildFieldWithIcon(
                    icon: Icons.person,
                    label: 'First Name',
                    controller: _firstNameController,
                    isInvalid: state.isFirstNameValid,
                    
                    // initialValue: state.profileData['firstName'] ?? "",
                  ),
                  buildFieldWithIcon(
                    icon: Icons.person,
                    label: 'Last Name',
                    controller: _lastNameController,
                    isInvalid: state.isLastNameValid,
                    // initialValue: state.profileData['lastName'] ?? "",
                  ),
                  buildFieldWithIcon(
                    icon: Icons.email,
                    label: 'Email',
                    controller: _emailController,
                    isInvalid: state.isEmailValid,
                    // initialValue: state.profileData['email'] ?? "",
                  ),
                  // buildFieldWithIcon(
                  //   icon: Icons.phone,
                  //   label: 'Phone Number',
                  //   controller: _phoneNumberController,
                  //   isInvalid: state.isPhoneNumberValid,
                  //   // initialValue: state.profileData['phoneNumber'] ?? "",
                  // ),
                  ElevatedButton(
                    onPressed: submitProfileData,
                    child: Text('${state.requestStatus == ProfileStatus.requestInProgress ? 'updateing...' : 'update'}'),
                  ),
                ],
              ),
            );
          } else if(state.profileData.isNotEmpty && state.requestStatus == ProfileStatus.requestSuccessed) {
            return Column(
              children: [

                Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                     TextButton(
              child: Text(state.loginStatus == ProfileStatus.loggingOut ? "Logging Out ..."  : "Log out"),
              onPressed: (){
                logout();
                
              },
             
            )
                ],),
                _buildInfoFieldWithIcon(
                  icon: Icons.person,
                  label: 'First Name',
                  value: state.profileData['firstName']?? "",
                ),
                _buildInfoFieldWithIcon(
                  icon: Icons.person,
                  label: 'Last Name',
                  value: state.profileData['lastName']?? "",
                ),
                _buildInfoFieldWithIcon(
                  icon: Icons.email,
                  label: 'Email',
                  value: state.profileData['email']?? "",
                ),
                // _buildInfoFieldWithIcon(
                //   icon: Icons.phone,
                //   label: 'Phone Number',
                //   value: state.profileData['phoneNumber']?? "",
                // ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [ ElevatedButton(
                  onPressed: () {
                     editProfileRequested();



                    setState(() {
                     
                      _firstNameController.text = state.profileData['firstName'] ?? "";
                      _lastNameController.text = state.profileData['lastName'] ?? "";
                      _emailController.text = state.profileData['email']?? "";
                      _phoneNumberController.text = state.profileData['phoneNumber'] ?? "";
                    });
                  },
                  child: Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                     Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return  ChangePassword();
                  },
                ),
              );
                  },
                  child: Text('Security'),
                )
                
                
                ],
               )
              ],
            );
          }else{
            print("request status is");
            print(state.requestStatus);
            return Center(
             child :  TextButton(
              child: Text(state.loginStatus == ProfileStatus.loggingOut ? "Logging Out ..."  : "Log out"),
              onPressed: (){
                logout();
                
              },
             )
            );
          }
        },
      ),
    );
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























  Widget _buildInfoFieldWithIcon({
    required IconData icon,
    required String label,
    required String value,
    
  }) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Expanded(
          child: Text('$label: $value'),
        ),
      ],
    );
  }
}
