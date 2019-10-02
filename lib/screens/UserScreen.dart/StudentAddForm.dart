//import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:googleapis/servicecontrol/v1.dart';
//import 'package:studymate/auth.dart';
//import 'package:studymate/models/Student.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';
import 'package:studymate/widgets/loading.dart';


class StudentAddScreen extends StatefulWidget {
  _StudentAddScreenState createState() => _StudentAddScreenState();
}

class _StudentAddScreenState extends State<StudentAddScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _confirmPassword = new TextEditingController();

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

   

    final email = StudymateTextField("Email", _email,
     "email", Colors.grey, TextInputType.emailAddress, Icon(Icons.email,color: Colors.grey,));

    final password = StudymateTextField("Password", _password,
     "password", Colors.grey, TextInputType.text, Icon(Icons.lock,color: Colors.grey,));

     final  confirmPassword = StudymateTextField("Confirm password", _confirmPassword,
     "confirmPassword", Colors.grey, TextInputType.text, Icon(Icons.lock,color: Colors.grey,));
  
  

    final signUpButton = StudymateRaisedButton("Create Account", ()=>{
       _emailSignUp(
              email: _email.text,
              password: _password.text,
              confirmPassword: _confirmPassword.text,
              context: context)
    }, Colors.deepPurple);
    

    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingScreen(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      logo,
                      SizedBox(height: 48.0),
                      email,
                      SizedBox(height: 24.0),
                      password,
                      SizedBox(height: 12.0),
                      confirmPassword,
                      SizedBox(height: 12.0),
                      signUpButton,
                     
                     
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

  void _emailSignUp(
      {
      String email,
      String password,
      String confirmPassword,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
 
        // await Auth.signUp(email, password).then((uID) {
        //   Auth.addUserSettingsDB(new User(
        //     userId: uID,
        //     email: email,
        //     firstName: firstName,
        //     lastName: lastName,
        //   ));
        // });
      
        await Navigator.pushNamed(context, '/sign_in');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
        //String exception = Auth.getExceptionText(e);
        // Flushbar(
        //   title: "Sign Up Error",
        //   message: exception,
        //   duration: Duration(seconds: 5),
        // )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
   
}
