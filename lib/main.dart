import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_11/CustomClasses/user_auth_class.dart';
import 'package:flutter_application_11/Services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ScreenWrappers/main_wrapper.dart';

void main(List<String> args) async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(VxState(store: MyStore(), child: MaterialApp(home: MyApp())));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyStore extends VxStore {
  bool pageSelect = true;
  bool imageChoose = true;
  bool appSignIn = true;
}

class PageSelectMutation extends VxMutation<MyStore> {
  @override
  perform() {
    store.pageSelect = !store.pageSelect;
  }
}

class ImageChooseMutation extends VxMutation<MyStore> {
  @override
  perform() {
    store.imageChoose = !store.imageChoose;
  }
}

class AppSignInMutation extends VxMutation<MyStore> {
  @override
  perform() {
    store.appSignIn = !store.appSignIn;
  }
}

MyStore store = VxState.store;
double height = 0;
double width = 0;
int pageIndex = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height / 100;
    width = MediaQuery.of(context).size.width / 100;
    return StreamProvider<UserAuthData?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        home: Wrapper(),
      ),
    );
  }
}
