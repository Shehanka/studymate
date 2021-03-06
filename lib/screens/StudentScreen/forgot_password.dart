import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';
import 'package:studymate/widgets/loading.dart';

class ForgotPasswordScreen extends StatefulWidget {
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();

  String userEmail;
  bool _autoValidate = false;
  bool _loadingVisible = false;
  @override
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

    final email = StudymateTextField(
        labelText: "Email",
        textEditingController: _email,
        validation: "email",
        icon: Icon(
          Icons.email,
          color: Colors.grey,
        ));

    final forgotPasswordButton = StudymateRaisedButton(
        "Forgot Password",
        () => {
              Authentication()
                  .forgotPasswordEmail(email.textEditingController.text)
            },
        Colors.deepPurple);

    final signInLabel = FlatButton(
      child: Text(
        'You have a account? Sign In',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/signin');
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot password'),
      ),
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
                      email,
                      SizedBox(height: 12.0),
                      forgotPasswordButton,
                      signInLabel
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loadingVisible),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void forgotPasswordEmail({String email, BuildContext context}) async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_formKey.currentState.validate()) {
      try {
        await _changeLoadingVisible();
        await Authentication().forgotPasswordEmail(email);
        await _changeLoadingVisible();
        Flushbar(
            title: "Password Reset Email Sent",
            message:
                'Check your email and follow the instructions to reset your password.',
            duration: Duration(seconds: 20))
          ..show(context);
      } catch (e) {
        _changeLoadingVisible();
        print("Forgot Password Error: $e");
        String exception = Authentication.getExceptionText(e);
        Flushbar(
          title: "Forgot Password Error",
          message: exception,
          duration: Duration(seconds: 10),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
