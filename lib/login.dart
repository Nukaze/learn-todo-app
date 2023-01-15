import 'package:TodoApp/authentication.dart';
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

  void _loginSubmission() async {
    FirebaseController fbs = FirebaseController();
    final formController = _formKey.currentState!;
    if (formController.validate()) {
      formController.save();
      Map<String, dynamic> fbsUserDocument = await fbs.getUserDocument(_email!);
      if (fbsUserDocument.isEmpty) {
        alert(context: context, title: "Login Failed", message: "Invalid email, Please enter a valid email.");
      }
      dprint("login data = ${fbsUserDocument.entries.map((v) => "${v.key}: ${v.value}\n")}");
      if (getAuthPasswordCheck(_password!, fbsUserDocument["user_password"], fbsUserDocument["user_salt"])) {
        dprint("logging-in successful");
        alert(
            context: context,
            title: "Login Successful",
            message: "Welcome back ${fbsUserDocument["user_email"]} going to Todo list",
            callback: () => navigateTo(context: context, pageName: "TodoList"));
      } else {
        dprint("logging-in failed");
        alert(context: context, title: "Login Failed", message: "Invalid password, Please enter a valid password.");
      }
    }
    // dprint(fbs.signIn("sekai@gmail.com", "sekai123"));
  }

  @override
  Widget build(BuildContext context) {
    Sqlitebase db = Sqlitebase();
    db.createDatabasePath("2test1");
    dprint("db = $db");

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome", style: Theme.of(context).textTheme.headline4),
            padbox(),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
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
                  padbox(),
                  TextFormField(
                    decoration: const InputDecoration(
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
            padbox(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Login"),
                onPressed: () {
                  dprint("login!");
                  _loginSubmission();
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                child: const Text("Sign-up"),
                onPressed: () {
                  dprint("Sign-up!");
                  navigateTo(context: context, routeName: "Registration");
                },
              ),
            ),
            padbox(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Guest"),
                onPressed: () {
                  dprint("Guest!");
                  navigateTo(context: context, routeName: "TodoList");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
