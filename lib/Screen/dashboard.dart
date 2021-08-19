import 'package:flutter/material.dart';
import 'package:kudosware_intern/Screen/registration_page.dart';
import 'package:kudosware_intern/Screen/student_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kudosware_intern/Screen/welcome_screen.dart';

User? user;

class Dashboard extends StatefulWidget {
  static const String id = 'Dashboard';

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Widget> pages = [
    RegistrationPage(),
    StudentListPage()
  ];

  int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser(){
    try{
      user = _auth.currentUser!;
    } catch (e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[700],
        splashColor: Colors.yellow[700],
        onPressed: (){
          _auth.signOut();
          // Navigator.popAndPushNamed(context, WelcomeScreen.id);
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
        },
        tooltip: 'Log Out',
        child: Icon(
          Icons.logout
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: "Registration"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: "Student List"
          ),
        ],
        onTap: (int value) {
          setState(() => _selectedIndex = value);
        },
      ),
    );
  }
}
