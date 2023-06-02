import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/close_job_bloc/close_job_bloc.dart';
import 'package:jobportal/presentation/widgets/close_job.dart';


class CloseJob extends StatelessWidget {
   CloseJob({required this.jobId});
  final String jobId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CloseJobBloc>(
      create: (context) => CloseJobBloc(),
      child: CloseJobBtn(jobId: this.jobId),
    );
  }
}