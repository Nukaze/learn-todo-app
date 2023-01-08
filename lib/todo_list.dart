import 'package:flutter/material.dart';
import 'tools.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, this.username});
  final String? username;
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  IconData addingBtnIcon = Icons.add_circle_rounded;
  final IconData completeBtnIcon = Icons.task_alt;
  final IconData deleteBtnIcon = Icons.delete_rounded;
  static const IconData iconItemUndone = Icons.radio_button_unchecked_rounded;
  static const IconData iconItemCheck = Icons.check_circle;
  static const IconData iconItemDone = Icons.done_all_rounded;
  static List<int> taskSelected = [];
  bool isAddButtonSelected = false;
  bool isCompleteButtonSelected = false;
  bool isDeleteButtonSelected = false;
  List<Map<String, dynamic>> todoList = [
    {
      //mock up data1
      "content": "Complete the todo app!",
      "status": "undone",
      "icon": iconItemUndone,
    },
    {
      //mock up data2
      "content": "Learn mobile app database",
      "status": "undone",
      "icon": iconItemUndone,
    }
  ];

  @override
  Widget build(BuildContext context) {
    getPath();
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
            isAddButtonSelected
                ? FloatingActionButton.extended(
                    label: const Text("Add Task"),
                    tooltip: "Add task",
                    icon: Icon(addingBtnIcon),
                    heroTag: "addTodoBtn",
                    onPressed: _addTodo,
                    backgroundColor: Palette.secondary)
                : FloatingActionButton(
                    tooltip: "Add task",
                    child: Icon(addingBtnIcon),
                    heroTag: "addTodoBtn",
                    onPressed: _addTodo,
                    backgroundColor: Palette.secondary),
            padding(),
            isCompleteButtonSelected
                ? FloatingActionButton.extended(
                    label: const Text("Complete task"),
                    tooltip: "Add task",
                    icon: Icon(completeBtnIcon),
                    heroTag: "completeTodoBtn",
                    onPressed: _completeTodo,
                    backgroundColor: Palette.contrast)
                : FloatingActionButton(
                    heroTag: "completeTodoBtn",
                    onPressed: _completeTodo,
                    backgroundColor: Palette.contrast,
                    child: Icon(completeBtnIcon)),
            padding(),
            isDeleteButtonSelected
                ? FloatingActionButton.extended(
                    heroTag: "deleteTodoBtn",
                    onPressed: _deleteTodo,
                    backgroundColor: Palette.setColor("#777777"),
                    icon: const Icon(Icons.delete_rounded),
                    label: const Text("Delete Task"))
                : FloatingActionButton(
                    heroTag: "deleteTodoBtn",
                    onPressed: _deleteTodo,
                    backgroundColor: Palette.setColor("#777777"),
                    child: const Icon(Icons.delete_rounded)),
          ],
        ));
  }

  void _addTodo() async {
    TextEditingController taskController = TextEditingController();

    void addSubmission(String value) {
      final bool isNotBlankOnly = !RegExp(r"^\s*$").hasMatch(value);
      if (value.isNotEmpty && isNotBlankOnly) {
        setState(() {
          todoList.add({"content": value.trim(), "status": "undone", "icon": iconItemUndone});
        });
        destroy(context);
        alert(context: context, title: "Successfully", message: "Your Task has been added successfully.");
      } else {
        alert(context: context, title: "Error", message: "Task should not be empty, \nPlease fill a task.");
      }
    }

    setState(() {
      addingBtnIcon = Icons.circle;
      isAddButtonSelected = true;
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
                  label: const Text("Add Task!"),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"))
              ],
            );
          }).then((value) => setState(() {
            addingBtnIcon = Icons.add_circle_rounded;
            isAddButtonSelected = false;
          }));
    });
  }

  void _completeTodo() {
    void completeSubmission() {
      dprint("completeSubmission..");
      setState(() {
        for (Map<String, dynamic> v in todoList) {
          if (v["status"] == "checked") {
            v["status"] = "done";
            v["icon"] = iconItemDone;
          }
        }
        taskSelected.clear();
        destroy(context);
      });
    }

    setState(() {
      dprint("Completing");
      isCompleteButtonSelected = true;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Complete task"),
              content: Text(
                  "Are you want to complete [ ${taskSelected.length} ] tasks \nyou chose?\n(you cannot edit after complete task)"),
              actions: [
                TextButton(onPressed: completeSubmission, child: const Text("Complete task!")),
                TextButton(onPressed: () => destroy(context), child: const Text("Cancel"))
              ],
            );
          }).then((value) => setState(() {
            isCompleteButtonSelected = false;
          }));
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
      isDeleteButtonSelected = true;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Delete task"),
              content: Text("Are you want to delete [ ${taskSelected.length} ] tasks \nyou chose?"),
              actions: [
                TextButton(onPressed: deleteSubmission, child: const Text("Delete!")),
                TextButton(onPressed: () => destroy(context), child: const Text("Cancel"))
              ],
            );
          }).then((value) => setState(() {
            isDeleteButtonSelected = false;
          }));
    });
  }
}
