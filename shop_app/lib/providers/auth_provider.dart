import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

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
        throw HttpException(responseData['error']['message']);
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

}