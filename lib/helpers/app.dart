import 'package:flutter/material.dart';
import 'package:shell/screens/login.dart';

class Application {
  static final Application _Application = Application._internal();
  late Widget _mainScreen;
  bool isLoggedIn = false;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  get context => _navigatorKey.currentContext!;

  Widget get mainScreen => _mainScreen;

  factory Application() {
    return _Application;
  }

  Application._internal();

  initialize({required Widget mainScreen}) {
    _mainScreen = mainScreen;
    runApp(
      MaterialApp(
        title: 'Bank App',
        navigatorKey: _navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isLoggedIn ? _mainScreen : AppLoginScreen(),
      ),
    );
  }
}
