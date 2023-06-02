import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobportal/application/signup_bloc/signup_bloc.dart';
import 'package:jobportal/application/signup_bloc/signup_event.dart';
import 'package:jobportal/application/signup_bloc/signup_state.dart';
import 'package:jobportal/route_names.dart';

class FreelancerSignup extends StatefulWidget {
  const FreelancerSignup({super.key});

  @override
  State<FreelancerSignup> createState() => _FreelancerSignupState();
}

class _FreelancerSignupState extends State<FreelancerSignup> {
   final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          if(state.usersignup == SignUpStatus.signupSuccess ){
          
             WidgetsBinding.instance?.addPostFrameCallback((_) {
            context.goNamed(RouteNames.login);
            
          });
          
          }
          
          return SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                  ),
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                TextField(
                  controller: retypePasswordController,
                  decoration: InputDecoration(
                    labelText: 'Retype Password',
                  ),
                  obscureText: true,
                ),
                TextField(
                  controller: departmentController,
                  decoration: InputDecoration(
                    labelText: 'Department',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Perform sign up request
                    final Map<String, dynamic> userData = {
                      'firstName': firstNameController.text,
                      'lastName': lastNameController.text,
                      'email': emailController.text,
                      'phone': phoneController.text,
                      'password': passwordController.text,
                      'department': departmentController.text,
                      'description': descriptionController.text,
                    };
                    context.read<SignupBloc>().add(
                          UserSignUpRequested(userdata: userData),
                        );
                  },
                  child: Text('Sign Up'),
                ),
                state.usersignup == SignUpStatus.NetworkFailure ? Text("Network Error Please try again") : SizedBox(height: 3,), 
                 TextButton(
                      onPressed: () {
                        context.goNamed(RouteNames.comapanySignup);
                      },
                      child: Text("Sign up as a company?"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.goNamed(RouteNames.login);
                      },
                      child: Text("have an account ?"),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}




























