import 'package:bloc/bloc.dart';
import 'package:jobportal/application/admin_bloc/admin_event.dart';
import 'package:jobportal/application/admin_bloc/admin_state.dart';
import 'package:jobportal/application/close_job_bloc/close_job_event.dart';
import 'package:jobportal/application/close_job_bloc/close_job_state.dart';
import 'package:jobportal/domain/job/model/job_failure.dart';
import 'package:jobportal/infrastructure/jobs/data_sources/api_data_source.dart';
import 'package:jobportal/infrastructure/user/data_sources/api_data_source.dart';




class DeclineBloc extends Bloc<DeclineEvent, DeclineState > {
    DeclineBloc() : super(DeclineState()) {
    on<DeclineRequested>(_handleDeclineRequested);
    on<ConfirmRequested>(_handleconfirmRequested);
  }

  Future<void> _handleDeclineRequested(DeclineRequested event , Emitter<DeclineState> emit)async{
        UserApiDataSource api = UserApiDataSource();
         final response = await api.declineFreelancer(event.userId);
        emit(state.copyWith(confirm : DeclineStatus.requestInProgress));
        response.fold((l) =>{
            if(l is InvalidCredentialsFailure){
              emit(state.copyWith(confirm : DeclineStatus.unauthorised))
            }else if(l is NetworkFailure){
              emit(state.copyWith(confirm : DeclineStatus.requestFailed))
            }
        }, (r) => emit(state.copyWith(confirm:  DeclineStatus.requestSuccess)));
  }
  
  


    Future<void> _handleconfirmRequested(ConfirmRequested event , Emitter<DeclineState> emit)async{
        UserApiDataSource api = UserApiDataSource();
        final response = await api.confirmFreelancer(event.userId);
        emit(state.copyWith(confirm : DeclineStatus.requestInProgress));
        response.fold((l) =>{
            if(l is InvalidCredentialsFailure){
              emit(state.copyWith(confirm : DeclineStatus.unauthorised))
            }else if(l is NetworkFailure){
              emit(state.copyWith(confirm : DeclineStatus.requestFailed))
            }
        }, (r) => emit(state.copyWith(confirm:  DeclineStatus.requestSuccess)));
  }
}
