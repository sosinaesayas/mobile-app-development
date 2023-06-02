import 'package:jobportal/domain/notification/model/notifications.dart';

enum NotificationStatus{
    unknown, 
    requestInProgress , 
    requestSuccess , 
    authenticationFailed , 
    NetworkFailure
    }

class NotificationState{
  
  NotificationState({
    this.notifications = const [] ,
    this.status = NotificationStatus.unknown
  });

  final  List<UserNotification> notifications;
  final NotificationStatus status;

  NotificationState copyWith(
      {List<UserNotification> ? notifications,
      NotificationStatus ? status} )=>NotificationState(
        notifications :  notifications ?? this.notifications, 
      status : status ?? this.status      
    );
}