import 'package:flutter/material.dart';
import '../model/login_model.dart';

class LoginDataScope extends InheritedWidget {
  final LoginModel? loginModel;

  const LoginDataScope({
    Key? key,
    required this.loginModel,
    required Widget child,
  }) : super(key: key, child: child);

  static LoginModel? of(BuildContext context) {
    final scope =
    context.dependOnInheritedWidgetOfExactType<LoginDataScope>();
    return scope?.loginModel;
  }

  @override
  bool updateShouldNotify(LoginDataScope oldWidget) {
    return oldWidget.loginModel != loginModel;
  }
}
