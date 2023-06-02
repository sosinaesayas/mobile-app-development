
abstract class CloseJobEvent {
  const CloseJobEvent();

}


class closeJobRequested implements CloseJobEvent{
  closeJobRequested({required this.jobId});
  final String jobId;
}


class openJobRequested implements CloseJobEvent{
  openJobRequested({required this.jobId});
  final String jobId;
}