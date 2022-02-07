import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/CustomClasses/color_class.dart';
import 'package:flutter_application_11/Services/database_services.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:velocity_x/velocity_x.dart';
import '../main.dart';

Column columnForWatchlistBox(String type, String typeName) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        type,
        style:
            TextStyle(fontSize: forHeight(19), color: ColorClass().mainColor),
      ),
      Container(
        width: forWidth(200),
        child: Text(
          typeName,
          style:
              TextStyle(fontSize: forHeight(16), color: ColorClass().mainColor),
        ),
      ),
    ],
  );
}

Slidable slidableForWatchlistBox(String uid, Map<String, dynamic> watchlistItem,
    List<dynamic> watchlist, int itemIndex, Widget child) {
  return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        extentRatio: 1 / 3,
        motion: ScrollMotion(),
        children: [slidableActionForSlidable(uid, itemIndex, watchlist)],
      ),
      endActionPane: ActionPane(
        extentRatio: 1 / 3,
        motion: ScrollMotion(),
        children: [slidableActionForSlidable(uid, itemIndex, watchlist)],
      ),
      child: child);
}

SlidableAction slidableActionForSlidable(
  String uid,
  int itemIndex,
  List<dynamic> watchlist,
) {
  return SlidableAction(
    onPressed: (context) => showDialog(
        builder: (context) => AlertDialog(
              title: Text("Delete Movie"),
              content: Text("Remove this movie from watchlist?"),
              actions: [
                GestureDetector(
                  onTap: () async {
                    final _firebaseStorage = FirebaseStorage.instance;
                    _firebaseStorage
                        .refFromURL(watchlist[itemIndex]["posterUrl"])
                        .delete();
                    watchlist.removeAt(itemIndex);
                    Database()
                        .dataCollection
                        .doc(uid)
                        .update({"watchlist": watchlist});
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: forHeight(40),
                      width: forHeight(70),
                      color: Colors.transparent,
                      child: Text(
                        "Yes",
                        style: TextStyle(fontSize: forHeight(20)),
                      ).centered()),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                      height: forHeight(40),
                      width: forHeight(70),
                      color: Colors.transparent,
                      child: Text(
                        "No",
                        style: TextStyle(fontSize: forHeight(20)),
                      ).centered()),
                )
              ],
              backgroundColor: ColorClass().mainColor,
            ),
        context: context),
    backgroundColor: ColorClass().mainColor,
    foregroundColor: Colors.black,
    icon: Icons.delete,
    label: 'Delete',
  );
}

Padding containerForWatchlist(Map<String, dynamic> watchlistItem) {
  return Container(
    width: width * 100,
    height: forHeight(240),
    child: Row(
      children: [
        Container(
            height: forHeight(210),
            width: forHeight(150),
            child: CachedNetworkImage(
                fit: BoxFit.cover, imageUrl: watchlistItem["posterUrl"])),
        sizedBoxForWidth(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBoxForHeight(30),
            columnForWatchlistBox("Movie", watchlistItem["movieName"]),
            sizedBoxForHeight(10),
            columnForWatchlistBox("Director", watchlistItem["directorName"]),
          ],
        )
      ],
    ).pOnly(left: forWidth(10)),
  ).pOnly(bottom: forHeight(3));
}
