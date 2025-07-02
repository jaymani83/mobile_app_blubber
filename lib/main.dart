import 'package:flexiares/login_flow/login_page.dart';
import 'package:flexiares/provider/login_provider.dart';
import 'package:flexiares/utility/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'login_flow/splash_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blubber',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: HexColor('#063553')),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}
