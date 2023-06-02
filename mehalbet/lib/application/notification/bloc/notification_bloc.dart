import 'package:bloc/bloc.dart';
import 'package:jobportal/application/notification/bloc/notification_state.dart';
import 'package:jobportal/application/notification/bloc/notification_event.dart';
import 'package:jobportal/domain/notification/model/notification_failure.dart';
import 'package:jobportal/domain/notification/model/notifications.dart';
import 'package:jobportal/infrastructure/notification/data_source/api_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:jobportal/infrastructure/util/data_base.dart';

class NotificationBloc extends Bloc<NotificationEvent , NotificationState> {
  NotificationBloc() : super(NotificationState()) {
    on<NotificationEvent>((event, emit) {
    });
     on<NotificationsRequested>(_handleNotificationsRequested);

  }


    Future<void> _handleNotificationsRequested(NotificationsRequested event , Emitter<NotificationState> emit)async {
   
    UserNotificationDataSource notificationapi = UserNotificationDataSource();
    List<UserNotification> localNotifications = await MehalbetDatabase.getInstance.getUserNotifications();
    try {
         emit(state.copyWith(
        status: NotificationStatus.requestInProgress , 
        notifications: localNotifications
      ));
      final Either<UserNotificationFailure, List<UserNotification>> response = await notificationapi.getUserNotifications();
      

      response.fold(
        (failure) {
          if (failure is InvalidCredentialsFailure) {
            print("Invalid credentials!");
            print(failure.message);
            emit(state.copyWith(status: NotificationStatus.authenticationFailed));
          } else if (failure is NetworkFailure) {
            print("Network error!");
            print(failure.message);
            emit(state.copyWith(status: NotificationStatus.NetworkFailure));
          } else {
            print("Unknown failure occurred");
            emit(state.copyWith(status: NotificationStatus.unknown));
          }
        },
        (Notifications) {
          print("Authenticated!");
          print(Notifications);
          emit(state.copyWith(status: NotificationStatus.requestSuccess , 
          notifications: Notifications,
          ));



          print("the state is emitted!");
        });

    } catch (e) {
      
         print("Network error!");
      emit(state.copyWith(status: NotificationStatus.unknown));

    }
      }

}
