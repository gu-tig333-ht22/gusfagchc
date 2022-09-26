import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import './model.dart';

class APIhandler {
  static String _api_key = 'f740e31c-251c-4bdf-a602-edc76ac6f7b8';
  static String _uri = 'https://todoapp-api.apps.k8s.gu.se/';
  static Map<String, String> headerContentType = {
    'content-type': 'application/json'
  };

  static Future<List<ToDoTask>> fetchToDoList() async {
    List<ToDoTask> fetchedList = [];
    http.Response response =
        await http.get(Uri.parse('${_uri}todos?key=${_api_key}'));
    var obj = jsonDecode(response.body);
    obj.forEach((element) {
      fetchedList.add(ToDoTask(
          id: element['id'], title: element['title'], done: element['done']));
    });
    return fetchedList;
  }

  static Future<String> postToDo(recievedData) async {
    http.Response response = await http.post(
        Uri.parse('${_uri}todos?key=${_api_key}'),
        headers: headerContentType,
        body: recievedData.toAPI());

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('statusCode ${response.statusCode}');
    }
  }

  static Future<String> changeToDo(ToDoTask todo) async {
    var _id = todo.id;
    var sendData = {'title': todo.title, 'done': todo.done};

    http.Response response = await http.put(
        Uri.parse('${_uri}todos/${_id}?key=${_api_key}'),
        headers: headerContentType,
        body: jsonEncode(sendData));

    var jsonData = response.body;
    return jsonData.toString();
  }

  static Future<String> deleteToDo(ToDoTask todo) async {
    var _id = todo.id;
    http.Response response =
        await http.delete(Uri.parse('${_uri}todos/${_id}?key=${_api_key}'));
    return response.body;
  }

  void getMyIp() async {
    var fetched = await fetchToDoList();
  }
}


/*
GET /register
Get your API key

GET /todos?key=[YOUR API KEY]
List todos.

Will return an array of todos.

POST /todos?key=[YOUR API KEY]
Add todo.

Takes a Todo as payload (body). Remember to set the Content-Type header to application/json.

Will return the entire list of todos, including the added Todo, when successful.

PUT /todos/:id?key=[YOUR API KEY]
Update todo with :id

Takes a Todo as payload (body), and updates title and done for the already existing Todo with id in URL.

DELETE /todos/:id?key=[YOUR API KEY]
Deletes a Todo with id in URL

*/
