import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobportal/application/close_job_bloc/close_job_bloc.dart';
import 'package:jobportal/application/close_job_bloc/close_job_event.dart';
import 'package:jobportal/application/close_job_bloc/close_job_state.dart';
import 'package:jobportal/presentation/widgets/closed_job.dart';
import 'package:jobportal/route_names.dart';

class OpenJob extends StatelessWidget {
   OpenJob({required this.jobId});
  final String jobId;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<CloseJobBloc>(
        create: (context) => CloseJobBloc(),
        child: OpenJobBtn(jobId:  jobId,),
      );
  }
}


class OpenJobBtn extends StatefulWidget {
  const OpenJobBtn({required this.jobId});
  final String jobId;

  @override
  State<OpenJobBtn> createState() => _OpenJobBtnState();
}

class _OpenJobBtnState extends State<OpenJobBtn> {

  

  void openJob(){
    context.read<CloseJobBloc>().add(openJobRequested(jobId: widget.jobId));
  }

 
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CloseJobBloc, CloseJobState>(

      builder: (context, state) {
       
        if(state.openjob == closeJobStatus.requestSuccess){
          const SnackBar(content: Text("Successfully opened the job" , 
          style: TextStyle(color: Colors.white),
          ) , 
           behavior: SnackBarBehavior.floating,
           margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
           duration: Duration(seconds: 4),
          
          );
           return ElevatedButton(onPressed: (){}, child: const Text("Opened"));
       }else if(state.openjob == closeJobStatus.requestInProgress){
          return ElevatedButton(onPressed: (){}, child: const Text("Opening ..."));
        }else if(state.status == closeJobStatus.unauthorised){
           WidgetsBinding.instance.addPostFrameCallback((_) {
              context.goNamed(RouteNames.login);
           });
        }else if(state.openjob == closeJobStatus.requestFailed || state.status == closeJobStatus.unknown){
           return  ElevatedButton(onPressed: (){openJob();}, child: const Text("Open" , style: TextStyle(color: Colors.amber),));
        }
        return const SizedBox(height: 10,);
      },
    );
  }
}