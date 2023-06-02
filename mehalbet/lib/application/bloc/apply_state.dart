enum AppliedStatus{
  requestInProgress, 
  failed , 
  applied , 
  notApplied,
  unknown


}

class ApplyState{
    ApplyState({
    
    this.status = AppliedStatus.unknown,
    this.appliedJobs = const [], 
    this.checked = const  [],
  });

  final AppliedStatus status;
  final List<String> appliedJobs;
  final List<String> checked;
  ApplyState copyWith(
   { AppliedStatus? status, 
   List<String> ? appliedJobs, 
   List<String> ? checked
   }
  ) => ApplyState(status: status?? this.status , appliedJobs: appliedJobs ?? this.appliedJobs , checked: checked ?? this.checked);
}