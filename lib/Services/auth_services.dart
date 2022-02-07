import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_11/CustomClasses/user_auth_class.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database_services.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  UserAuthData? updateUserAuthData(User? user) {
    return user != null
        ? UserAuthData(
            user.uid.toString(),
            user.metadata.creationTime.toString(),
            user.metadata.lastSignInTime.toString())
        : null;
  }

  Future signInWithoutAccount() async {
    await auth.signInAnonymously();
    await Database().updateUserData(
      index: 0,
      uid: auth.currentUser!.uid,
      name: "User",
      photoUrl: "",
      watchlist: [],
    );
  }

  Future signInwithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await auth.signInWithCredential(credential);
    try {
      final accountData =
          await Database().dataCollection.doc(auth.currentUser!.uid).get();
      List<dynamic> watchList = accountData.get("watchlist");
      int index = accountData.get("index");
      await Database().updateUserData(
        index: index,
        uid: auth.currentUser!.uid,
        name: googleSignInAccount.displayName,
        photoUrl: googleSignInAccount.photoUrl,
        watchlist: watchList,
      );
    } catch (e) {
      await Database().updateUserData(
        index: 0,
        uid: auth.currentUser!.uid,
        name: googleSignInAccount.displayName,
        photoUrl: googleSignInAccount.photoUrl,
        watchlist: [],
      );
    }
  }

  Future signOut() async {
    return await auth.signOut();
  }

  Stream<UserAuthData?> get userChanges {
    return auth.userChanges().map(updateUserAuthData);
  }

  Stream<UserAuthData?> get user {
    return auth.authStateChanges().map(updateUserAuthData);
  }
}
