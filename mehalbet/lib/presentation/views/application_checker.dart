import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/bloc/apply_bloc.dart';
import 'package:jobportal/application/bloc/apply_event.dart';
import 'package:jobportal/application/bloc/apply_state.dart';

class CheckApplication extends StatelessWidget {
  const CheckApplication({required this.jobId});
  final  String jobId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApplyBloc>(create: (context) => ApplyBloc() , child: ApplyWidget(jobId : this.jobId));
  }
}


class ApplyWidget extends StatefulWidget {
  const ApplyWidget({required this.jobId});
  final String jobId;
  @override
  State<ApplyWidget> createState() => _ApplyWidgetState();
}

class _ApplyWidgetState extends State<ApplyWidget> {
  @override
  void initState() {
    checkApplied();

  }
  void checkApplied(){
    BlocProvider.of<ApplyBloc>(context).add(CheckApplied(id: widget.jobId));
  }

  void applytojob(jobid){
    BlocProvider.of<ApplyBloc>(context).add(ApplicationRequested(id : jobid));
  }
  @override

  Widget build(BuildContext context) {
   return BlocBuilder<ApplyBloc , ApplyState>( builder: (context, state){
         if( state.status == AppliedStatus.applied || state.appliedJobs.contains(widget.jobId)){
          return Text("Applied", style: TextStyle(color: Colors.amberAccent)); }
        else if(state.status == AppliedStatus.requestInProgress){
          return CircularProgressIndicator();
        }else if(state.status == AppliedStatus.notApplied){
          return TextButton(onPressed: (){applytojob(widget.jobId);}, child: Text("Apply ",
                         style: TextStyle(color:  Colors.amberAccent)));
        }else{
            return Text( " ");
        }
    
   }
   
    ,);
  }
}