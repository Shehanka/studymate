import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/services/custom/ActivityService.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class ManageActivityScreen extends StatelessWidget {
  final Activity activity;
  final ActivityService activityService = ActivityService();
  final _formKey = GlobalKey<FormState>();
  final nameController;

  ManageActivityScreen({Key key, @required this.activity, this.nameController});

  @override
  Widget build(BuildContext context) {
    // Activity Delete Action
    void activityDeleteAction() {
      Future<dynamic> isDeleted = activityService.deleteActivity(activity.id);
      if (isDeleted != null) {
        Navigator.pop(context);
      } else {
        print('Activity Delete Failed');
      }
    }

    void showDeleteConfirmationDialog() {
      if (activity.id != null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return StudymateDialogBox(
                title: 'Are you sure?',
                description:
                    activity.name + ' activity will be permanently deleted!',
                confirmation: true,
                confirmationAction: activityDeleteAction,
                tigerAnimationType: 'fail',
              );
            });
      } else {
        // showDialog<void>(
        //     context: context, child: Text('Something went wrong'));
      }
    }

    final manageActivityBody = Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: StudymateTextField(
                    'Activity Name',
                    nameController,
                    'text',
                    false,
                    Colors.grey,
                    TextInputType.text,
                    Icon(Icons.local_activity, color: Colors.grey)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: activity.type,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      color: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      child: Text('Save'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          if (activity.id != null) {
                            Activity updatedActivity = Activity(activity.id,
                                nameController.text, activity.type);
                            
                            Future isUpdated =
                                activityService.updateActivity(updatedActivity);
                            if (isUpdated != null) {
                              Navigator.pop(context);
                            }
                          } else {
                            print('Activity id is not valid');
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      child: Text('Remove'),
                      onPressed: showDeleteConfirmationDialog,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(activity.name),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: manageActivityBody,
      ),
    );
  }
}
