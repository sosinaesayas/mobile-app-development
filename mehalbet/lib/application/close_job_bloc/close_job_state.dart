enum closeJobStatus {
  requestInProgress, 
  requestSuccess ,
  requestFailed,
  unknown, 
  unauthorised

}

class CloseJobState  {
  CloseJobState({
    this.status = closeJobStatus.unknown,
    this.openjob = closeJobStatus.unknown
  });

  final closeJobStatus status ;
 final closeJobStatus openjob;
  CloseJobState copyWith(
    {closeJobStatus ? status , 
      closeJobStatus ? openjob
    }
  )=> CloseJobState(
      status: status ?? this.status , 
      openjob: openjob ?? this.openjob
  );
}

