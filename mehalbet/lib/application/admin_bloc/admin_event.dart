
abstract class DeclineEvent {
  const DeclineEvent();

}


class DeclineRequested implements DeclineEvent{
  DeclineRequested({required this.userId});
  final String userId;
}


class ConfirmRequested implements DeclineEvent{
  ConfirmRequested({required this.userId});
  final String userId;
}