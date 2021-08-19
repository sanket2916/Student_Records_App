import 'package:flutter/material.dart';
import 'package:kudosware_intern/Screen/login_screen.dart';
import 'package:kudosware_intern/Screen/dashboard.dart';
import 'package:kudosware_intern/Screen/signup_screen.dart';
import 'package:kudosware_intern/Screen/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        this._initialized = true;
      });
    } catch(e) {
      setState(() {
        this._error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        LoginScreen.id : (context) => LoginScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        Dashboard.id: (context) => Dashboard(),
      },
    );
  }
}


