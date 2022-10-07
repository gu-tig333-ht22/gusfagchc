import 'package:http/http.dart' as http;
import 'dart:convert';
import './model.dart';

//skickar koden igen

class APIhandler {
  static String _apiKey = 'f740e31c-251c-4bdf-a602-edc76ac6f7b8';
  static String _uri = 'https://todoapp-api.apps.k8s.gu.se/';
  static Map<String, String> headerContentType = {
    'content-type': 'application/json'
  };

  static Future<List<ToDoTask>> fetchToDoList() async {
    List<ToDoTask> fetchedList = [];
    http.Response response =
        await http.get(Uri.parse('${_uri}todos?key=$_apiKey'));
    var obj = jsonDecode(response.body);
    obj.forEach((element) {
      fetchedList.add(ToDoTask(
          id: element['id'], title: element['title'], done: element['done']));
    });
    return fetchedList;
  }

  static Future<String> postToDo(recievedData) async {
    http.Response response = await http.post(
        Uri.parse('${_uri}todos?key=$_apiKey'),
        headers: headerContentType,
        body: recievedData.toAPI());

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('statusCode ${response.statusCode}');
    }
  }

  static Future<String> changeToDo(ToDoTask todo) async {
    var id = todo.id;
    var sendData = {'title': todo.title, 'done': todo.done};

    http.Response response = await http.put(
        Uri.parse('${_uri}todos/$id?key=$_apiKey'),
        headers: headerContentType,
        body: jsonEncode(sendData));

    var jsonData = response.body;
    return jsonData.toString();
  }

  static Future<String> deleteToDo(ToDoTask todo) async {
    var id = todo.id;
    http.Response response =
        await http.delete(Uri.parse('${_uri}todos/$id?key=$_apiKey'));
    return response.body;
  }

  void getMyIp() async {}
}
