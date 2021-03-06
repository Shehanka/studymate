import 'package:flutter/material.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';
import 'package:studymate/widgets/loading.dart';

class ChangePasswordScreen extends StatefulWidget {
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newPassword = new TextEditingController();
  final TextEditingController _confirmNewPassword = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              'assets/images/default.png',
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );

    final newPassword = StudymateTextField(
        labelText: "New Password",
        textEditingController: _newPassword,
        validation: "password",
        obscureText: true,
        color: Colors.grey,
        icon: Icon(
          Icons.lock,
          color: Colors.grey,
        ));

    final confirmNewPassword = StudymateTextField(
        labelText: "Confirm New Password",
        textEditingController: _confirmNewPassword,
        validation: "confirm password",
        obscureText: true,
        color: Colors.grey,
        icon: Icon(
          Icons.lock,
          color: Colors.grey,
        ));

    final changePasswordButton = StudymateRaisedButton(
        "Change Password",
        () => {Navigator.of(context).pushNamed("/accountType")},
        Colors.deepPurple);

    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingScreen(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      logo,
                      SizedBox(height: 48.0),
                      newPassword,
                      SizedBox(height: 12.0),
                      confirmNewPassword,
                      SizedBox(height: 12.0),
                      changePasswordButton,
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loadingVisible),
    );
  }

  // Future<void> _changeLoadingVisible() async {
  //   setState(() {
  //     _loadingVisible = !_loadingVisible;
  //   });
  // }

  // // void _forgotPassword({String email, BuildContext context}) async {
  // //   SystemChannels.textInput.invokeMethod('TextInput.hide');
  // //   if (_formKey.currentState.validate()) {
  // //     try {
  // //       await _changeLoadingVisible();
  // //       // await Auth.forgotPasswordEmail(email);
  // //       // await _changeLoadingVisible();
  // //       // Flushbar(
  // //       //   title: "Password Reset Email Sent",
  // //       //   message:
  // //       //       'Check your email and follow the instructions to reset your password.',
  // //       //   duration: Duration(seconds: 20)
  // //       // )..show(context);
  // //     } catch (e) {
  //       _changeLoadingVisible();
  //       print("Forgot Password Error: $e");
  //       // String exception = Auth.getExceptionText(e);
  //       // Flushbar(
  //       //   title: "Forgot Password Error",
  //       //   message: exception,
  //       //   duration: Duration(seconds: 10),
  //       // )..show(context);
  //   }
  // } else {
  //   setState(() => _autoValidate = true);
  // }
  // }
}
