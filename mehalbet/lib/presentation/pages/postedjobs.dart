import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/job/bloc/job_bloc.dart';
import 'package:jobportal/presentation/views/list_of_jobs.dart';


class PostedJobs extends StatelessWidget {
  const PostedJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
            home :     BlocProvider<JobBloc>(
        create: (context) => JobBloc(),
        child: ListofJobs()
      )
    );
  }
    
}
