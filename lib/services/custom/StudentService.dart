import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Student.dart';

final CollectionReference studentsCollection =
    Firestore.instance.collection('Students');

class StudentService {
  Future<Student> createStudent(String fullName, String email, String password,
      String schoolName, String phoneNumber) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(studentsCollection.document());

      final Student student = new Student(ds.documentID, fullName, email,
          password, true, schoolName, phoneNumber, null);
      final Map<String, dynamic> data = student.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Student.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Future<Student> getByID(String id) {
    return null;
  }

  Stream<QuerySnapshot> getStudentList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = studentsCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateStudent(Student student) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(studentsCollection.document(student.id));

      await tx.update(ds.reference, student.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteStudent(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(studentsCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Stream<QuerySnapshot> getAllPreferredActivities(String id) {
    // List<String> activitiesList = List<String>();
    /*studentsCollection.document(id).get().asStream().then((doc) {
      Student student = Student.fromMap(doc.data);
      print('Array: ' + student.preferedActivities.length.toString());

      // for each for list
      student.preferedActivities.forEach((value) {
        activitiesList.add(value);
        print("val : " + value);
        print(activitiesList.isEmpty);
      });
    });*/
    return studentsCollection
        .document(id)
        .collection('ActivityProgress')
        .snapshots();

    // return studentsCollection.document(id).get().asStream();
  }
}
