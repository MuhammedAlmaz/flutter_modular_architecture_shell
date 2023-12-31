import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final String title;

  const AppContainer({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(child: child),
    );
  }
}
