import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  Future<void> _submitAuthForm(
    String email, 
    String username, 
    String password, 
    bool isLogin, 
    File pickedImage,
    BuildContext ctx
  ) async {
    AuthResult result;
    try {
      setState(() {
        _isLoading = true;
      });

      if(isLogin) {
        // login
        result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        // sign up
        result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        // use firebase storage to upload the picked image
        final ref = FirebaseStorage.instance.ref().child('user_images').child(result.user.uid + '.jpg');
        await ref.putFile(pickedImage).onComplete;
        final imageUrl = await ref.getDownloadURL();

        // use firestore to store extra data
        await Firestore.instance.collection('users').document(result.user.uid).setData({
          'username': username,
          'email': email,
          'imageUrl': imageUrl
        });

        // No need to set loading to false since we will anyway navigate away
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

      setState(() {
        _isLoading = false;
      });
    } catch(error) {
      print(error);

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}