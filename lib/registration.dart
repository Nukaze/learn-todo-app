import 'package:flutter/material.dart';

import 'tools.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String? _user, _pass;
  final _formkey = GlobalKey<FormState>();
  bool isFormSubmitting = false;
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
    TextFormField emailField = TextFormField(
      decoration: const InputDecoration(hintText: "Enter your email", labelText: "Email"),
      onSaved: (value) => email = value,
      validator: (value) => _validateEmail(value, isFormSubmitting),
      focusNode: _emailNode,
      controller: _emailController,
    );
    TextFormField passwordField = TextFormField(
      decoration: const InputDecoration(hintText: "Enter your password", labelText: "Password"),
      obscureText: true,
      onSaved: (value) => password = value,
      validator: (value) => _validatePassword(value, isFormSubmitting, false),
      focusNode: _passwordNode,
      controller: _passwordController,
    );
    TextFormField passwordConfirmField = TextFormField(
      decoration: const InputDecoration(hintText: "Enter confirm password", labelText: "Confirm Password"),
      obscureText: true,
      onSaved: (value) => passwordConfirm = value,
      validator: (value) => _validatePassword(value, isFormSubmitting, true),
      controller: _passwordConfirmController,
    );
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Focus(
            onFocusChange: _formValidation,
            child: emailField,
          ),
          padbox(height: heightGap),
          Focus(
            onFocusChange: _formValidation,
            child: passwordField,
          ),
          padbox(height: heightGap),
          Focus(
            onFocusChange: _formValidation,
            child: passwordConfirmField,
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

  void _formValidation(hasFocus) {
    bool hasChanged = !hasFocus;
    if (hasChanged) {
      _formkey.currentState!.validate();
    }
  }

  void _formSubmission() {
    isFormSubmitting = true;
    final registerForm = _formkey.currentState;
    if (registerForm!.validate()) {
      dprint("Register form is validated");
      registerForm.save();
      dprint("${registerForm} is saved");
      dprint("${_emailController.text} \n${_passwordConfirmController.text}");
    }
    dprint("_formSubmission");
    isFormSubmitting = false;
  }

  String? _validateEmail(String? value, bool onSubmitting) {
    if (value!.isEmpty) {
      if (onSubmitting) {
        _emailNode.requestFocus();
      }
      _invalidEmail = true;
      String e = "Please enter an email address";
      dprint(e);
      return e;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      if (onSubmitting) {
        _emailNode.requestFocus();
      }
      _invalidEmail = true;
      String e = "Please enter a valid email address.";
      dprint(e);
      return e;
    }
    dprint("Email is OKAY");
    _invalidEmail = false;
    return null; // return null to validate complete
  }

  String? _validatePassword(String? value, bool onSubmitting, bool isConfirmField) {
    const int lessCharacters = 6;
    final String msg = ["password", "confirm password"][isConfirmField ? 1 : 0];
    void passwordReqFocus() {
      if (!_invalidEmail && onSubmitting) {
        _passwordNode.requestFocus();
      }
    }

    if (value!.isEmpty) {
      String e = "Please enter a $msg.";
      dprint(e);
      passwordReqFocus();
      return e;
    }
    if (isConfirmField) {
      if (_passwordController.text != _passwordConfirmController.text) {
        String e = "The password and confirm password must match";
        dprint(e);
        passwordReqFocus();
        return e;
      }
    } else {
      if (value.length < lessCharacters) {
        String e = "Please enter a password at least $lessCharacters characters.";
        dprint(e);
        passwordReqFocus();
        return e;
      }
      if (!RegExp(r"[a-zA-z]").hasMatch(value)) {
        String e = "Password must contain at least one letter.";
        dprint(e);
        passwordReqFocus();
        return e;
      }
      if (!RegExp(r"[0-9]").hasMatch(value)) {
        String e = "Password must contain at least one digit.";
        dprint(e);
        passwordReqFocus();
        return e;
      }
    }
    return null; // return null to validate complete
  }
}