import 'package:flutter/material.dart';
import 'package:flutter_application_11/CustomClasses/color_class.dart';
import 'package:flutter_application_11/CustomClasses/user_auth_class.dart';
import 'package:flutter_application_11/CustomClasses/user_data_class.dart';
import 'package:flutter_application_11/main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

double forHeight(double size) {
  return (size / 8.533333333333333) * height;
}

double forWidth(double size) {
  return (size / 3.84) * width;
}

UserAuthData? providerOfUserAuthData(BuildContext context, {bool? listen}) {
  return Provider.of<UserAuthData?>(context, listen: listen ?? true);
}

UserDataModel providerOfUserDataModel(BuildContext context, {bool? listen}) {
  return Provider.of<UserDataModel>(context, listen: listen ?? true);
}

SizedBox sizedBoxForHeight(double height) {
  return SizedBox(
    height: forHeight(height),
  );
}

SizedBox sizedBoxForWidth(double width) {
  return SizedBox(
    width: forWidth(width),
  );
}

Container loadingWidget() {
  return Container(
    color: Vx.black,
    child: Center(
      child: SpinKitThreeInOut(
        color: ColorClass().mainColor,
        size: 8.041 * height,
      ),
    ),
  );
}

Padding pageTitle(String title) {
  return Text(
    title,
    style: TextStyle(
        color: ColorClass().mainColor,
        fontSize: forHeight(26),
        fontWeight: FontWeight.w600),
  ).pOnly(left: forWidth(10));
}
