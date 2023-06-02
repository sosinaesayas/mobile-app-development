import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/job/bloc/job_bloc.dart';
import 'package:jobportal/application/job/bloc/job_event.dart';
import 'package:jobportal/application/job/bloc/job_state.dart';

class DeleteBtn extends StatefulWidget {
  const DeleteBtn({required this.jobid});
  final String jobid;

  @override
  State<DeleteBtn> createState() => _DeleteBtnState();
}

class _DeleteBtnState extends State<DeleteBtn> {
  void deleteJob(){
      context.read<JobBloc>().add(deleteJobRequest(jobId: widget.jobid));
      print("emitted");
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobsState>(
      builder: (context, state) {
        return state.deletejobs == JobsStatus.requestSuccess ? Text("deleted", style: TextStyle(fontSize: 14 , color: Colors.red),) :  ElevatedButton(onPressed: 
        deleteJob, child:  Text("delete"));
      },
    );
  }
}