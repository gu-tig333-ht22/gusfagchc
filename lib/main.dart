import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './create_task_view.dart';
import './model.dart';

void main() async {
  var state = MyState();
  state.listInit();
  runApp(ChangeNotifierProvider(
    create: (context) => state,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TIG333 ToDo-List App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: ToDoListView(),
    );
  }
}

class ToDoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo List'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              var state = Provider.of<MyState>(context, listen: false);
              state.setFilter(value);
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem(
                  value: '/all',
                  child: Text("All"),
                ),
                PopupMenuItem(
                  value: '/done',
                  child: Text("Done"),
                ),
                PopupMenuItem(
                  value: '/undone',
                  child: Text("Undone"),
                )
              ];
            },
          )
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) => ToDoList(
          _filterList(state.list, Provider.of<MyState>(context).filter),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var state = Provider.of<MyState>(context, listen: false);
          final recievedData = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateTaskView(ToDoTask(title: '', done: false)),
            ),
          );

          state.addTask(recievedData);
        },
      ),
    );
  }

  List<ToDoTask> _filterList(list, String filterBy) {
    if (filterBy == '/done') {
      return list.where((value) => value.done == true).toList();
    } else if (filterBy == '/undone') {
      return list.where((value) => value.done == false).toList();
    } else {
      return list;
    }
  }
}

//crash on return to home view should be fixed