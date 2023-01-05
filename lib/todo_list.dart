import 'package:flutter/material.dart';
import 'tools.dart';

class TodoList extends StatefulWidget {
  @override
  const TodoList({super.key, this.username});
  final String? username;
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return scaffoldApp();
  }

  Widget scaffoldApp() {
    return Scaffold(
      appBar: AppBar(
        title: Text("[ Todo List ] ${widget.username}"),
      ),
    );
  }

  Widget todoApp() {
    return;
  }

  Widget buttonApp() {
    return;
  }
}
