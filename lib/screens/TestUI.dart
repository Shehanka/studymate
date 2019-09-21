import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/widgets/FormTextField.dart';

class TestUIScreen extends StatefulWidget {
  _TestUIScreenState createState() => _TestUIScreenState();
}

class _TestUIScreenState extends State<TestUIScreen> {
  TextEditingController editingController;
  TextInputType textInputType = TextInputType.text;
  Color color = Colors.deepPurple;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: ListView(
            children: <Widget>[
              FormTextField(
                  "Test", editingController, "Test", color, textInputType),
              RaisedButton(
                child: Text('Admin Activity'),
                color: Colors.deepPurpleAccent,
                textColor: Colors.white,
                focusColor: Colors.deepPurple,
                onPressed: () =>
                    {Navigator.pushNamed(context, '/adminActivity')},
              ),
              StreamBuilder(
                  stream: Firestore.instance
                      .collection('students/ActivityProgress')
                      .document('JfaAiaJ4yAqhqUqey1mG')
                      .collection('ActivityProgress')
                      .document('QqxPb5GbnnikluuBYbML')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return new Text("Loading");
                    }
                    var userDocument = snapshot.data;
                    return new Text(userDocument["name"]);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
