abstract class FreelancerEvent{}

class RandomFreelancersRequested implements FreelancerEvent{}

class AppliedFreelancersRequested implements FreelancerEvent{
  AppliedFreelancersRequested({required this.jobId});
  final String jobId;
}

class AcceptFreelancerRequested implements FreelancerEvent{
  AcceptFreelancerRequested({required this.freelancerId , required this.jobid});
  final String freelancerId;
  final String jobid;
}