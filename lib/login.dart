import 'package:flutter/material.dart';
import 'tools.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _user = "", _pass = "";
  String? userSession;

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      String e = "Please enter an email address";
      dprint(e);
      return e;
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      String e = "Please enter a valid email address.";
      dprint(e);
      return e;
    }
    return null; // return null to validate complete
  }

  String? validatePassword(String? value) {
    const int lessCharacters = 6;
    if (value!.isEmpty) {
      String e = "Please enter a password.";
      dprint(e);
      return e;
    }
    if (value.length < lessCharacters) {
      String e = "Please enter a password at least $lessCharacters characters.";
      dprint(e);
      return e;
    }
    if (!RegExp(r"[a-zA-z]").hasMatch(value)) {
      String e = "Password must contain at least one letter.";
      dprint(e);
      return e;
    }
    if (!RegExp(r"[0-9]").hasMatch(value)) {
      String e = "Password must contain at least one digit.";
      dprint(e);
      return e;
    }
    return null; // return null to validate complete
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              initialValue: _user,
              onChanged: (value) => _user = value,
              validator: validateEmail,
            ),
            const SizedBox(
              width: 100,
              height: 25,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              initialValue: _pass,
              onChanged: (value) => _pass = value,
              validator: validatePassword,
            ),
            TextButton(
              onPressed: () {
                dprint(
                    "Logging in.. ${_formKey} | user : ${[_user?.length, _user]} | pass : ${[_pass?.length, _pass]}");
                if (_formKey.currentState!.validate()) {
                  dprint("validated login");
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );

    // Scaffold(
    //   body: Column(
    //     children: [
    //       TextField(
    //           decoration: InputDecoration(labelText: "User"),
    //           onChanged: (value) {
    //             _user = value;
    //           }),
    //       TextField(
    //         decoration: InputDecoration(labelText: "Password"),
    //         obscureText: true,
    //         onChanged: (value) {
    //           _pass = value;
    //         },
    //       ),
    //       TextButton(
    //         onPressed: () {
    //           dprint("$_user $_pass");
    //           if (_pass!.isEmpty) {
    //             dprint("pass isempty");
    //           }
    //           // You can now use the email and password in your onPressed function
    //         },
    //         child: const Text("Sign In"),
    //       ),
    //     ],
    //   ),
    // );

    //   Container(
    //   padding: const EdgeInsets.only(
    //     top: 150,
    //     bottom: 100,
    //     left: 20,
    //     right: 20,
    //   ),
    //   margin: const EdgeInsets.only(top: 40),
    //   alignment: Alignment.topCenter,
    //   constraints: const BoxConstraints(maxWidth: 160),
    //   decoration: BoxDecoration(
    //     color: Palette.secondary,
    //     borderRadius: BorderRadius.circular(4),
    //     boxShadow: const [
    //       BoxShadow(
    //         color: Palette.contrast,
    //         blurRadius: 10,
    //       ),
    //     ],
    //   ),
    //   child: const Text("MBTi Login\n นะจ๊ะ!",
    //       style: TextStyle(
    //         color: Palette.text,
    //         fontSize: 56,
    //         fontFamily: "Kanit",
    //         fontWeight: FontWeight.w700,
    //         decoration: TextDecoration.none,
    //       )),
    // );
  }
}
