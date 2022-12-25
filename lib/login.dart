import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 150,bottom: 100, left: 20, right: 20),
      margin: const EdgeInsets.only(top: 0),
      alignment: Alignment.topCenter,
      constraints: const BoxConstraints(maxWidth: 160),
      decoration: BoxDecoration(
        color: Color.fromRGBO(r, g, b, opacity),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 5),
        ],
      ),
      child: const Text("Login!",style: TextStyle(color: Colors.lightBlueAccent, fontSize: 56)),
    );
  }
}