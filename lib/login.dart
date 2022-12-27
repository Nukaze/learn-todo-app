import 'package:flutter/material.dart';
import 'tools.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>{
  @override
  Widget build(BuildContext context){
    int textValue = Palette.text.value;
    int textMateValue = Palette.textMate.value;
    debugPrint("${textValue} || ${textMateValue}");
    return Container(
      padding: const EdgeInsets.only(top: 150,bottom: 100, left: 20, right: 20),
      margin: const EdgeInsets.only(top: 40),
      alignment: Alignment.topCenter,
      constraints: const BoxConstraints(maxWidth: 160),
      decoration: BoxDecoration(
        color: Palette.secondary,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          const BoxShadow(color: Palette.contrast, blurRadius: 10),
        ],
      ),
      child: const Text("Login!",style: TextStyle(color: Palette.text, fontSize: 56)),
    );
  }
}