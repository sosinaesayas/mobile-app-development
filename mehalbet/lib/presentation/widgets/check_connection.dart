
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/connection_bloc/connection_bloc.dart';
import 'package:jobportal/application/connection_bloc/connection_event.dart';
import 'package:jobportal/application/connection_bloc/connection_state.dart';

class CheckConnection extends StatelessWidget {
   CheckConnection({required this.freelancerId});
  final String freelancerId;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider<ConnectionBloc>(
        create: (context) => ConnectionBloc(),
        child: ConnectionButton(freelancerId : freelancerId),
      );
  }
}


class ConnectionButton extends StatefulWidget {
  const ConnectionButton({required this.freelancerId});
  final String freelancerId;

  @override
  State<ConnectionButton> createState() => _ConnectionButtonState();
}

class _ConnectionButtonState extends State<ConnectionButton> {

  @override
  void initState() {
   
    checkConnection();
  super.initState();
  }

  void checkConnection(){
    context.read<ConnectionBloc>().add(CheckConnectionEvent(freelancerId: widget.freelancerId));
  }

  void sendConnectionRequest(){
    print("event emitted");
     context.read<ConnectionBloc>().add(MakeConnection(freelancerId: widget.freelancerId));
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionBloc , UserConnectionState>(builder: 
    (context , state){

      if(state.status == ConnectionStatus.unknown){
        return SizedBox(height: 15,);
      }else if(state.status == ConnectionStatus.notRequested){
        return OutlinedButton(onPressed: (){
            sendConnectionRequest();
        }, child: const Text("Connect" , style: TextStyle(
          fontSize: 17, 
          color: Colors.white
        ),));
      }else if(state.status == ConnectionStatus.requestInProgress){
        
        return Container(
          height: 17,
          child: CircularProgressIndicator(),
        );
      }
     else if(state.status == ConnectionStatus.requested){
      return   OutlinedButton(onPressed: (){

        }, child: Text("Connection request sent"));
     }
     return Container();



    }
    
    );
  }
}