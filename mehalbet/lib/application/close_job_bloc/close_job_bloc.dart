import 'package:bloc/bloc.dart';
import 'package:jobportal/application/close_job_bloc/close_job_event.dart';
import 'package:jobportal/application/close_job_bloc/close_job_state.dart';
import 'package:jobportal/domain/job/model/job_failure.dart';
import 'package:jobportal/infrastructure/jobs/data_sources/api_data_source.dart';




class CloseJobBloc extends Bloc<CloseJobEvent, CloseJobState > {
    CloseJobBloc() : super(CloseJobState()) {
    on<closeJobRequested>(_handleCloseJobRequested);
    on<openJobRequested>(_handleOpenJobRequested);
  }

  Future<void> _handleCloseJobRequested(closeJobRequested event , Emitter<CloseJobState> emit)async{
        JobDataSource api = JobDataSource();
        final response = await api.CloseJob(event.jobId);
        emit(state.copyWith(status : closeJobStatus.requestInProgress));
        response.fold((l) =>{
            if(l is InvalidCredentialsFailure){
              emit(state.copyWith(status : closeJobStatus.unauthorised))
            }else if(l is NetworkFailure){
              emit(state.copyWith(status : closeJobStatus.requestFailed))
            }
        }, (r) => emit(state.copyWith(status:  closeJobStatus.requestSuccess)));
  }


    Future<void> _handleOpenJobRequested(openJobRequested event , Emitter<CloseJobState> emit)async{
        JobDataSource api = JobDataSource();
        final response = await api.OpenJob(event.jobId);
        emit(state.copyWith(openjob : closeJobStatus.requestInProgress));
        response.fold((l) =>{
            if(l is InvalidCredentialsFailure){
              emit(state.copyWith(openjob : closeJobStatus.unauthorised))
            }else if(l is NetworkFailure){
              emit(state.copyWith(openjob : closeJobStatus.requestFailed))
            }
        }, (r) => emit(state.copyWith(openjob:  closeJobStatus.requestSuccess)));
  }
}
