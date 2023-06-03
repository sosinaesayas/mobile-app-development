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


class PendingFreelancersRequested implements FreelancerEvent{}

class ConfirmFreelancerRequested implements FreelancerEvent{
  ConfirmFreelancerRequested({required this.freelancerId});
  final String freelancerId;
}

class DeclineFreelancerRequested implements FreelancerEvent{
  DeclineFreelancerRequested({required this.freelancerId});
  final String freelancerId;
}