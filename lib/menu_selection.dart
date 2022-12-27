import "package:flutter/material.dart";


class MenuSelection extends StatefulWidget{
  const MenuSelection({super.key});
  @override
  State<MenuSelection> createState() => _MenuSelectionState();
}

class _MenuSelectionState extends State<MenuSelection>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:const Text("Menu"),
      ),
      body: Center(
        child: const Text("Menu Selection"),
      ),
    );
  }
}