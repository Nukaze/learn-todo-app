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
  static const IconData iconItemUndone = Icons.radio_button_unchecked_rounded;
  static const IconData iconItemCheck = Icons.check_circle;
  static const IconData iconItemDone = Icons.done_all_rounded;
  List<Map<String, dynamic>> todoList = [
    {"content": "complete the todo app!", "status": "undone", "icon": iconItemUndone}
  ];
  List<int> taskSelected = [];
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
        title: Text(todoList[todoIndex]["content"]!),
        trailing: IconButton(
          icon: Icon(todoList[todoIndex]["icon"]),
          onPressed: () {
            setState(() {
              dprint("${todoList[todoIndex]}");
              dprint(todoList[todoIndex]["status"] != "done");
              if (todoList[todoIndex]["status"] != "done") {
                if (taskSelected.contains(todoIndex)) {
                  taskSelected.remove(todoIndex);
                  todoList[todoIndex]["icon"] = iconItemUndone;
                  todoList[todoIndex]["status"] = "undone";
                } else {
                  taskSelected.add(todoIndex);
                  todoList[todoIndex]["icon"] = iconItemCheck;
                  todoList[todoIndex]["status"] = "checked";
                }
              }
              dprint("taskSelected = $taskSelected");
            });
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
              onPressed: _completeTodo,
              backgroundColor: Palette.contrast,
              child: const Icon(Icons.task_alt),
            ),
            padding(),
            FloatingActionButton(
              heroTag: "deleteTodoBtn",
              onPressed: _deleteTodo,
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
          todoList.add({"content": value, "status": "undone", "icon": iconItemUndone});
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
    void deleteSubmission() {
      dprint("todo list length = ${todoList.length}");
      dprint("task selected = $taskSelected");
      setState(() {
        todoList.removeWhere((todo) => todo["status"] == "checked");
        taskSelected.clear();
        destroy(context);
        dprint("deleted!!");
      });
      dprint("todo list length = ${todoList.length}");
      dprint("task selected = $taskSelected");
    }

    setState(() {
      dprint("Deleting");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Delete task"),
              content: const Text("Are you sure you want to delete task you chose?"),
              actions: [
                TextButton(onPressed: deleteSubmission, child: const Text("Delete")),
                TextButton(onPressed: () => destroy(context), child: const Text("Cancel"))
              ],
            );
          });
    });
  }

  void _completeTodo() {
    void completeSubmission() {
      dprint("completeSubmission..");
      setState(() {
        for (Map<String, dynamic> v in todoList) {
          if (v["status"] == "checked") {
            v["status"] = "done";
            v["icon"] = Icons.done_all_rounded;
          }
        }
        destroy(context);
      });
    }

    setState(() {
      dprint("Completing");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Complete task"),
              content: const Text("Are you want to complete task you chose?\n(you cannot edit after complete task)"),
              actions: [
                TextButton(onPressed: completeSubmission, child: const Text("Complete task!")),
                TextButton(onPressed: () => destroy(context), child: const Text("Cancel"))
              ],
            );
          });
    });
  }
}
