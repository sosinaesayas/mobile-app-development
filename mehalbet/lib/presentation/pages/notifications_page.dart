import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobportal/application/notification/bloc/notification_bloc.dart';
import 'package:jobportal/application/notification/bloc/notification_event.dart';
import 'package:jobportal/application/notification/bloc/notification_state.dart';
import 'package:jobportal/domain/notification/model/notifications.dart';
import 'package:jobportal/presentation/views/notifications.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  
  @override
  Widget build(BuildContext context) {
    return     BlocProvider<NotificationBloc>(
        create: (context) => NotificationBloc(),
        child: const UserNotificationList(),
    
    );
  }
}




class UserNotificationList extends StatefulWidget {
  const UserNotificationList({super.key});

  @override
  State<UserNotificationList> createState() => _UserNotificationListState();
}

class _UserNotificationListState extends State<UserNotificationList> {
  late NotificationBloc notificationBloc; // Declare the NotificationBloc instance

  @override
  void initState() {
    super.initState();
    requestNotification();
  }

  void requestNotification(){
      context.read<NotificationBloc>().add(NotificationsRequested());
  }
  @override
  Widget build(BuildContext context) {
    return Container(
         
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {



 if(state.status == NotificationStatus.requestSuccess){
            final List<UserNotification> notifications = state.notifications;
            return  ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final unread = notification.unread ;
          final message = notification.message ;
          final companyName = notification.companyName ;
          return NotificationCard(
            unread: unread,
            message: message,
            companyName : companyName
          );
        },
      );
           }
  else if(state.status == NotificationStatus.requestInProgress){
        final notifications = state.notifications  ;
            return state.notifications.isNotEmpty ?
            
               Column(
                children: [

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                          
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];
                            final unread = notification.unread ;
                            final message = notification.message ;
                            final companyName = notification.companyName ;
                            return NotificationCard(
                              unread: unread,
                              message: message,
                              companyName : companyName
                            );
                          },
                        ),
                  ) , 

      CircularProgressIndicator()
    ], ) : 
            
              CircularProgressIndicator(); 
           
           }
 
      else{
        final notifications  =  state.notifications;
        return state.notifications.isNotEmpty  ?   Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];
                            final unread = notification.unread ;
                            final message = notification.message ;
                            final companyName = notification.companyName;
                            return NotificationCard(
                              unread: unread,
                              message: message,
                              companyName : companyName
                            );
                          },
                        ),
                  ) ,
       Positioned(
                    bottom: 20,
                    width: MediaQuery.of(context).size.width,
                    child:  Text("Network error!", 

                    style: const TextStyle(
                      backgroundColor: Colors.white10,
                      color: Color.fromARGB(255, 232, 222, 222)
                    ),
                    ))], ) :  
                    
                     Center( child: Column(
                children: [
                 Text("Network Error" , 
                 
                style: TextStyle(
                  backgroundColor : Colors.white12,
                  fontSize: 12 , 
                  fontWeight: FontWeight.w500 , 
                  color: Colors.amber,), 
                ),
                IconButton(onPressed: (){requestNotification();}
                ,
                 icon: Icon(Icons.arrow_circle_left_outlined))
                
                
                
                ]
              ), ); 
        
      }

  }
   )
    );
  }
   
    }