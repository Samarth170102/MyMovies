import 'package:flutter/material.dart';
import 'package:flutter_application_11/Services/auth_services.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/auth_page_widgets.dart';
import 'package:flutter_application_11/main.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.black,
      body: Column(
        children: [
          sizedBoxForHeight(165),
          containerForAppLogo(),
          sizedBoxForHeight(90),
          GestureDetector(
              onTap: () async => AuthService().signInwithGoogle(),
              child: containerForAuthOption("Continue with Google", "google")),
          sizedBoxForHeight(22),
          GestureDetector(
            onTap: () async => AuthService().signInWithoutAccount(),
            child: containerForAuthOption("Continue without Account", "user"),
          )
        ],
      ).w(width * 100),
    );
  }
}
