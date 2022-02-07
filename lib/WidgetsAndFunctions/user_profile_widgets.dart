import 'package:flutter/material.dart';
import 'package:flutter_application_11/Services/auth_services.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:flutter_application_11/main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../CustomClasses/color_class.dart';

Padding columnForUserInformation(String type, String typeData) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(type, style: TextStyle(color: Vx.white, fontSize: forHeight(21))),
      sizedBoxForHeight(2),
      Text(typeData,
          style: TextStyle(color: Vx.white, fontSize: forHeight(19))),
    ],
  ).pOnly(bottom: forHeight(25));
}

GestureDetector signOutButton() {
  return GestureDetector(
    onTap: () {
      pageIndex = 0;
      AuthService().signOut();
    },
    child: Container(
          height: forHeight(55),
          width: forHeight(140),
          decoration: BoxDecoration(
              color: ColorClass().mainColor,
              borderRadius: BorderRadius.circular(forHeight(8))),
          child: Text(
            "Sign Out",
            style: TextStyle(
              fontSize: forHeight(18),
              fontWeight: FontWeight.w600,
            ),
          ).centered(),
        ),
  );
}
