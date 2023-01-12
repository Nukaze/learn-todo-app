import 'package:flutter/material.dart';

import 'database_controller.dart';
import 'tools.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password, _userSession;
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();

  void _loginSubbmission() {
    FirebaseController fbs = FirebaseController();
    dprint(fbs.signIn("sekai@gmail.com", "sekai123"));
  }

  @override
  Widget build(BuildContext context) {
    Sqlitebase db = Sqlitebase();
    db.createDatabasePath("2test1");
    dprint("db = $db");

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome", style: Theme.of(context).textTheme.headline4),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text("Login"),
                onPressed: () {
                  dprint("login!");
                  _loginSubbmission();
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );

    // return Scaffold(
    //   body: Form(
    //     key: _formKey,
    //     child: Column(
    //       children: [
    //         TextFormField(
    //           decoration: const InputDecoration(labelText: 'Email'),
    //           initialValue: _email,
    //           onChanged: (value) => _email = value,
    //           focusNode: _focusEmail,
    //         ),
    //         const SizedBox(
    //           width: 100,
    //           height: 25,
    //         ),
    //         TextFormField(
    //           decoration: const InputDecoration(labelText: 'Password'),
    //           obscureText: true,
    //           initialValue: _password,
    //           onChanged: (value) => _password = value,
    //           focusNode: _focusPassword,
    //         ),
    //         TextButton(
    //           onPressed: _loginSubmission,
    //           child: const Text('Login'),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
