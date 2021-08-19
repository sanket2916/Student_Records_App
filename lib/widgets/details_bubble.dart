import 'package:flutter/material.dart';

class DetailsBubble extends StatelessWidget {

  final studentName;
  final dateOfBirth;
  final gender;

  DetailsBubble({this.studentName, this.dateOfBirth, this.gender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: gender == 'Female'? AssetImage('images/student_girl.jpg') : AssetImage('images/student_boy.png'),
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '$studentName',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 2,),
                Text(
                  '$dateOfBirth',
                  style: TextStyle(
                      fontSize: 12
                  ),
                ),
                SizedBox(height: 2,),
                Text(
                  '$gender',
                  style: TextStyle(
                      fontSize: 12
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
