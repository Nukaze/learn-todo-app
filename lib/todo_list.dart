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
  List<String> todoList = ["wowoza"];
  List<int> todoSelected = [];
  @override
  Widget build(BuildContext context) {
    return todoApp();
  }

  Widget todoApp() {
    return Scaffold(
      appBar: AppBar(
        title: Text("[ Todo List ] ${widget.username}"),
      ),
      body: todoSection(),
      floatingActionButton: todoButtonSection(),
    );
  }

  Widget todoSection() {
    Widget todoItem(int todoIndex) {
      return ListTile(
        title: Text(todoList[todoIndex]),
        trailing: IconButton(
          icon: const Icon(Icons.ac_unit),
          onPressed: () {
            todoSelected.add(todoIndex);
            dprint("todoSelected = $todoSelected");
          },
        ),
      );
    }

    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        return todoItem(index);
      },
    );
  }

  Widget todoButtonSection() {
    padding({double width = 15, double height = 15}) => SizedBox(width: width, height: height);
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FloatingActionButton.extended(
              label: const Text("Add Task"),
              tooltip: "Add task",
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
    TextEditingController taskController = TextEditingController();
    void addSubmission(String value) {
      if (value.isNotEmpty) {
        setState(() {
          todoList.add(value);
        });
      } else {
        dprint("value is empty");
      }
      Navigator.pop(context);
    }

    setState(() {
      addingIcon = Icons.circle;
      dprint("Add todo task");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('New task'),
              content: TextField(
                autofocus: true,
                controller: taskController,
                onSubmitted: (val) {
                  addSubmission(val);
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your task to do...',
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    addSubmission(taskController.text);
                  },
                  icon: const Icon(Icons.add_circle_rounded),
                  label: const Text("Add Task"),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"))
              ],
            );
          }).then((value) {
        if (value == null) {
          setState(() {
            addingIcon = Icons.add_circle_rounded;
          });
        }
      });
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
