import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/admin_bloc/admin_bloc.dart';
import 'package:jobportal/application/admin_bloc/admin_event.dart';
import 'package:jobportal/application/admin_bloc/admin_state.dart';
import 'package:jobportal/application/user/bloc/user_bloc.dart';
import 'package:jobportal/application/user/bloc/user_event.dart';
import 'package:jobportal/application/user/bloc/user_state.dart';
import 'package:jobportal/domain/user/user_model.dart';

class PendingFreelancers extends StatefulWidget{
  
 const PendingFreelancers({super.key});
@override
  State<PendingFreelancers> createState() => _PendingFreelancersState();
          }



class _PendingFreelancersState extends State<PendingFreelancers> {
  
 
  @override
  void initState(){
    super.initState();
    requestFreelancers();
    
  }

void requestFreelancers() {
    BlocProvider.of<FreelancerBloc>(context).add(PendingFreelancersRequested());
  }
  Widget build(BuildContext context) {
    return BlocBuilder<FreelancerBloc , FreelancerState>(
      builder: (context , state){
        if(state.freelancers == []){
            return const Center(child : Text("no data" , style: TextStyle(color: Colors.white),));
        }else if(state.status == FreelancerStatus.RequestInProgress && state.freelancers.length == 0){ 
          return Center(
            child: Container(
              height: 45,
              width: 45,
              child : CircularProgressIndicator()),
          );
        }else if(state.status == FreelancerStatus.RequestFailed){
          return Center(
            child: Container(
              height: 45,
              width: 45,
              child : Text("Error")),
          );
        }else{
          return ListView.builder(
            itemCount: state.freelancers.length,
            itemBuilder: (context , index){
             final freelancer  = state.freelancers[index];
                return Column(
                  children: [
                    FreelancerCard( freelancer : state.freelancers[index]),
                  BlocBuilder<DeclineBloc , DeclineState>(builder: ( context , state){
      return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
       state.confirm == DeclineStatus.unknown ? 
           ElevatedButton(onPressed:() {
            context.read<DeclineBloc>().add(ConfirmRequested(userId: freelancer.id ));
            setState(() {
              
            });
          },
          
           child: Text("Confirm")) : Text("Confirmed") , 


           ElevatedButton(onPressed:() {
            context.read<DeclineBloc>().add(DeclineRequested(userId: freelancer.id ));
          },
          
           child: Text("Decline"))  
        ],
      ),
    );
    })
                  ],
                );
          }
      
          );
        }
      });
  }
}


class FreelancerCard extends StatelessWidget{
 
  FreelancerCard({required this.freelancer});
  final UserModel freelancer;
  @override
  Widget build(BuildContext context) { 
    return  Container(
      color: Colors.grey[800],
      width: double.infinity,
      
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text("${this.freelancer.firstName}  ${this.freelancer.lastName}" , style: TextStyle(
              fontSize: 16 , 
              fontWeight: FontWeight.w700, 
              color: Colors.white , 
            ),) , 
            Text("Field of study :  ${this.freelancer.department}" , style: TextStyle(
                  fontWeight: FontWeight.w400 ,
                  fontSize: 15, 
                color: Colors.grey[400] , 
            ),), 
           
            Text("Description : ${this.freelancer.description}" , style: TextStyle(
              
                 
                  fontSize: 15, 
                  color: Colors.grey[400]
            ) ), 
            Text("Email : ${this.freelancer.email}" ,style: TextStyle(
              
                  fontStyle: FontStyle.italic,
                  fontSize: 15, 
                  color: Colors.grey[400]
            )), ],
        ),
      ),
    );
  }
  
}


class AdminButtons extends StatefulWidget {
  const AdminButtons({required this.freelancerId});
final String freelancerId;
 
  @override
  State<AdminButtons> createState() => _AdminButtonsState();
}

class _AdminButtonsState extends State<AdminButtons> {
  String btn = "confirm" ;
  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<DeclineBloc , DeclineState>(builder: ( context , state){
      
      
      return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
      
           ElevatedButton(
            onPressed:() {
            context.read<DeclineBloc>().add(ConfirmRequested(userId: widget.freelancerId));
            setState(() {
              btn = "Confirmed";
            });
          },
          
             child: Text("Confirm"
    // state.confirm == DeclineStatus.unknown ? "Confirm" : "Confirmed",
  ),) , 


           ElevatedButton(onPressed:() {
            context.read<DeclineBloc>().add(DeclineRequested(userId: widget.freelancerId));
          },
          
           child: Text("Decline"))  
        ],
      ),
    );
    }
    // );
  // }
}