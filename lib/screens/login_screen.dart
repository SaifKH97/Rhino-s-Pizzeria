import 'package:flutter/material.dart';
import 'package:rhino_pizzeria/constants.dart';
import 'package:rhino_pizzeria/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  /////////////////////////////////////////
  //admin:
  //email: admin@email.com
  //password: 123456
  /////////////////////////////////////////
  //user:
  //email: user@email.com
  //password: 123456
  /////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.black,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: Colors.deepOrange,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 300.0,
                      child: Image.asset('images/rhinos-logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  controller: emailTextController,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  controller: passwordTextController,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  text: 'Log In',
                  color: Colors.deepOrange,
                  onTap: () async {
                    emailTextController.clear();
                    passwordTextController.clear();
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      email = '';
                      password = '';
                      Navigator.pushNamed(context, '/menu_screen');
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                      setState(() {
                        showSpinner = false;
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Alert!'),
                            content: Text('User doesn\'t exist, make sure you\'re using the right email and password'),
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
