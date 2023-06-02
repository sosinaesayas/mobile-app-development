abstract class ApplyEvent{

}

class CheckApplied implements ApplyEvent{
  final String id;

  CheckApplied({required this.id});
}


class ApplicationRequested implements ApplyEvent{
  final String id;
  ApplicationRequested({required this.id});
}