import 'package:flutter/material.dart';

import 'package:shell/components/button.dart';
import 'package:shell/components/container.dart';
import 'package:shell/components/input.dart';
import 'package:shell/helpers/app.dart';

class AppLoginScreen extends StatefulWidget {
  const AppLoginScreen({Key? key}) : super(key: key);

  @override
  State<AppLoginScreen> createState() => _AppLoginScreenState();
}

class _AppLoginScreenState extends State<AppLoginScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      title: "Login",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Username"),
            AppInput(controller: username),
            Text("Password"),
            AppInput(controller: password),
            Container(
              alignment: Alignment.center,
              child: AppButton(
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => Application().mainScreen),
                  (route) => false,
                ),
                title: "Log In",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
