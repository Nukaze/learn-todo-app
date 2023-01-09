import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tools.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String? _user, _pass;
  final _formkey = GlobalKey<FormState>();
  String? email, password, passwordConfirm;
  final FocusNode _emailNode = FocusNode(), _passwordNode = FocusNode();
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _passwordConfirmController = TextEditingController();
  bool _invalidEmail = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: registerInterface(),
    );
  }

  Widget registerInterface() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: registerForm(),
    );
  }

  Widget registerForm() {
    const double heightGap = 15;
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter your email", labelText: "Email"),
            onSaved: (value) => email = value,
            validator: _validateEmail,
            focusNode: _emailNode,
            controller: _emailController,
          ),
          padbox(height: heightGap),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter your password", labelText: "Password"),
            obscureText: true,
            onSaved: (value) => password = value,
            validator: (value) => _validatePassword(value, false),
            focusNode: _passwordNode,
            controller: _passwordController,
          ),
          padbox(height: heightGap),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter confirm password", labelText: "Confirm Password"),
            obscureText: true,
            onSaved: (value) => passwordConfirm = value,
            validator: (value) => _validatePassword(value, true),
            controller: _passwordConfirmController,
          ),
          padbox(height: heightGap * 1.6),
          ElevatedButton(
            onPressed: _formSubmission,
            child: const Text("Register!"),
          )
        ],
      ),
    );
  }

  void _formSubmission() {
    final registerForm = _formkey.currentState;
    if (registerForm!.validate()) {
      dprint("Register form is validated");
      registerForm.save();
      dprint("${registerForm} is saved");
      dprint("${_emailController.text} \n${_passwordConfirmController.text}");
    }
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      _emailNode.requestFocus();
      _invalidEmail = true;
      String e = "Please enter an email address";
      dprint(e);
      return e;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      _emailNode.requestFocus();
      _invalidEmail = true;
      String e = "Please enter a valid email address.";
      dprint(e);
      return e;
    }
    _invalidEmail = false;
    return null; // return null to validate complete
  }

  String? _validatePassword(String? value, bool confirmField) {
    const int lessCharacters = 6;
    void clearPassword() {
      if (!_invalidEmail) {
        _passwordNode.requestFocus();
      }
    }

    if (value!.isEmpty) {
      String e = "Please enter a password.";
      dprint(e);
      clearPassword();
      return e;
    }
    if (value.length < lessCharacters) {
      String e = "Please enter a password at least $lessCharacters characters.";
      dprint(e);
      clearPassword();
      return e;
    }
    if (!RegExp(r"[a-zA-z]").hasMatch(value)) {
      String e = "Password must contain at least one letter.";
      dprint(e);
      clearPassword();
      return e;
    }
    if (!RegExp(r"[0-9]").hasMatch(value)) {
      String e = "Password must contain at least one digit.";
      dprint(e);
      clearPassword();
      return e;
    }
    if (confirmField && _passwordController.text != _passwordConfirmController.text) {
      String e = "The password and confirm password must match";
      dprint(e);
      clearPassword();
      return e;
    }
    return null; // return null to validate complete
  }
}
