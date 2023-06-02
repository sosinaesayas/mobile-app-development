import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/user/bloc/user_bloc.dart';
import 'package:jobportal/application/user/bloc/user_event.dart';
import 'package:jobportal/application/user/bloc/user_state.dart';

class AcceptBtn extends StatefulWidget {
  const AcceptBtn({required this.jobId , required this.freelancerId});
  final String freelancerId;
  final String jobId;

  @override
  State<AcceptBtn> createState() => _AcceptBtnState();
}

class _AcceptBtnState extends State<AcceptBtn> {
  void acceptFreelancer(){
    context.read<FreelancerBloc>().add(AcceptFreelancerRequested(freelancerId: widget.freelancerId, jobid: widget.jobId));
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FreelancerBloc, FreelancerState>(
      builder: (context, state) {
        if(state.acceptedStatus == FreelancerStatus.RequestFailed){
          return ElevatedButton(onPressed: acceptFreelancer, child: Text("Try again") , 
          style: ElevatedButton.styleFrom(
    backgroundColor : Colors.grey[800],
    foregroundColor: Color.fromARGB(255, 174, 85, 85), 
  ),
          );

        }else if(state.acceptedStatus == FreelancerStatus.RequestInProgress){
              return ElevatedButton(onPressed: acceptFreelancer, child: Text("Accepting..."),
              style: ElevatedButton.styleFrom(
              backgroundColor : Colors.grey[800],
              foregroundColor: Colors.grey, 
  ),
              );
        }else if(state.acceptedStatus == FreelancerStatus.unknown){
          return ElevatedButton(onPressed: acceptFreelancer, child: Text("Accept"),
              style: ElevatedButton.styleFrom(
              backgroundColor : Colors.green[800],
              foregroundColor: Colors.grey, 
  ),
              );
        }
        return ElevatedButton(onPressed: (){}, child: Text("Accepted"),
              style: ElevatedButton.styleFrom(
              backgroundColor : Colors.grey[800],
              foregroundColor: Colors.grey, 
  ),
              );
      },
    );
  }
}