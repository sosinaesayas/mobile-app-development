import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/user/bloc/user_bloc.dart';
import 'package:jobportal/application/user/bloc/user_event.dart';
import 'package:jobportal/application/user/bloc/user_state.dart';
import 'package:jobportal/domain/user/user_model.dart';
import 'package:jobportal/presentation/views/acceptfreelancer.dart';
import 'package:jobportal/presentation/views/freelancerslist.dart';

class AppliedFreelancers extends StatelessWidget {
  const AppliedFreelancers({required this.jobid});
  final String jobid;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  BlocProvider<FreelancerBloc>(create: (context) => FreelancerBloc() , child : FreelancersPage(jobid:  this.jobid,),),
    );
  }
}

class FreelancersPage extends StatefulWidget {
  const FreelancersPage({required this.jobid});
  final String jobid;
  @override
  State<FreelancersPage> createState() => _FreelancersPageState();
}

class _FreelancersPageState extends State<FreelancersPage> {
  @override
  void initState(){
    requestFreelancers();
    super.initState();
  }
  
  void requestFreelancers(){
    context.read<FreelancerBloc>().add(AppliedFreelancersRequested(jobId: widget.jobid));
  }
  

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Applicants"),
      ),
      body: BlocBuilder<FreelancerBloc, FreelancerState>(
        builder: (context, state) {
           if(state.freelancers.isEmpty && state.appliedstatus == FreelancerStatus.RequestSuccess){
            return const Center(child : Text("No one applied for the job yet" , style: TextStyle(color: Color.fromARGB(255, 12, 12, 12)),));
          }else if(state.status == FreelancerStatus.RequestInProgress && state.freelancers.length == 0){ 
          return const Center(child : CircularProgressIndicator());
        }else if(state.status == FreelancerStatus.RequestFailed){
          return const Center(child : Text("Can't load the data, check your connection" , style: TextStyle(color: Colors.white),));
        }else{
          return ListView.builder(
            itemCount: state.freelancers.length,
            
            itemBuilder: (context , index){
              UserModel freelancer = state.freelancers[index];
                return Column(
                  children: [
                    FreelancerCard( freelancer : state.freelancers[index]),
                    state.freelancers[index].acceptance == "Pending" ? 
                    AcceptFreelancer(jobId: widget.jobid, freelancerId: freelancer.id) :  ElevatedButton(onPressed: (){}, 
    style: ElevatedButton.styleFrom(
    backgroundColor : Colors.grey[800], // Set the background color
    foregroundColor: Colors.grey, // Set the text color
  ),
  child: Text("Accepted"),
    
    )
                  ],
                );
          }
      
          );
        }
        },
      ),
    );
  }
}