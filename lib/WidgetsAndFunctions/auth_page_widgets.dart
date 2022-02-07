import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import '../CustomClasses/color_class.dart';

Container containerForAppLogo() {
  return Container(
    height: forHeight(90),
    width: forHeight(270),
    child: Image.asset("assets/images/logo/app_logo.png",
        color: ColorClass().mainColor),
  );
}

Container containerForAuthOption(String text, String iconName) {
  return Container(
      height: forHeight(40),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: forHeight(30),
            child: Image.asset(
              "assets/images/icon/$iconName.png",
              color: ColorClass().mainColor,
            ),
          ),
          Text(
            "  $text",
            style: TextStyle(
                color: ColorClass().mainColor, fontSize: forHeight(20)),
          ).centered(),
        ],
      ));
}
