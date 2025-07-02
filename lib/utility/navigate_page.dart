import 'package:flutter/material.dart';
import '../login_flow/dashboard_page.dart';

goToLandingPage(context,className){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                className));

}

goToPage(context,className){
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
          className));

}

goToPushReplacePage(context,className){
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              className));

}

goToDashboard(context) {

  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      DashboardPage()), (Route<dynamic> route) => false);

}

goToLogin(context,className){

  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              className));
}


