

enum FreelancerStatus {
  RequestInProgress , 
  RequestFailed, 
  RequestSuccess , 
  unknown , 

  
}
class FreelancerState {
  FreelancerState({
    this.freelancers = const [], 
    this.status = FreelancerStatus.unknown , 
    this.appliedstatus = FreelancerStatus.unknown , 
    this.acceptedStatus = FreelancerStatus.unknown  ,
    this.confirm = false
  });
  final List freelancers;
  final FreelancerStatus status;
   final FreelancerStatus acceptedStatus;
final FreelancerStatus appliedstatus;
final bool confirm ;
  FreelancerState copyWith({
    List ? freelancers , 
    FreelancerStatus? status,
     FreelancerStatus? appliedstatus,
     FreelancerStatus? acceptedStatus , 
     bool ? confirm

  }) {
    return FreelancerState(
      freelancers:  freelancers ?? this.freelancers , 
      status: status ?? this.status,
      appliedstatus: appliedstatus ?? this.status , 
      acceptedStatus: acceptedStatus ?? this.acceptedStatus , 
      confirm:  confirm ?? this.confirm
    );
  }
  
}



