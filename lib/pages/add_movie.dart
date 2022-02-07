import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/CustomClasses/color_class.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/add_movie_widgets.dart';
import 'package:flutter_application_11/main.dart';
import 'package:velocity_x/velocity_x.dart';
import '../WidgetsAndFunctions/all_page_widgets.dart';

class AddMovie extends StatefulWidget {
  AddMovie({Key? key}) : super(key: key);
  @override
  State<AddMovie> createState() => _AddMovieState();
}

bool isNewMovieAdd = false;
bool isImagePicked = false;
String movieName = "";
String directorName = "";
File? imageFile;

class _AddMovieState extends State<AddMovie> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [ImageChooseMutation, AppSignInMutation]);
    final userModal = providerOfUserDataModel(context);
    String uid = userModal.uid.toString();
    List<dynamic> watchlist = userModal.watchlist!;
    int indexWatchlist = userModal.index!;
    bool isGoogleAccount = userModal.email != "Unknown";
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: Vx.black,
            body: isGoogleAccount
                ? ListView(children: [
                    pageTitle("Add Movie"),
                    isNewMovieAdd
                        ? Form(
                            key: formKey,
                            child: Container(
                              height: height * 82,
                              width: width * 100,
                              child: Column(
                                children: [
                                  sizedBoxForHeight(25),
                                  Container(
                                    height: forHeight(210),
                                    width: forHeight(150),
                                    color: ColorClass().mainColor,
                                    child: isImagePicked
                                        ? Image.file(
                                            imageFile!,
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                  sizedBoxForHeight(18),
                                  GestureDetector(
                                      onTap: () async => getImage(context),
                                      child: uploadImageButton()),
                                  sizedBoxForHeight(58),
                                  columnTextFormField("Movie", context),
                                  sizedBoxForHeight(16),
                                  columnTextFormField("Director", context),
                                  Spacer(),
                                  GestureDetector(
                                      onTap: () async {
                                        if (formKey.currentState!.validate() &&
                                            isImagePicked) {
                                          setState(() {
                                            isNewMovieAdd = false;
                                            isImagePicked = false;
                                          });
                                          await uploadMovie(uid, indexWatchlist,
                                              watchlist, context);
                                        } else if (!isImagePicked) {
                                          VxToast.show(context,
                                              msg: "Poster Image Required",
                                              position: VxToastPosition.center,
                                              showTime: 3000,
                                              textSize: forHeight(15),
                                              bgColor: ColorClass().mainColor);
                                        }
                                      },
                                      child: addToWatchlistButton()),
                                ],
                              ).pSymmetric(h: forWidth(30)),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                isNewMovieAdd = !isNewMovieAdd;
                              });
                            },
                            child: addMovieButton())
                  ])
                : createAccountPage()));
  }
}
