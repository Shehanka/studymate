// import 'package:flutter/material.dart';
// import 'package:studymate/models/state.dart';
// import 'package:studymate/widgets/loading.dart';
// import 'package:studymate/widgets/stateWidget.dart';

// class HomeScreen extends StatefulWidget {
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   StateModel appState;
//   bool _loadingVisible = false;
//   @override
//   void initState() {
//     super.initState();
//   }

//   Widget build(BuildContext context) {
//     appState = StateWidget.of(context).state;
//     if (!appState.isLoading &&
//         (appState.firebaseUserAuth == null ||
//             appState.student == null ||
//             appState.settings == null)) {
//       return HomeScreen();
//     } else {
//       if (appState.isLoading) {
//         _loadingVisible = true;
//       } else {
//         _loadingVisible = false;
//       }
//       final logo = Hero(
//         tag: 'hero',
//         child: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius: 60.0,
//             child: ClipOval(
//               child: Image.asset(
//                 'assets/images/default.png',
//                 fit: BoxFit.cover,
//                 width: 120.0,
//                 height: 120.0,
//               ),
//             )),
//       );

//       final signOutButton = Padding(
//         padding: EdgeInsets.symmetric(vertical: 16.0),
//         child: RaisedButton(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24),
//           ),
//           onPressed: () {
//             StateWidget.of(context).logOutUser();
//           },
//           padding: EdgeInsets.all(12),
//           color: Theme.of(context).primaryColor,
//           child: Text('SIGN OUT', style: TextStyle(color: Colors.white)),
//         ),
//       );

//       final forgotLabel = FlatButton(
//         child: Text(
//           'Forgot password?',
//           style: TextStyle(color: Colors.black54),
//         ),
//         onPressed: () {
//           Navigator.pushNamed(context, '/forgotPassword');
//         },
//       );

//       // final signUpLabel = FlatButton(
//       //   child: Text(
//       //     'Sign Up',
//       //     style: TextStyle(color: Colors.black54),
//       //   ),
//       //   onPressed: () {
//       //     Navigator.pushNamed(context, '/');
//       //   },
//       // );

      

//       final userId = appState?.firebaseUserAuth?.uid ?? '';
//       final email = appState?.firebaseUserAuth?.email ?? '';
//       final firstName = appState?.student?.firstName ?? '';
//       final lastName = appState?.student?.lastName ?? '';
//       final settingsId = appState?.settings?.settingsId ?? '';
//       final userIdLabel = Text('App Id: ');
//       final emailLabel = Text('Email: ');
//       final firstNameLabel = Text('First Name: ');
//       final lastNameLabel = Text('Last Name: ');
//       final settingsIdLabel = Text('SetttingsId: ');

//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: LoadingScreen(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 48.0),
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: <Widget>[
//                       logo,
//                       SizedBox(height: 48.0),
//                       userIdLabel,
//                       Text(userId,
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       SizedBox(height: 12.0),
                     
//                       firstNameLabel,
//                       Text(firstName,
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       SizedBox(height: 12.0),
//                       lastNameLabel,
//                       Text(lastName,
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       SizedBox(height: 12.0),
//                        emailLabel,
//                       Text(email,
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       SizedBox(height: 12.0),
//                       settingsIdLabel,
//                       Text(settingsId,
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       SizedBox(height: 12.0),
//                       signOutButton,
//                       forgotLabel
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             inAsyncCall: _loadingVisible),
//       );
//     }
//   }
// }