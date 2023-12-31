import 'dart:async';
import 'package:shell/helpers/event_bus/event.dart';

class EventBus {
  static final EventBus _EventBus = EventBus._internal();
  final Map<String, List<void Function(dynamic data)>> _listeners = {};

  final _controller = StreamController<EventBusEvent>();

  Stream<EventBusEvent> get stream => _controller.stream;

  factory EventBus() {
    return _EventBus;
  }

  EventBus._internal() {
    _controller.stream.listen((event) {
      print("Event Bus Listen Triggered: ${event.title} ${event.data}");
      List<void Function(dynamic data)>? listeners = _listeners[event.title];
      if (listeners != null && listeners.isNotEmpty) {
        for (final void Function(dynamic data) listener in listeners) {
          listener(event.data);
        }
      }
    });
  }

  send(String title, dynamic data) {
    print("Event Bus Sending Data: ${title} ${data}");
    _controller.add(EventBusEvent(title: title, data: data));
  }

  subscribe(String title, void Function(dynamic data) listener) {
    print("Event Bus Subscribed: ${title}");
    if (_listeners[title] != null) {
      _listeners[title]!.add(listener);
    } else {
      _listeners[title] = [listener];
    }
  }

  unSubscribe(String title, void Function(dynamic data) listener) {
    print("Event Bus UnSubscribed: ${title}");
    if (_listeners[title] != null) {
      _listeners[title]!.remove(listener);
    }
  }

  void dispose() {
    _controller.close();
  }
}
