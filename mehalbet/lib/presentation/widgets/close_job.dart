import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobportal/application/close_job_bloc/close_job_bloc.dart';
import 'package:jobportal/application/close_job_bloc/close_job_event.dart';
import 'package:jobportal/application/close_job_bloc/close_job_state.dart';
import 'package:jobportal/presentation/widgets/closed_job.dart';
import 'package:jobportal/route_names.dart';

class CloseJob extends StatelessWidget {
   CloseJob({required this.jobId});
  final String jobId;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<CloseJobBloc>(
        create: (context) => CloseJobBloc(),
        child: CloseJobBtn(jobId:  jobId,),
      );
  }
}


class CloseJobBtn extends StatefulWidget {
  const CloseJobBtn({required this.jobId});
  final String jobId;

  @override
  State<CloseJobBtn> createState() => _CloseJobBtnState();
}

class _CloseJobBtnState extends State<CloseJobBtn> {

  

  void closeJob(){
    context.read<CloseJobBloc>().add(closeJobRequested(jobId: widget.jobId));
  }

 
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CloseJobBloc, CloseJobState>(

      builder: (context, state) {
       
        if(state.status == closeJobStatus.requestSuccess){
          const SnackBar(content: Text("Successfully closed the job" , 
          style: TextStyle(color: Colors.white),
          ) , 
           behavior: SnackBarBehavior.floating,
           margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
           duration: Duration(seconds: 4),
          
          );
           return ClosedJob();
       }else if(state.status == closeJobStatus.requestInProgress){
          return ElevatedButton(onPressed: (){}, child: const Text("Closing ..."));
        }else if(state.status == closeJobStatus.unauthorised){
           WidgetsBinding.instance.addPostFrameCallback((_) {
              context.goNamed(RouteNames.login);
           });
        }else if(state.status == closeJobStatus.requestFailed || state.status == closeJobStatus.unknown){
           return  ElevatedButton(onPressed: (){closeJob();}, child: const Text("Close" , style: TextStyle(color: Colors.amber),));
        }
        return const SizedBox(height: 10,);
      },
    );
  }
}