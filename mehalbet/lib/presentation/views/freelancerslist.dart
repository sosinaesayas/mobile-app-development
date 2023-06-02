import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/user/bloc/user_bloc.dart';
import 'package:jobportal/application/user/bloc/user_event.dart';
import 'package:jobportal/application/user/bloc/user_state.dart';
import 'package:jobportal/domain/user/user_model.dart';
import 'package:jobportal/presentation/widgets/check_connection.dart';

class FreelancersList extends StatefulWidget{
  
 const FreelancersList({super.key});
@override
  State<FreelancersList> createState() => _FreelancersListState();
          }



class _FreelancersListState extends State<FreelancersList> {
  
 
  @override
  void initState(){
    super.initState();
    requestFreelancers();
    
  }

void requestFreelancers() {
    BlocProvider.of<FreelancerBloc>(context).add(RandomFreelancersRequested());
  }
  Widget build(BuildContext context) {
    return BlocBuilder<FreelancerBloc , FreelancerState>(
      builder: (context , state){
        if(state.freelancers == []){
            return const Center(child : Text("no data" , style: TextStyle(color: Colors.white),));
        }else if(state.status == FreelancerStatus.RequestInProgress && state.freelancers.length == 0){ 
          return const Center(child : Text("in progress" , style: TextStyle(color: Colors.white),));
        }else if(state.status == FreelancerStatus.RequestFailed){
          return const Center(child : Text("Error  happened" , style: TextStyle(color: Colors.white),));
        }else{
          return ListView.builder(
            itemCount: state.freelancers.length,
            itemBuilder: (context , index){
                return Column(
                  children: [
                    FreelancerCard( freelancer : state.freelancers[index]),
                    CheckConnection(freelancerId: state.freelancers[index].id)
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
      color: Color.fromARGB(255, 222, 219, 230),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("${this.freelancer.firstName}  ${this.freelancer.lastName}" , style: const TextStyle(
              fontSize: 15 , 
              fontWeight: FontWeight.w700, 
              color: Color.fromARGB(255, 16, 13, 13) , 
            ),) , 
            Text("Field of study :  ${this.freelancer.department}" , style: TextStyle(
                  fontWeight: FontWeight.w400 ,
                  fontSize: 13, 
                  color: Colors.grey[800]
            ),), 
           
            Text("Description : ${this.freelancer.description}" , style: TextStyle(
                  fontWeight: FontWeight.w200 ,
                  fontStyle: FontStyle.italic,
                  fontSize: 13, 
                  color: Colors.grey[800]
            ) ), 
            Text("Email : ${this.freelancer.email}" ,style: TextStyle(
                  fontWeight: FontWeight.w100 ,
                  fontStyle: FontStyle.italic,
                  fontSize: 13, 
                  color: Colors.grey[800]
            )), ],
        ),
      ),
    );
  }
  
}