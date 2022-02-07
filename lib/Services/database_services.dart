import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_11/CustomClasses/user_data_class.dart';
import 'package:flutter_application_11/Services/auth_services.dart';
import 'package:provider/provider.dart';

class Database {
  CollectionReference dataCollection =
      FirebaseFirestore.instance.collection("TestApp6");
  Future updateUserData({String? uid, String? name, String? photoUrl,List<dynamic>? watchlist,int? index}) async {
    return await dataCollection.doc(uid).set({
      "uid": uid,
      "index": index,
      "name": name,
      "watchlist": watchlist,
      "email": AuthService().auth.currentUser!.email ?? "Unknown",
      "photoUrl": photoUrl
    });
  }

  Future updateSingleDocData(
      String key, dynamic value, BuildContext context) async {
    final user = Provider.of<UserDataModel>(context, listen: false);
    return await Database().dataCollection.doc(user.uid).update({key: value});
  }

  UserDataModel userData(DocumentSnapshot snapshot) {
    return UserDataModel(
      uid: snapshot["uid"],
      name: snapshot["name"],
      index: snapshot["index"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      watchlist: List.castFrom(snapshot["watchlist"]),
    );
  }

  Stream<UserDataModel> get docsSnap {
    return dataCollection
        .doc(AuthService().auth.currentUser!.uid)
        .snapshots()
        .map(userData);
  }
}
