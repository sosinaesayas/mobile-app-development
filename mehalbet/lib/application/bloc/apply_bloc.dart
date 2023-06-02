
import 'package:bloc/bloc.dart';
import 'package:jobportal/application/bloc/apply_event.dart';
import 'package:jobportal/application/bloc/apply_state.dart';
import 'package:jobportal/infrastructure/jobs/data_sources/api_data_source.dart';



class ApplyBloc extends Bloc<ApplyEvent, ApplyState> {
  ApplyBloc() : super(ApplyState()) {
   
    on<CheckApplied>(_handleCheckApplied);
    on<ApplicationRequested>(_handleApplicationRequested);
  }

  Future<void> _handleCheckApplied(CheckApplied event, Emitter<ApplyState> emit )async{
        JobDataSource api = JobDataSource();

        try {
          emit(state.copyWith(
            status: AppliedStatus.requestInProgress
          ));
          final response = await api.checkApplied(event.id);
          if(response){
            emit(state.copyWith(
              status: AppliedStatus.applied , 
              appliedJobs: [... state.appliedJobs , event.id]

            ));
          
          }else if(response == false){
            emit(state.copyWith(status: AppliedStatus.notApplied , checked: [...state.checked , event.id]));
          }else{
            emit(state.copyWith(status: AppliedStatus.failed));
          }


        } catch (e) {
          print(e);
          throw(e);

        }
  }


  Future<void> _handleApplicationRequested(ApplicationRequested event, Emitter<ApplyState> emit )async{
        JobDataSource api = JobDataSource();

        try {
          emit(state.copyWith(
            status: AppliedStatus.requestInProgress
          ));
          final response = await api.ApplyToJob(event.id);
         
          response.fold((JobFailure) {
              state.copyWith(status: AppliedStatus.failed);
          }, 
          (bool){
            if(bool){
              emit(state.copyWith(status: AppliedStatus.applied , appliedJobs: [...state.appliedJobs , event.id])
            
            );
            }else{
              emit(state.copyWith(status: AppliedStatus.failed , checked: [...state.checked , event.id]));
            }
        }
          );
           
          
 } catch (e) {
          print(e);
          throw(e);

        }
  }
}
