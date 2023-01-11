import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
import 'tools.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
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

  void _formSubmission() async {
    isFormSubmitting = true;
    final registerForm = _formkey.currentState;
    if (registerForm!.validate()) {
      registerForm.save();
      final QuerySnapshot qrSnapshot =
          await FirebaseFirestore.instance.collection("users").where("user_email", isEqualTo: email).get();
      bool isAlreadyRegistered = qrSnapshot.docs.isNotEmpty;
      dprint("query snapshot is $isAlreadyRegistered = ${qrSnapshot.docs}");
      if (isAlreadyRegistered) {
        alert(
            context: context,
            title: "Register failed",
            message: "This email is already registered, Please try again with another email.");
        return;
      }
      Map<String, String> userCredential = getAuthPasswordGenerate(password!);
      CollectionReference userRegisterInstance = FirebaseFirestore.instance.collection("users");
      try {
        await userRegisterInstance.add({
          "user_email": email,
          "user_password": userCredential["password"],
          "user_salt": userCredential["salt"],
          "time_created": getFullTime(),
          "time_unix_created": getUnixTime(),
        });
        DocumentSnapshot snapshot = await userRegisterInstance.doc(email).get();
        dprint("after regis snapshot id = ${snapshot.id}");
        registerForm.reset();
        email = null;
        password = null;
        passwordConfirm = null;
        alert(
            context: context,
            title: "Register complete!",
            message: "Your account has been registered successfully.",
            callback: () => navigateTo(context: context, pageName: "Login"));
      } catch (e) {
        dprint("Failed to register with $e");
        alert(context: context, title: "Instance Error", message: "Failed to register with $e");
      }
    }
    isFormSubmitting = false;
  }

  String? _validateEmail(String? value, bool onSubmitting) {
    if (value!.isEmpty) {
      if (onSubmitting) {
        _emailNode.requestFocus();
      }
      _invalidEmail = true;
      String e = "Please enter an email address";
      return e;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      if (onSubmitting) {
        _emailNode.requestFocus();
      }
      _invalidEmail = true;
      String e = "Please enter a valid email address.";
      return e;
    }
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
      passwordReqFocus();
      return e;
    }
    if (isConfirmField) {
      if (_passwordController.text != _passwordConfirmController.text) {
        String e = "The password and confirm password must match";
        passwordReqFocus();
        return e;
      }
    } else {
      if (value.length < lessCharacters) {
        String e = "Please enter a password at least $lessCharacters characters.";
        passwordReqFocus();
        return e;
      }
      if (!RegExp(r"[a-zA-z]").hasMatch(value)) {
        String e = "Password must contain at least one letter.";
        passwordReqFocus();
        return e;
      }
      if (!RegExp(r"[0-9]").hasMatch(value)) {
        String e = "Password must contain at least one digit.";
        passwordReqFocus();
        return e;
      }
    }
    return null; // return null to validate complete
  }
}
