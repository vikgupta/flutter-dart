import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String, String, String, bool) authDetailsSubmitHandler;

  AuthForm(this.authDetailsSubmitHandler);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid =_formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(isValid) {
      _formKey.currentState.save();

      widget.authDetailsSubmitHandler(_userEmail, _userName, _userPassword, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    validator: (value) {
                      if(value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if(!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Please enter a valid username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return 'Please enter a valid password';
                      } else if(value.length < 6) {
                        return 'Password should be at least 6 characters long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(height: 12),
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'Sign Up'),
                    onPressed: _trySubmit,
                  ),
                  SizedBox(height: 6),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_isLogin ? 'Create new Account' : 'I already have an account'),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}