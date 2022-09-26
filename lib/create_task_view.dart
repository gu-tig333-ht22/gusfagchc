import 'package:flutter/material.dart';
import './model.dart';
import './api_methods.dart';

class CreateTaskView extends StatelessWidget {
  final ToDoTask task;

  CreateTaskView(this.task);

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Tasks Here'),
      ),
      body: Column(
        children: [
          _addTextField(context),
          _addTextButton(context),
        ],
      ),
    );
  }

  void _addButtonPress(context) {
    task.title = myController.text;

    myController.text = '';
    Navigator.pop(context, task);
  }

  Widget _addTextField(context) {
    return Container(
      margin: const EdgeInsets.all(40),
      child: TextField(
        decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 22, 184, 46), width: 2),
            ),
            hintText: 'Vad vill/behöver du göra?'),
        controller: myController,
        onSubmitted: (value) {
          _addButtonPress(context);
        },
      ),
    );
  }

  Widget _addTextButton(context) {
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
