import 'package:flutter/material.dart';



class NotificationCard extends StatelessWidget {
  final bool unread;
  final String message;
  final String companyName;

  const NotificationCard({Key? key, required this.unread, required this.message , required this.companyName});
  

  @override
  Widget build(BuildContext context) {
    final backgroundColor = unread ? Colors.grey[300] : const Color.fromARGB(255, 255, 255, 255);
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(

          '${companyName} ${ message}',
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  final List<Map<String, dynamic>> notifications;

  const NotificationList({Key? key, required this.notifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final unread = notification['unread'] ?? false;
          final message = notification['message'] ?? '';
          return NotificationCard(
            unread: unread,
            message: message,
            companyName: unread,
          );
        },
      
    );
  }
}

