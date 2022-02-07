import 'package:flutter/material.dart';
import 'package:flutter_application_11/PageSelector/page_selector.dart';
import 'package:flutter_application_11/WidgetsAndFunctions/all_page_widgets.dart';
import 'package:provider/provider.dart';
import '../CustomClasses/user_data_class.dart';

class ChangeHomeScreen extends StatelessWidget {
  const ChangeHomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userModal = Provider.of<UserDataModel>(context);
    return userModal.name == null ? loadingWidget() : PageSelector();
  }
}
