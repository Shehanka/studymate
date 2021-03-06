import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/models/ActivityProgress.dart';
import 'package:studymate/models/PreferredActivity.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/services/custom/ActivityService.dart';
import 'package:studymate/services/custom/StudentService.dart';
import 'package:flushbar/flushbar.dart';

class SocialActivityTab extends StatefulWidget {
  SocialActivityTab({Key key, this.title});
  final String title;

  @override
  _SocialActivityTabState createState() => _SocialActivityTabState();
}

class _SocialActivityTabState extends State<SocialActivityTab> {
  List<Activity> socialActivityList;
  List<ActivityProgress> studentActivitiesList;
  ActivityService activityService = ActivityService();
  StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> socialActivitySubscription;
  StreamSubscription<QuerySnapshot> studentActivitiesSubscription;
  String studentId;
  BaseAuthentication _authentication = Authentication();

  @override
  void initState() {
    super.initState();

    socialActivityList = List();
    socialActivitySubscription?.cancel();
    socialActivitySubscription = activityService
        .getSocialActivityList()
        .listen((QuerySnapshot snapshot) {
      final List<Activity> activities = snapshot.documents
          .map((documentSnapshot) => Activity.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.socialActivityList = activities;
      });
    });

    _authentication.getCurrentUser().then((user) {
      studentId = user;
      // Student Preferred Activities List
      studentActivitiesList = List();
      studentActivitiesSubscription?.cancel();
      studentActivitiesSubscription = studentService
          .getAllPreferredActivities(studentId, 'Social')
          .listen((QuerySnapshot snapshot) {
        final List<ActivityProgress> activityProgress = snapshot.documents
            .map((documentSnapshot) =>
                ActivityProgress.fromMap(documentSnapshot.data))
            .toList();
        setState(() {
          studentActivitiesList = activityProgress;
        });
      });
    });
  }

  @override
  void dispose() {
    socialActivitySubscription?.cancel();
    studentActivitiesSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Activity socialActivity) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Slidable(
            child: Container(
                decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                child: buildTilesList(socialActivity)),
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: <Widget>[
              IconSlideAction(
                  caption: 'Delete',
                  color: Colors.redAccent,
                  icon: Icons.delete,
                  onTap: () => deleteActivityProgress(socialActivity)),
            ],
          ),
        );

    final activityBody = socialActivityList != null
        ? Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: socialActivityList.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(socialActivityList[index]);
              },
            ),
          )
        : Container(
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Text(
              'Social Activities are not available!!',
              style: TextStyle(backgroundColor: Colors.red, fontSize: 15),
            ));

    return Scaffold(
      backgroundColor: Colors.white10,
      body: activityBody,
    );
  }

  buildTilesList(Activity socialActivity) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white30))),
        child: Text(
          socialActivity.type,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        socialActivity.name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing:
          Icon(getTileIcon(socialActivity), color: Colors.white, size: 30.0),
      onTap: () {
        bool isActivityPreferred = isActivityAlreadyPreferred(socialActivity);

        String flushBarMessage = 'Adding to List';
        if (isActivityPreferred) flushBarMessage = 'Removing from prefer';

        Flushbar(
          message: flushBarMessage,
          backgroundColor: Colors.deepPurple,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          duration: Duration(seconds: 3),
        )..show(context);

        // Pass activity
        PreferredActivity preferredActivity =
            PreferredActivity(socialActivity.name, 0);

        if (!isActivityPreferred) {
          _authentication.getCurrentUser().then((user) {
            studentId = user;

            // Activity Adding
            Future<ActivityProgress> isAdded =
                studentService.addToPreferredActivities(
                    studentId, preferredActivity, socialActivity.type);

            // Preferred Activity Adding SnackBar
            if (isAdded != null) {
              Flushbar(
                message: 'Added to preferred List',
                backgroundColor: Colors.green,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                duration: Duration(seconds: 3),
              )..show(context);
            } else {
              Flushbar(
                message: 'Adding failed!',
                backgroundColor: Colors.redAccent,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
                duration: Duration(seconds: 3),
              )..show(context);
            }
          });
        } else {
          deleteActivityProgress(socialActivity);
        }
      });

  // To chech whether activity is already preferred
  bool isActivityAlreadyPreferred(Activity activity) {
    bool isActivityAlreadyPreferred = false;

    studentActivitiesList.forEach((preferredActivity) {
      if (activity.name == preferredActivity.name)
        isActivityAlreadyPreferred = true;
    });

    return isActivityAlreadyPreferred;
  }

  // Gets Icons to Tiles
  IconData getTileIcon(Activity activity) {
    IconData iconData = Icons.add_circle_outline;
    if (isActivityAlreadyPreferred(activity))
      iconData = Icons.remove_circle_outline;
    return iconData;
  }

  void deleteActivityProgress(Activity activity) {
    _authentication.getCurrentUser().then((user) {
      studentId = user;
      // Preferred Activity removing
      Future<dynamic> isDeleted = studentService.deleteFromPreferredActivities(
          studentId, activity.name, activity.type);
      isDeleted.then((result) {
        if (result) {
          Flushbar(
            message: 'Successfully Removed',
            backgroundColor: Colors.green,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
            duration: Duration(seconds: 3),
          )..show(context);
        } else {
          Flushbar(
            message: 'Adding Failed!',
            backgroundColor: Colors.redAccent,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    });
  }
}
