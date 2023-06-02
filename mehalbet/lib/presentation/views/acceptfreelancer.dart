
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/user/bloc/user_bloc.dart';
import 'package:jobportal/presentation/widgets/accept_btn.dart';

class AcceptFreelancer extends StatelessWidget {
  const AcceptFreelancer({required this.jobId , required this.freelancerId});
  final String freelancerId;
  final String jobId;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider<FreelancerBloc>(
      create: (context) => FreelancerBloc(),
      child: AcceptBtn(jobId: jobId, freelancerId: freelancerId),
      
    );
  }
}