import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kudosware_intern/Screen/signup_screen.dart';
import 'package:kudosware_intern/Screen/welcome_screen.dart';
import 'package:kudosware_intern/constants.dart';
import 'package:kudosware_intern/widgets/rounded_button.dart';
import 'package:kudosware_intern/Screen/dashboard.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/login_signup.jpg'),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken)
                )
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: IconButton(
                      onPressed: (){
                        Navigator.popAndPushNamed(context, WelcomeScreen.id);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                      iconSize: 30,
                    ),
                    radius: 30.0,
                  ),
                  SizedBox(height: 50,),
                  Text(
                    'Welcome \nBack!',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 70,),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value){
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Email'),
                  ),
                  SizedBox(height: 40.0,),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value){
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Password', ),
                  ),
                  SizedBox(height: 50.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RoundedButton(
                        keyText: 'Log In',
                        onPress: () async {
                          setState(() {
                            spinner = true;
                          });
                          try{
                            final newUser = await _auth.signInWithEmailAndPassword(email: email!, password: password!);
                            if(newUser.user != null && newUser.user!.emailVerified){
                              Navigator.pushNamed(context, Dashboard.id);
                            }
                          } catch(e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Log In failed'
                              ),
                            ));
                          }
                          setState(() {
                            spinner = false;
                          });
                        },
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
