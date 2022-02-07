import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/CustomClasses/color_class.dart';
import 'package:flutter_application_11/Services/auth_services.dart';
import 'package:flutter_application_11/Services/database_services.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:flutter_application_11/main.dart';
import 'package:flutter_application_11/pages/add_movie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:velocity_x/velocity_x.dart';

InputDecoration inputDecorationEditProfile(
    EdgeInsets edgeInsets, BuildContext context) {
  return InputDecoration(
    contentPadding: edgeInsets,
    counterStyle: TextStyle(fontSize: forHeight(13), color: Vx.gray400),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: forHeight(1.5),
        color: ColorClass().mainColor,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: forHeight(1.5),
        color: ColorClass().mainColor,
      ),
    ),
  );
}

Future getImage(BuildContext context) async {
  final imagePicker = ImagePicker();
  XFile? image;
  await Permission.photos.request();
  final permissionStatus = await Permission.photos.status;
  if (permissionStatus.isGranted) {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      isImagePicked = true;
      ImageChooseMutation();
    }
  } else {
    VxToast.show(context, msg: "Permission Not Granted");
  }
}

Column columnTextFormField(String typeName, BuildContext context) {
  return Column(
    children: [
      Text(
        "$typeName Name",
        style: TextStyle(
          color: ColorClass().mainColor,
          fontSize: forHeight(18),
          fontWeight: FontWeight.w600,
        ),
      ).objectBottomLeft(),
      TextFormField(
          maxLength: 30,
          initialValue: "",
          cursorColor: ColorClass().mainColor,
          style: TextStyle(
              color: ColorClass().mainColor, fontSize: 2.1097 * height),
          decoration: inputDecorationEditProfile(
              EdgeInsets.only(top: forHeight(12)), context),
          validator: (value) {
            if (value!.isEmpty) {
              return "$typeName name cannot be empty";
            }
            return null;
          },
          onChanged: (val) {
            if (typeName == "Movie") {
              movieName = val;
            } else {
              directorName = val;
            }
          }),
    ],
  );
}

Future uploadMovie(String uid, int indexWatchlist, List<dynamic> watchlist,
    BuildContext context) async {
  final _firebaseStorage = FirebaseStorage.instance;
  VxToast.show(context,
      msg: "Movie is adding, Please wait",
      position: VxToastPosition.top,
      showTime: 3000,
      textSize: forHeight(15),
      bgColor: ColorClass().mainColor);
  var storageRef = await _firebaseStorage
      .ref()
      .child("$uid/${uid}_$indexWatchlist")
      .putFile(imageFile!);
  var downloadUrl = await storageRef.ref.getDownloadURL();
  watchlist.add({
    "posterUrl": downloadUrl,
    "movieName": movieName.trim(),
    "directorName": directorName.trim()
  });
  indexWatchlist++;
  await Database()
      .dataCollection
      .doc(uid)
      .update({"watchlist": watchlist, "index": indexWatchlist});
  VxToast.show(context,
      msg: "Movie Added to Watchlist!",
      position: VxToastPosition.top,
      showTime: 2000,
      textSize: forHeight(15),
      bgColor: ColorClass().mainColor);
}

Container addMovieButton() {
  return Container(
    height: height * 75,
    width: width * 100,
    child: Container(
      height: forHeight(80),
      width: forHeight(230),
      child: Text(
        "Add Movie",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: forHeight(25), fontWeight: FontWeight.w600),
      ).centered(),
      decoration: BoxDecoration(
          color: ColorClass().mainColor,
          borderRadius: BorderRadius.circular(forHeight(10))),
    ).centered(),
  );
}

Container addToWatchlistButton() {
  return Container(
    height: forHeight(45),
    width: forHeight(190),
    decoration: BoxDecoration(
        color: ColorClass().mainColor,
        borderRadius: BorderRadius.circular(forHeight(8))),
    child: Text(
      "Add To Watchlist",
      style: TextStyle(
        fontSize: forHeight(18),
        fontWeight: FontWeight.w600,
      ),
    ).centered(),
  );
}

Container uploadImageButton() {
  return Container(
    height: forHeight(45),
    width: forHeight(220),
    decoration: BoxDecoration(
        color: ColorClass().mainColor,
        borderRadius: BorderRadius.circular(forHeight(8))),
    child: Text(
      "Upload Poster Image",
      style: TextStyle(
        fontSize: forHeight(18),
        fontWeight: FontWeight.w600,
      ),
    ).centered(),
  );
}

Column createAccountPage() {
  return Column(
    children: [
      sizedBoxForHeight(300),
      Container(
        child: Text(
          "Create Account to\nAdd Movies to Watchlist",
          textAlign: TextAlign.center,
          style:
              TextStyle(color: ColorClass().mainColor, fontSize: forHeight(20)),
        ).centered(),
      ),
      Spacer(),
      GestureDetector(
        onTap: () async {
          await AuthService().signInwithGoogle();
          AppSignInMutation();
        },
        child: Container(
          child: Container(
            height: forHeight(60),
            width: forHeight(130),
            child: Text(
              "Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: forHeight(25), fontWeight: FontWeight.w600),
            ).centered(),
            decoration: BoxDecoration(
                color: ColorClass().mainColor,
                borderRadius: BorderRadius.circular(forHeight(10))),
          ).centered(),
        ),
      ),
      sizedBoxForHeight(45)
    ],
  );
}
