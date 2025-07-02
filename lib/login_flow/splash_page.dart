import 'package:flexiares/login_flow/user_preferences.dart';
import 'package:flexiares/utility/navigate_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/login_model.dart';
import '../provider/login_provider.dart';
import '../services/api_network.dart';
import '../ui_values/controls_ui.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    super.initState();

   getData();
  }


  void getData() async {final credentials = await UserPreferences.getCredentials();if(credentials!=null) {if(credentials['username']!=null && credentials['password']!=null) {
       checkLogin(credentials['username'], credentials['password']);
      }
      else{
        goToPage(context, LoginPage());
      }
    } else {
      goToPage(context, LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logoTile(context),
            new SizedBox(height: 20,),
            CircularProgressIndicator(),

          ],
        ),
      ),
    );
  }

  void checkLogin(String? username, String? password) async{
    if (username != null && password != null) {
      LoginModel loginModel=await Services().login(username, password, context);
      if(loginModel.statucode==401){
        goToPage(context, LoginPage());
        return;
      }
      else {
        print(loginModel.username);
        Provider.of<LoginProvider>(context, listen: false).setLoginData(
            loginModel);
      }
    } else {
      goToLogin(context, LoginPage());
    }

    goToDashboard(context);
  }

}
