

abstract class JobEvent{}

class JobsRequested implements JobEvent{}

class AppliedJobsRequested implements JobEvent{}

class JobsSearchRequested implements JobEvent{
    JobsSearchRequested({required this.keyword});
    final String keyword;
}

class GetJobById implements JobEvent{
  GetJobById({required this.jobid});
  final String jobid;
}

class PostJobRequested implements JobEvent{
  PostJobRequested({required this.jobInput});
  final Map<String, String> jobInput;

}

class PostedJobsRequested implements JobEvent{}


class deleteJobRequest implements JobEvent{
  deleteJobRequest({required this.jobId});
  final String jobId;
}