import 'package:chat_app_roqaya/helper/helper_function.dart';
import 'package:chat_app_roqaya/pages/auth/login_page.dart';
import 'package:chat_app_roqaya/pages/home_page.dart';
import 'package:chat_app_roqaya/shared/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // run the initiliztion for Web
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constant.apiKey,
            appId: Constant.appId,
            messagingSenderId: Constant.messagingSenderId,
            projectId: Constant.projectId));
  } else {
    // run the initiliztion for android and ios
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSingedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  // function getUserLoggedInStatus

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSingedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Constant().primaryColor,
          scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      //إذا مسجل هسروح على الصفحة الرئيسية وإذا لا هيروح على لوجن
      home: _isSingedIn ? const HomePage() : const LoginPage(),
    );
  }
}
