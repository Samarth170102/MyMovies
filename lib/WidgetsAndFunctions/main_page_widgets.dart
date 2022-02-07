import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import '../main.dart';

AppBar appBarForAuth({
  double? toolbarHeight,
}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light),
    toolbarHeight: toolbarHeight ?? 5.52819 * height,
    backgroundColor: Vx.black,
    elevation: 0,
  );
}