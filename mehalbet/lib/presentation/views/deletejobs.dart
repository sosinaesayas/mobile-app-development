
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/job/bloc/job_bloc.dart';
import 'package:jobportal/presentation/widgets/deleteBtn.dart';

class DeleteJob extends StatelessWidget {
  const DeleteJob({required this.jobId });
  final String jobId;
  
  @override
  Widget build(BuildContext context) {
    return  BlocProvider<JobBloc>(
      create: (context) => JobBloc(),
      child: DeleteBtn(jobid: jobId,),
      
    );
  }
}