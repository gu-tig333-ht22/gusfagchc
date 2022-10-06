import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:tdl_cp/api_methods.dart';

class MyState extends ChangeNotifier {
  List<ToDoTask> _list = [];
  List<ToDoTask> get list => _list;
  String _filter = '/all';
  String get filter => _filter;

  //MyState(this._list);

  void listInit() async {
    _list = await APIhandler.fetchToDoList();
    notifyListeners();
  }

  void addTask(ToDoTask task) async {
    _list.add(task);
    //
    notifyListeners();

    var apiData = await APIhandler.postToDo(task);
    updateListState(apiData);
    //
    notifyListeners();
  }

  void removeTask(ToDoTask task) {
    _list.remove(task);
    notifyListeners();
  }

  void changeValue(ToDoTask task) {
    bool value = task.done;
    task.done = !value;
    notifyListeners();
  }

  void setFilter(value) {
    _filter = value;
    notifyListeners();
  }

  void updateListState(obj) async {
    _list = jsonStringtoToDoList(jsonDecode(obj));
    notifyListeners();
  }

  List<ToDoTask> jsonStringtoToDoList(obj) {
    List<ToDoTask> fetchedList = [];
    obj.forEach(
      (element) {
        fetchedList.add(ToDoTask(
            id: element['id'], title: element['title'], done: element['done']));
      },
    );
    return fetchedList;
  }
}

class ToDoTask {
  String? id;
  String title;
  bool done;

  ToDoTask({this.id, required this.title, required this.done});

  String toAPI() => jsonEncode({'title': title, 'done': done});
}

class ToDoList extends StatelessWidget {
  final List<ToDoTask> list;
  const ToDoList(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: list.map((todo) => _todoItem(context, todo)).toList());
  }

  Widget _todoItem(context, ToDoTask todo) {
    return ListTile(
      onLongPress: () {},
      leading: Checkbox(
        value: todo.done,
        onChanged: (value) async {
          var myStateValue = Provider.of<MyState>(context, listen: false);
          myStateValue.changeValue(todo);
          var apiData = await APIhandler.changeToDo(todo);
          myStateValue.updateListState(apiData);
        },
      ),
      title: todo.done
          ? Text(
              todo.title,
              style: const TextStyle(
                decoration: TextDecoration.lineThrough,
              ),
            )
          : Text(todo.title),
      trailing: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () async {
          var state = Provider.of<MyState>(context, listen: false);
          state.removeTask(todo);
          var apiData = await APIhandler.deleteToDo(todo);
          state.updateListState(apiData);
        },
      ),
    );
  }
}
