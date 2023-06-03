import 'package:bloc/bloc.dart';
import 'package:jobportal/application/user/bloc/user_event.dart';
import 'package:jobportal/application/user/bloc/user_state.dart';
import 'package:jobportal/domain/user/user_failure.dart';
import 'package:jobportal/infrastructure/user/data_sources/api_data_source.dart';
import 'package:jobportal/infrastructure/user/user_repository.dart';

class FreelancerBloc extends Bloc<FreelancerEvent, FreelancerState> {
  FreelancerBloc() : super(FreelancerState()) {
    on<FreelancerEvent>((event, emit) {});
    on<RandomFreelancersRequested>(_handleFreelancersRequested);
    on<AppliedFreelancersRequested>(_handleAppliedFreelancersRequested);
    on<AcceptFreelancerRequested>(_handleAcceptFreelancerRequested);
    on<PendingFreelancersRequested>(_handlePendingFreelancersRequested);
    
  }

  _handleFreelancersRequested(RandomFreelancersRequested event , Emitter<FreelancerState> emit)async{

    
    UserRepository userRepo = UserRepository();
    final localFreelancers = await userRepo.getLocalFreelancers();
    localFreelancers.fold((userfailure) => emit(state.copyWith(
      status: FreelancerStatus.RequestInProgress )) , 
    (freelancerslist) => emit(state.copyWith(
      status: FreelancerStatus.RequestInProgress, 
      freelancers: freelancerslist
    )));
  
    UserApiDataSource api = UserApiDataSource();
    final result =   await api.getRandomFreelancers();
    result.fold((failure) =>
    emit(state.copyWith(status: FreelancerStatus.RequestFailed)) 
    , (freelancers) => emit(state.copyWith(status: FreelancerStatus.RequestSuccess , freelancers: freelancers) ) );
    
  }

  Future<void> _handleAppliedFreelancersRequested(AppliedFreelancersRequested event, Emitter<FreelancerState> emit)async{
      UserApiDataSource api = UserApiDataSource();
      emit(state.copyWith(
      status: FreelancerStatus.RequestInProgress ));
      final response = await api.getAppliedFreelancers(event.jobId);

      response.fold((l)
      {
          if(l is NetworkFailure){
            emit(state.copyWith(appliedstatus: FreelancerStatus.RequestFailed));
          }
      },
       (r) => emit(state.copyWith(appliedstatus: FreelancerStatus.RequestSuccess , freelancers: r)));
  }




  Future<void> _handleAcceptFreelancerRequested(AcceptFreelancerRequested event, Emitter<FreelancerState> emit)async{
   UserApiDataSource api = UserApiDataSource();
   try {
     
    emit(state.copyWith(acceptedStatus:  FreelancerStatus.RequestInProgress));
    final res = await api.acceptFreelancer(event.jobid, event.freelancerId);
    res.fold((l){
      emit(state.copyWith(acceptedStatus: FreelancerStatus.RequestFailed));
    }, (r) {
       r == true ? emit(state.copyWith(acceptedStatus: FreelancerStatus.RequestSuccess)) : emit(state.copyWith(status: FreelancerStatus.RequestFailed));
    });
   } catch (e) {
     print(e);
   }
}
 Future<void> _handlePendingFreelancersRequested(PendingFreelancersRequested event, Emitter<FreelancerState> emit)async{
      UserApiDataSource api = UserApiDataSource();
      emit(state.copyWith(
      status: FreelancerStatus.RequestInProgress ));
      final response = await api.getPendingFreelncers();

      response.fold((l)
      {
          if(l is NetworkFailure){
            emit(state.copyWith(appliedstatus: FreelancerStatus.RequestFailed));
          }
      },
       (r) => emit(state.copyWith(appliedstatus: FreelancerStatus.RequestSuccess , freelancers: r)));
  }


}
