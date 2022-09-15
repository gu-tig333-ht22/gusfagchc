import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'To Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> data = [];
  Map<String, bool?> checkMap = Map();

  _MyHomePageState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: checkMap[data[index]],
            onChanged: (bool? value) {
              setState(() {
                checkMap[data[index]] = value!;
              });
            },
            title: _crossedoutListTitle(data[index], checkMap[data[index]]),
            secondary: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  final String current = data[index];
                  data.removeAt(index);
                  if (data.contains(current) == false) {
                    checkMap.remove(current);
                  }
                });
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final recievedData = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SecondView(tasks: data, title: widget.title),
            ),
          );
          setState(
            () {
              data = recievedData;
              for (var i = 0; i < data.length; i++) {
                if (checkMap.containsKey(data[i]) == false) {
                  checkMap[data[i]] = false;
                  //print(checkMap);
                }
              }
            },
          );
        },
        tooltip: 'Add to the List',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _crossedoutListTitle(String listTitle, bool? value) {
    if (value == true) {
      return Text(
        listTitle,
        style: TextStyle(decoration: TextDecoration.lineThrough),
      );
    } else {
      return Text(listTitle);
    }
  }
}

class SecondView extends StatelessWidget {
  final List<String> tasks;
  final myController = TextEditingController();
  final String title;

  SecondView({super.key, required this.tasks, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(40),
                child: _addTextField(context)),
            _addTextButton(context)
          ],
        ),
      ),
    );
  }

  void _addButtonPress(context) {
    if (myController.text != '') {
      tasks.add(myController.text);
      Navigator.pop(context, tasks);
    }

    myController.text = '';
  }

  Widget _addTextField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 22, 184, 46), width: 2)),
          hintText: 'Vad vill/behöver du göra?'),
      controller: myController,
      onSubmitted: (value) {
        _addButtonPress(context);
      },
    );
  }

  Widget _addTextButton(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
      onPressed: () {
        _addButtonPress(context);
      },
      child: Container(
        width: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add),
            Text('ADD'),
          ],
        ),
      ),
    );
  }
}
