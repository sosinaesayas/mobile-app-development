import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobportal/application/auth_bloc/bloc/auth_bloc.dart';
import 'package:jobportal/application/auth_bloc/bloc/auth_event.dart';
import 'package:jobportal/application/auth_bloc/bloc/auth_state.dart';
import 'package:jobportal/domain/auth/model.dart';
import 'package:jobportal/route_names.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<AuthBloc, AuthState>(
        
        builder: (contex ,state){
          
          if(state.status == AuthStatus.authenticationSuccess && state.entity == AuthStatus.freelancer){
          
             WidgetsBinding.instance?.addPostFrameCallback((_) {
            context.goNamed(RouteNames.home);
            
          });
          
          }
          else if(state.status == AuthStatus.authenticationSuccess && state.entity == AuthStatus.company){
          
               WidgetsBinding.instance?.addPostFrameCallback((_) {
              context.goNamed(RouteNames.chome);
            
          });
          }
          return  Scaffold(
      backgroundColor : Colors.black,
      body: Center(
        
        child: 
      Padding(
        
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          reverse: true,
          
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("አfalagi" , 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40 , 
                color: Color(0xff888888)
        
              ),
              ), 
              SizedBox(height: 50,),
              Center(
                child : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                            
                                          'email',
                                          style: TextStyle(
                                            
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:  Color(0xff888888),
                                          ),
                              ),
                          ),
                            TextField(
                      style: TextStyle(color: Colors.white),
                   controller: _emailController,
                  decoration: InputDecoration(
                   hintText: "someone@example.com",
                   hintStyle: TextStyle(
                    color: Color.fromARGB(255, 101, 89, 89)
                   ),
                   
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, 
                      width: 4.0 , 
                      
                      
                      ),
                      borderRadius: BorderRadius.circular(14),
                      
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, 
                      width: 4.0),
                       borderRadius: BorderRadius.circular(14),
                    ),
                    prefixIcon: Icon(Icons.phone),
                  ),
                            ),
                            SizedBox(height: 40),
                           
                            Padding(padding: EdgeInsets.all(10), 
                            child : Text(
                  'password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff888888),
                    
                  ),
                            )
                            ),
                            TextField(
                   controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                  
                  hintText: "password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,
                      width: 4.0
                      
                      ),
                       borderRadius: BorderRadius.circular(14),
                    
                   
                    ),
                    
                    enabledBorder: OutlineInputBorder(
                      
                      borderSide: BorderSide(color: Colors.green , 
                      width: 4.0
                      ),
                       borderRadius: BorderRadius.circular(14),
                    ),
                  
                  ),
                  
                            ),
                            SizedBox(height: 16),
                            Center(
                
                  child: ElevatedButton(
                    
                    onPressed: () {
                                    final String email = _emailController.text;
                                    final String password = _passwordController.text;
                                    context.read<AuthBloc>().add(AuthenticationRequestSent(authModel: AuthModel(email: email , password: password)));
                                    
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green, // Set the background color of the button
                    ),
                    ),
                    child: Text('Login' , 
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                    ),
                  ),),
                  TextButton(
                        onPressed: () {
                          context.goNamed(RouteNames.comapanySignup);
                        },
                        child: Text("Sign up as a company?"),
                      ),
                      TextButton(
                        onPressed: () {
                          context.goNamed(RouteNames.signup);
                        },
                        child: Text("Sign up as a freelancer?"),
                      ),
        
                       ],
                  ),
                ))
                
             
             
              
            ],
          ),
        ),
      ),)
    );
        }
      )
    );
  }
}
