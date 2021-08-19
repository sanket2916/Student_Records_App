import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kudosware_intern/Screen/welcome_screen.dart';
import 'package:kudosware_intern/widgets/details_bubble.dart';
import 'package:kudosware_intern/widgets/rounded_button.dart';

final _firestore = FirebaseFirestore.instance;
User? user;

class StudentListPage extends StatefulWidget {

  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
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
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/formdetails.jpg'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(1.0), BlendMode.dstATop
            ),
          )
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40 ,vertical: 100),
            child: DetailsStream()
        )
      ),
    );
  }
}

class DetailsStream extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(user!.email.toString()).orderBy('studentName').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final details = snapshot.data!.docs;
        List<DetailsBubble> detailsList = [];
        for(var detailData in details){
          final studentName = detailData.get('studentName');
          final dateOfBirth = detailData.get('dateOfBirth');
          final gender = detailData.get('gender');

          final detailBox = DetailsBubble(
            studentName: studentName,
            dateOfBirth: dateOfBirth,
            gender: gender,
          );
          detailsList.add(detailBox);

        }
        return ListView(
          children: detailsList,
        );
      },
    );
  }
}

