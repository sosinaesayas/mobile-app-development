import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:jobportal/domain/notification/model/notification_failure.dart';
import 'package:jobportal/domain/notification/model/notifications.dart';
import 'package:jobportal/domain/notification/repository.dart';
import 'package:jobportal/infrastructure/notification/data_source/api_datasource.dart';
import 'package:jobportal/infrastructure/company/data_base.dart';

class NotificationRepository implements UserNotificationFacade{
   UserNotificationDataSource api = UserNotificationDataSource();
  @override
  Future<Either<UserNotificationFailure , List<UserNotification>>> getUserNotifications() async {
      return await api.getUserNotifications();}
  Future<Either<UserNotificationFailure , bool>> checkConnection(String freelancerId)async{
    try {
      final reponse = await CompanyDatabase.getInstance.checkConnection(freelancerId);
      return reponse == true ? right(true) : right(false);
    } catch (e) {
      return left(DatabaseFailure("failed to fetch from local database"));
    }
  }
}