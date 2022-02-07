import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/user_profile_widgets.dart';
import 'package:flutter_application_11/main.dart';
import 'package:velocity_x/velocity_x.dart';
import '../WidgetsAndFunctions/all_page_widgets.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final userData = providerOfUserDataModel(context);
    bool isGoogleAccount = userData.email != "Unknown";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        pageTitle("User Profile").objectBottomLeft(),
        sizedBoxForHeight(30),
        Container(
          height: forHeight(170),
          width: forHeight(170),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    isGoogleAccount
                        ? userData.photoUrl.toString()
                        : "https://icon-library.com/"
                            "images/default-user-icon/defau"
                            "lt-user-icon-8.jpg",
                  ))),
        ),
        sizedBoxForHeight(60),
        Column(
          children: [
            columnForUserInformation(
                    "Name", isGoogleAccount ? userData.name! : "Unknown")
                .objectBottomLeft(),
            columnForUserInformation(
                    "Email", isGoogleAccount ? userData.email! : "Unknown")
                .objectBottomLeft(),
          ],
        ).pOnly(left: forWidth(10)),
        Spacer(),
        signOutButton(),
        sizedBoxForHeight(40)
      ],
    ).w(width * 100);
  }
}
