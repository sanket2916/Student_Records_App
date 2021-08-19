import 'package:flutter/material.dart';
import 'package:kudosware_intern/Screen/login_screen.dart';
import 'package:kudosware_intern/Screen/welcome_screen.dart';
import 'package:kudosware_intern/constants.dart';
import 'package:kudosware_intern/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class SignUpScreen extends StatefulWidget {

  static const String id = 'SignUp';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

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
                    'Create \nAccount',
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
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Enter Your Password'),
                  ),
                  SizedBox(height: 40.0,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RoundedButton(
                        keyText: 'Sign Up',
                        onPress: () async {
                          setState(() => spinner = true);
                          try{
                            final newUser = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
                            User? user = _auth.currentUser;
                            if(user != null && user.emailVerified == false) {
                              await user.sendEmailVerification();
                              Navigator.pushNamed(context, LoginScreen.id);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Sign Up Failed, Retry!!!'),
                              ));
                            }
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Sign Up Failed, Retry!!!'),
                            ));
                          }
                          setState(() => spinner = false);
                        },
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Have an account already?',
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text(
                          'Log In',
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
