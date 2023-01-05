import 'package:flutter/material.dart';
import 'tools.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, this.username});
  final String? username;
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  IconData addingIcon = Icons.add_circle_rounded;
  @override
  Widget build(BuildContext context) {
    return todoApp();
  }

  Widget todoApp() {
    return Scaffold(
      appBar: AppBar(
        title: Text("[ Todo List ] ${widget.username}"),
      ),
      // body: todoSection(),
      floatingActionButton: todoButtonSection(),
    );
  }

  // Widget todoSection() {
  //   return;
  // }

  Widget todoButtonSection() {
    padding({double width = 15, double height = 15}) => SizedBox(width: width, height: height);
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FloatingActionButton.extended(
              label: const Text("Add Todo"),
              icon: Icon(addingIcon),
              heroTag: "addTodoBtn",
              onPressed: _addTodo,
              backgroundColor: Palette.secondary,
            ),
            padding(),
            FloatingActionButton(
              heroTag: "completeTodoBtn",
              onPressed: () {
                dprint("eiei");
              },
              backgroundColor: Palette.contrast,
              child: const Icon(Icons.task_alt),
            ),
            padding(),
            FloatingActionButton(
              heroTag: "deleteTodoBtn",
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Deleting"),
                        icon: const Icon(Icons.snowboarding),
                        content: const Text("Are sure to delete your todo you chose"),
                        actions: [
                          TextButton(onPressed: _deleteTodo, child: const Text("Yes")),
                          TextButton(onPressed: () => {Navigator.of(context).pop()}, child: const Text("No")),
                        ],
                      );
                    });
              },
              backgroundColor: Palette.setColor("#777777"),
              child: const Icon(Icons.delete_rounded),
            ),
          ],
        ));
  }

  void _addTodo() {
    setState(() {
      addingIcon = addingIcon == Icons.add_circle_rounded ? Icons.circle_outlined : Icons.add_circle_rounded;
      dprint("Add todo");
    });
  }

  void _deleteTodo() {
    setState(() {
      dprint("Deleting");
    });
  }

  void _completeTodo() {
    setState(() {
      dprint("Completing");
    });
  }
}
