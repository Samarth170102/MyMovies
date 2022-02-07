import 'package:flutter/material.dart';
import 'package:flutter_application_11/CustomClasses/color_class.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/watchlist_page_widgets.dart';
import 'package:flutter_application_11/main.dart';
import 'package:velocity_x/velocity_x.dart';

class WatchList extends StatefulWidget {
  WatchList({Key? key}) : super(key: key);
  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  @override
  Widget build(BuildContext context) {
    final userData = providerOfUserDataModel(context);
    List<dynamic> watchlist = userData.watchlist!;
    return ListView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        pageTitle("Watchlist"),
        sizedBoxForHeight(12),
        userData.watchlist!.isNotEmpty
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: watchlist.length,
                itemBuilder: (BuildContext context, int indexItem) {
                  int mainIndex = watchlist.length - indexItem - 1;
                  Map<String, dynamic> watchlistItem = watchlist[mainIndex];
                  return slidableForWatchlistBox(
                      userData.uid.toString(),
                      watchlistItem,
                      watchlist,
                      mainIndex,
                      containerForWatchlist(watchlistItem));
                },
              )
            : Container(
                width: width * 100,
                height: height * 75,
                child: Text(
                  "No movies added to watchlist",
                  style: TextStyle(
                      color: ColorClass().mainColor, fontSize: forHeight(20)),
                ).centered(),
              ),
      ],
    );
  }
}
