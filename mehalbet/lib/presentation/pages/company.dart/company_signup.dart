import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobportal/application/signup_bloc/signup_bloc.dart';
import 'package:jobportal/application/signup_bloc/signup_event.dart';
import 'package:jobportal/application/signup_bloc/signup_state.dart';
import 'package:jobportal/route_names.dart';
class CompanySignup extends StatefulWidget {
  const CompanySignup({super.key});

  @override
  State<CompanySignup> createState() => _CompanySignupState();
}

class _CompanySignupState extends State<CompanySignup> {
  final TextEditingController companyNameContoller = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  void redirectUser(){

  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: BlocBuilder<SignupBloc, SignupState>(
        
        builder: (context, state) {
        

             if(state.companysignup == SignUpStatus.signupSuccess ){
          
             WidgetsBinding.instance?.addPostFrameCallback((_) {
            context.goNamed(RouteNames.login);
            
          });
          
          }
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: companyNameContoller,
                  decoration: InputDecoration(
                    labelText: 'Company Name',
                  ),
                ),
                
              
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
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
              
               
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Perform sign up request
                    final Map<String, dynamic> userData = {
                      'name': companyNameContoller.text,
                       'email': emailController.text,
                      'password': passwordController.text,
                    };
                    print("added");
                    print(state.companysignup);
                    context.read<SignupBloc>().add(
                          CompanySignUpRequested(userdata: userData),
                        );
                  },
                  child: state.companysignup  == SignUpStatus.requested ? Text("Signing up ...") : Text("Sign up"),
                 
                ),
               Text( "${state.companysignup == SignUpStatus.NetworkFailure ? "Network failed, please try again"  : ""}", style: TextStyle(color: Colors.red)),
                          TextButton(
                      onPressed: () {
                        context.goNamed(RouteNames.signup);
                      },
                      child: Text("Sign up as a freelancer?"),
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
