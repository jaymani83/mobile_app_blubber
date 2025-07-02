import 'package:flexiares/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/login_provider.dart';
import 'image_ui.dart';


Widget logoTile(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ImageUI.loginLogo(context),
    ],
  );
 }

Widget stLogoTile(context, path) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ImageUI.dynamicLogo(context, path),
    ],
  );
}

PreferredSizeWidget customAppBar(context) {
  LoginModel loginModel =
      Provider.of<LoginProvider>(context, listen: false).getLoginData();
  return AppBar(
    automaticallyImplyLeading: false,
    title: stLogoTile(context, loginModel.endPointLogo ?? ''),
  );
}
