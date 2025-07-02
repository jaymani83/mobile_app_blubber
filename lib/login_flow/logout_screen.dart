import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/constants.dart';

class LogoutScreen extends StatefulWidget{
  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {

  @override
  void initState() {
    clearAllSharedPreferenceData();
      Future.delayed(const Duration(seconds: 2), () {

    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: Center(
        child: Container(
          child: const Text('Logout'),
        ),
      ),
    );
  }

clearAllSharedPreferenceData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}


}