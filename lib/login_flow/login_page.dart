import 'package:flexiares/login_flow/user_preferences.dart';
import 'package:flexiares/provider/login_provider.dart';
import 'package:flexiares/ui_values/controls_ui.dart';
import 'package:flexiares/ui_values/space_ui.dart';
import 'package:flexiares/utility/navigate_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/login_model.dart';
import '../services/api_network.dart';
import '../utility/color_scheme.dart';
import '../utility/functions.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(),
    );
  }

  /**
   * create login page with label and Textfield
   */
  Widget LoginForm() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            logoTile(context),

            hSpacer(12),
            TextFormField(
              controller: usernameController,
              obscureText: false,
              textAlign: TextAlign.start,
              validator: (value) => validateField(value, 'Email'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                labelText: 'Email',
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.grey[500]),
                contentPadding: const EdgeInsets.all(16.0),
                fillColor: Colors.white70,
              ),
            ),

            hSpacer(12),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              textAlign: TextAlign.start,
              validator: (value) => validateField(value, 'Password'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                labelText: 'Password',
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey[500]),
                contentPadding: const EdgeInsets.all(16.0),
                fillColor: Colors.white70,
              ),
            ),

            hSpacer(),

            isLoading?const Center(child: CircularProgressIndicator()):
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  validateData();
                }
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: CustomColorScheme.btnColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 6.0),

            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
              },
              child: Text('Forgot Password?', style: TextStyle(fontStyle: FontStyle.italic)),
            ),
          ],
        ),
      ),
    );
  }

  bool isLoading = false;

  void validateData() async{

    setState(() {

      isLoading = true;
    });

    /**
     * validate user name and password
     */
    if(usernameController.text.isEmpty || passwordController.text.isEmpty ){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Must enter username and password'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }



    LoginModel loginModel=await Services().login(usernameController.text, passwordController.text, context);
    if(loginModel.statucode==401){
      showAlertDialog(context, loginModel.message??'Invalid username or password');

      setState(() {
        isLoading = false;
      });
      return;
    }
    else {
      print(loginModel.username);
      await UserPreferences.saveCredentials(usernameController.text, passwordController.text);
      Provider.of<LoginProvider>(context, listen: false).setLoginData(
          loginModel);
    }
   setState(() {
     isLoading = false;
   });

   goToDashboard(context);



  }

  void showAlertDialog(BuildContext context, String s) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text(s),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
}
