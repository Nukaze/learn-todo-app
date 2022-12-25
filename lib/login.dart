import 'package:flutter/material.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  Color textColor = Palette.textRGBO;
  Color text2 = Colors.amber;
  String ts1 = Palette.textRGBO.toString();
  String ts2 = Colors.amber.toString();
  // Color test1 = MaterialColor(Palette.textRGBO);
  @override
  Widget build(BuildContext context){
    print("pallette $ts1 colors $ts2");
    // print("\n test1 $test1");
    return Container(
      padding: const EdgeInsets.only(top: 150,bottom: 100, left: 20, right: 20),
      margin: const EdgeInsets.only(top: 0),
      alignment: Alignment.topCenter,
      constraints: const BoxConstraints(maxWidth: 160),
      decoration: BoxDecoration(
        color: Palette.secondaryRGBO,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(color: Palette.contrastRGBO, blurRadius: 5),
        ],
      ),
      child: const Text("Login!",style: TextStyle(color: Colors.amber, fontSize: 56)),
    );
  }
}