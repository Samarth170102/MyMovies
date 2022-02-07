import 'package:flutter/material.dart';
import 'package:flutter_application_11/CustomClasses/color_class.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:flutter_application_11/main.dart';
import 'package:velocity_x/velocity_x.dart';

class BottomNavigationBarPageSelect extends StatefulWidget {
  BottomNavigationBarPageSelect({Key? key}) : super(key: key);
  @override
  State<BottomNavigationBarPageSelect> createState() =>
      _BottomNavigationBarPageSelectState();
}

class _BottomNavigationBarPageSelectState
    extends State<BottomNavigationBarPageSelect> {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [PageSelectMutation]);
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        showUnselectedLabels: false,
        selectedFontSize: forHeight(13.5),
        currentIndex: pageIndex,
        onTap: (value) {
          pageIndex = value;
          PageSelectMutation();
        },
        fixedColor: ColorClass().mainColor,
        backgroundColor: Vx.black,
        items: [
          bottomNavigationBarItem("Watchlist", "watchlist"),
          bottomNavigationBarItem("Add Movie", "add"),
          bottomNavigationBarItem("User", "user"),
        ],
      ),
    );
  }
}

BottomNavigationBarItem bottomNavigationBarItem(String lable, String iconName) {
  return BottomNavigationBarItem(
    label: lable,
    icon: ImageIcon(
      AssetImage("assets/images/icon/$iconName.png"),
      color: ColorClass().mainColor,
      size: forHeight(27),
    ),
  );
}
