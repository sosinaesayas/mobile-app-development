import 'package:dartz/dartz.dart';
import 'package:jobportal/domain/notification/model/notification_failure.dart';
import 'package:jobportal/domain/notification/model/notifications.dart';


abstract class UserNotificationFacade{
  
  Future<Either<UserNotificationFailure ,List<UserNotification>>> getUserNotifications();
}