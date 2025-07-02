import 'dart:async';
import 'package:flutter/foundation.dart';
import '../login_flow/user_preferences.dart';
import '../model/login_model.dart';

mixin _LoginNotifierHelper on ChangeNotifier {
  void notify() => notifyListeners();
}

class LoginProvider extends ChangeNotifier with _LoginNotifierHelper {
  final Completer<LoginModel> _loginDataCompleter = Completer<LoginModel>();
  late final _LoginStateHolder _state;

  LoginProvider() {
    _state = _LoginStateHolder(
      isLogin: false,
      loginModel: LoginModel(),
    );
  }

  bool get isLogin => _state.isLogin;
  final StreamController<String> _debugLoginStream = StreamController.broadcast();

  Stream<String> get loginEvents => _debugLoginStream.stream;

  Future<void> login() async {
    _state.isLogin = true;
    _debugLoginStream.add("User Logged In");
    notify();
  }

  Future<void> logout() async {
    _state.isLogin = false;
    await UserPreferences.clearCredentials();
    _debugLoginStream.add("User Logged Out");
    notify();
  }

  void setLoginData(LoginModel loginModelData) {
    _state.loginModel = loginModelData;
    if (!_loginDataCompleter.isCompleted) {
      _loginDataCompleter.complete(loginModelData);
    }
    notify();
  }

  Future<LoginModel> get loginModelAsync => _loginDataCompleter.future;

  LoginModel getLoginData() => _state.loginModel;

  void clearLoginData() {
    _state.loginModel = LoginModel();
    notify();
  }

  @override
  void dispose() {
    _debugLoginStream.close();
    super.dispose();
  }
}

class _LoginStateHolder {
  bool isLogin;
  LoginModel loginModel;

  _LoginStateHolder({
    required this.isLogin,
    required this.loginModel,
  });
}
