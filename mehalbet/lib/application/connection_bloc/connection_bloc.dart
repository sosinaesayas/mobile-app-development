import 'package:bloc/bloc.dart';
import 'package:jobportal/application/connection_bloc/connection_event.dart';
import 'package:jobportal/application/connection_bloc/connection_state.dart';
import 'package:jobportal/infrastructure/notification/data_source/api_datasource.dart';
import 'package:jobportal/infrastructure/notification/repository.dart';



class ConnectionBloc extends Bloc<ConnectionEvent, UserConnectionState> {
  ConnectionBloc() : super(UserConnectionState()) {
    on<ConnectionEvent>((event, emit) {});
    on<CheckConnectionEvent>(_handleConnectionRequest);
    on<MakeConnection>(_handleMakeConnection);
  }


  Future<void> _handleConnectionRequest(CheckConnectionEvent event, Emitter<UserConnectionState> emit)async{
 try {
    NotificationRepository localcheck = NotificationRepository();
    final localres = await localcheck.checkConnection(event.freelancerId);
    emit(state.copyWith(status:  ConnectionStatus.requestInProgress));
   
    localres.fold((failed)
     {},
    
     (ri){});
  
    UserNotificationDataSource api = UserNotificationDataSource();
    final remoteres = await api.CheckConnection(freelancerId: event.freelancerId);
   
    remoteres.fold((l){
    emit(state.copyWith(status: ConnectionStatus.requestFailed));
    }, (r) { 
     r == true ? emit(state.copyWith(status: ConnectionStatus.requested)) : emit(state.copyWith(status: ConnectionStatus.notRequested));
     
    }
    );
  
 } catch (e) {
  print(e);  
 }  
}


Future<void> _handleMakeConnection(MakeConnection event, Emitter<UserConnectionState> emit)async{
   UserNotificationDataSource api = UserNotificationDataSource();
   try {
     
    emit(state.copyWith(status:  ConnectionStatus.requestInProgress));
    final res = await api.createNotification(kind: "connect", userId: event.freelancerId);
    res.fold((l){
      emit(state.copyWith(status: ConnectionStatus.requestFailed));
    }, (r) {
       r == true ? emit(state.copyWith(status: ConnectionStatus.requested)) : emit(state.copyWith(status: ConnectionStatus.notRequested));
    });
   } catch (e) {
     print(e);
   }
}

}