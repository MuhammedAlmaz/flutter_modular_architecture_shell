class EventBusListener {
  final String title;
  final void Function(dynamic data) listener;

  EventBusListener({required this.title, required this.listener});
}
