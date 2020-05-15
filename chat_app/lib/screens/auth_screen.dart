import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  Future<void> _submitAuthForm(String email, String username, String password, bool isLogin, BuildContext ctx) async {
    AuthResult result;
    try {
      if(isLogin) {
        // login
        result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        // sign up
        result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      }
    } on PlatformException catch (error) {
      var message = 'An error occurred, please check your credentials!';
      if(error.message != null) {
        message = error.message;
      }

      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    } catch(error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}