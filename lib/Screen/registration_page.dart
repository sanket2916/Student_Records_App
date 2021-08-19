import 'package:flutter/material.dart';
import 'package:kudosware_intern/constants.dart';
import 'package:kudosware_intern/widgets/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
User? user;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}
var genders = ['Select', 'Male', 'Female', 'Other'];

class _RegistrationPageState extends State<RegistrationPage> {

  var studentNameController = TextEditingController();
  String? studentName;
  DateTime dateOfBirth = DateTime.now();
  String? dob;
  String? selectedGender = 'Select';
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dateOfBirth,
        firstDate: DateTime(1980),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != dateOfBirth)
      setState(() {
        dateOfBirth = pickedDate;
        dob = "${dateOfBirth.day}/${dateOfBirth.month}/${dateOfBirth.year}";
      });
  }

  DropdownButton dropdownOptions() {
    List<DropdownMenuItem<String>> menuItems = [];
    for (String gender in genders) {
      menuItems.add(DropdownMenuItem(
        child: Text(gender),
        value: gender,
      ));
    }
    return DropdownButton<String>(
      isExpanded: true,
      value: selectedGender,
      items: menuItems,
      onChanged: (value) {
        setState(() {
          selectedGender = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/formdetails.jpg'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(1.0), BlendMode.dstATop
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 120, horizontal: 30),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white60,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Student Details",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  // DetailTextField(
                  //     controller: studentName, label: "Student name"),
                  TextField(
                    controller: studentNameController,
                    decoration: kTextFieldDecoration.copyWith(hintText: 'Student Name'),
                    onChanged: (value){
                      studentName = value;
                    },
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.lightBlueAccent),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dob??'DD/MM/YYYY',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _selectDate(context),
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.blue[700],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.lightBlueAccent),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: dropdownOptions(),
                    ),
                  ),
                  RoundedButton(
                    onPress: (){
                      studentNameController.clear();
                      if(studentName != null && selectedGender != 'Select' && dob != null){
                        _firestore.collection(user!.email.toString()).add({
                          'dateOfBirth' : dob,
                          'gender' : selectedGender,
                          'studentName' : studentName,
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Enter all the values'
                          ),
                        ));
                      }
                      setState(() {
                        dob = null;
                        dateOfBirth = DateTime.now();
                        selectedGender = 'Select';
                      });
                    },
                    keyText: 'Save',
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
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
