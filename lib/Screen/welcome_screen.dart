import 'package:flutter/material.dart';
import 'package:kudosware_intern/Screen/login_screen.dart';
import 'package:kudosware_intern/Screen/signup_screen.dart';
import 'package:kudosware_intern/widgets/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/welcome.jpg'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken)
            )
        ),
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 10.0,),
              RoundedButton(
                keyText: 'Log In',
                onPress: (){
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                color: Colors.lightBlueAccent,
              ),
              RoundedButton(
                keyText: 'Sign Up',
                onPress: (){
                  Navigator.pushNamed(context, SignUpScreen.id);
                },
                color: Colors.blueAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
