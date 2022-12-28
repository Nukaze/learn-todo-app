import 'package:flutter/material.dart';
import 'tools.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Key? _formKey;
  String? _user, _pass, userSession;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              // validator: (value) {
              // if (value!.isEmpty) {
              //   dprint('Please enter a valid email');
              // }
              // return null;
              // },
              onChanged: (value) => _user = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              // validator: (value) {
              //   if (value!.isEmpty) {
              //     dprint("Please enter a valid password");
              //   }
              //   return null;
              // },
              onChanged: (value) => _pass = value,
            ),
            TextButton(
              onPressed: () {
                if (_user!.isEmpty || _user!.length < 6) {
                  dprint("Please enter email and must be at least 6 characters");
                  return;
                } else if (_pass!.isEmpty || _pass!.length < 6) {
                  dprint("Please enter password and must be at least 6 characters");
                  return;
                }
                dprint("Loging in.. ${_formKey} | user : ${[_user?.length, _user]} | pass : ${[_pass?.length, _pass]}");
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
    //   child: const Text("MBTi Login\nนะจ๊ะ!",
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
