import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final TextEditingController controller;

  const AppInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(controller: controller);
  }
}
