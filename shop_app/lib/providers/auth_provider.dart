import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart' as sp;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  Future<void> _authenticate(String email, String pwd, String url) async {
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': pwd,
          'returnSecureToken': true
        }),
      );

      final responseData = json.decode(response.body);
      if(responseData['error'] != null) {
        // Server returned error
        throw HttpException(responseData['error']['message']);
      } else {
        _token = responseData['idToken'];
        _userId = responseData['localId'];
        _expiryDate = DateTime.now().add(Duration(seconds: int.parse(responseData['expiresIn'])));
        _autoLogout();
        notifyListeners();

        // shared token in local storage
        final prefs = await sp.SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String()
        });
        prefs.setString('userData', userData);
      }
    } catch(error) {
      throw error;
    }
    
  }

  Future<void> signup(String email, String pwd) async {
    return _authenticate(
      email, 
      pwd, 
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA-f2YNcTVV2OmzxCO4Q8kPZ0OHAkRK0c4'
    );
  }

  Future<void> login(String email, String pwd) async {
    return _authenticate(
      email, 
      pwd, 
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA-f2YNcTVV2OmzxCO4Q8kPZ0OHAkRK0c4'
    );
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await sp.SharedPreferences.getInstance();
    if(!prefs.containsKey('userData')) {
      return false;
    }

    final userData = json.decode(prefs.getString('userData')) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(userData['expiryDate']);
    if(expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = userData['token'];
    _userId = userData['userId'];
    _expiryDate = expiryDate;
    _autoLogout();
    notifyListeners();
    return true;
  }

  String get token {
    if(_token != null && _expiryDate != null && _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }

    return null;
  }

  bool get isAuthenticated {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  void logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if(_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }

    final prefs = await sp.SharedPreferences.getInstance();
    prefs.remove('userData');

    notifyListeners();
  }

  void _autoLogout() {
    if(_authTimer != null) {
      _authTimer.cancel();
    }
    int timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

}