import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studymate/models/MedicalRecord.dart';
import 'package:studymate/services/custom/MedicalRecordService.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class CreateMedicalRecordScreen extends StatefulWidget {
  _CreateMedicalRecordScreenState createState() =>
      _CreateMedicalRecordScreenState();
}

class _CreateMedicalRecordScreenState extends State<CreateMedicalRecordScreen> {
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _recordDetailsController =
      TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  MedicalRecordService _medicalRecordService = MedicalRecordService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var createMedicalRecordBody = Container(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(1.0),
            child: Container(
              width: 255,
              child: StudymateTextField(
                  labelText: 'Student Name',
                  textEditingController: _studentNameController,
                  validation: 'name',
                  icon: Icon(Icons.search, color: Colors.grey)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(1.0),
            child: Container(
              width: 255,
              child: StudymateTextField(
                  labelText: 'Doctor Name',
                  textEditingController: _doctorNameController,
                  validation: 'name',
                  icon: Icon(Icons.search, color: Colors.grey)),
            ),
          ),
          StudymateTextField(
              labelText: 'Record Details',
              textEditingController: _recordDetailsController,
              validation: 'name',
              icon: Icon(Icons.comment)),
          StudymateTextField(
              labelText: 'Record Details',
              textEditingController: _commentController,
              validation: 'name',
              icon: Icon(Icons.comment)),
          Container(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 150,
                child: StudymateRaisedButton(
                    'Create', createMedicalRecord, Colors.deepPurpleAccent),
              ),
              Container(
                width: 150,
                child: StudymateRaisedButton(
                    'Cancel', closeWindow, Colors.redAccent),
              )
            ],
          )
        ],
      ),
    );

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('Create Medical Record'),
              backgroundColor: Colors.deepPurple,
            ),
            body: createMedicalRecordBody));
  }

  void searchStudent() {
    // print('Search student' + _studentNameController.text);
    var date = new DateTime.now();
    log(date.toString());
  }

  void closeWindow() {
    Navigator.pop(context);
  }

  void createMedicalRecord() {
    // _studentService.getStudentsByName('Student');
    MedicalRecord medicalRecord = MedicalRecord(
        'id',
        _recordDetailsController.text,
        '2019-10-07',
        _doctorNameController.text,
        _studentNameController.text,
        "url");

    Future<MedicalRecord> isAdded = _medicalRecordService.create(medicalRecord);

    isAdded.then((value) {
      if (value != null) {
        Navigator.pop(context);
      } else {
        print("Didnt add");
      }
    });
  }
}
