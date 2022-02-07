import 'package:flutter/material.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/main_page_widgets.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/page_selector_widgets.dart';
import 'package:flutter_application_11/pages/add_movie.dart';
import 'package:flutter_application_11/pages/user_profile.dart';
import 'package:flutter_application_11/pages/watchlist.dart';
import 'package:velocity_x/velocity_x.dart';
import '../WidgetsAndFunctions/all_page_widgets.dart';
import '../main.dart';

class PageSelector extends StatefulWidget {
  PageSelector({Key? key}) : super(key: key);

  @override
  State<PageSelector> createState() => _PageSelectorState();
}

class _PageSelectorState extends State<PageSelector> {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [PageSelectMutation]);
    return Scaffold(
      backgroundColor: Vx.black,
      appBar: appBarForAuth(toolbarHeight: forHeight(10)),
      body: IndexedStack(
        index: pageIndex,
        children: [WatchList(), AddMovie(), UserProfile()],
      ),
      bottomNavigationBar: BottomNavigationBarPageSelect(),
    );
  }
}
