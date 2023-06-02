import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/user/bloc/user_bloc.dart';
import 'package:jobportal/presentation/views/freelancerslist.dart';


class Freelancers extends StatelessWidget {
  const Freelancers({super.key});

  @override
  Widget build(BuildContext context) {
   
    return 
  MaterialApp(home:   BlocProvider<FreelancerBloc> (
    create: (context) => FreelancerBloc() ,
    child : const FreelancersList(),),);


    
  }
}

