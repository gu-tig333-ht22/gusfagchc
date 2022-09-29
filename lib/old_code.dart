/*****************************************************************************/
  //     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  //     floatingActionButton: Stack(
  //       fit: StackFit.expand,
  //       children: [
  //         Positioned(
  //           right: 30,
  //           bottom: 20,
  //           child: FloatingActionButton(
  //             child: const Icon(Icons.add),
  //             onPressed: () async {
  //               var state = Provider.of<MyState>(context, listen: false);
  //               final recievedData = await Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) =>
  //                       CreateTaskView(ToDoTask(title: '', done: false)),
  //                 ),
  //               );
  //               state.addTask(recievedData);
  //               var apiData = await APIhandler.postToDo(recievedData);
  //               state.updateListState(apiData);
  //               print('list state was updated');
  //             },
  //           ),
  //         ),
  //         Positioned(
  //           bottom: 20,
  //           left: 30,
  //           child: FloatingActionButton(
  //             heroTag: 'next',
  //             onPressed: () {
  //               APIhandler().getMyIp();
  //               // var apiHandler = APIhandler();
  //               // apiHandler.getMyIp();
  //               // var state = Provider.of<MyState>(context, listen: false);
  //               // state.getMyIp();
  //             },
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: const Icon(
  //               Icons.web,
  //               size: 40,
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
///////////////////////////////////////////////////////////////
///
///import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.grey,
//       ),
//       home: const MyHomePage(title: 'To Do List'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<String> data = [];
//   Map<String, bool> checkMap = Map();
//   List<String> inCurrentView = [];
//   List<bool> currentViewValues = [true, false];

//   _MyHomePageState();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title), actions: [
//         IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {
//               _showDialog(context);
//             })
//       ]),
//       body: ListView.separated(
//         padding: const EdgeInsets.all(8),
//         itemCount: inCurrentView.length,
//         itemBuilder: (BuildContext context, int index) {
//           return CheckboxListTile(
//             controlAffinity: ListTileControlAffinity.leading,
//             value: checkMap[inCurrentView[index]],
//             onChanged: (bool? value) {
//               setState(() {
//                 checkMap[inCurrentView[index]] = value!;
//               });
//               nagotKladd();
//             },
//             title: _crossedoutListTitle(
//                 inCurrentView[index], checkMap[inCurrentView[index]]),
//             secondary: IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () {
//                 setState(() {
//                   final String current = inCurrentView[index];
//                   inCurrentView.removeAt(index);
//                   data.removeWhere((element) => element == current);
//                   if (data.contains(current) == false &&
//                       inCurrentView.contains(current) == false) {
//                     checkMap.remove(current);
//                   }
//                 });
//               },
//             ),
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) => const Divider(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final recievedData = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   SecondView(tasks: data, title: widget.title),
//             ),
//           );
//           setState(
//             () {
//               data = recievedData;
//               inCurrentView = recievedData;
//               for (var i = 0; i < data.length; i++) {
//                 if (checkMap.containsKey(data[i]) == false) {
//                   checkMap[data[i]] = false;
//                 }
//               }
//             },
//           );
//         },
//         tooltip: 'Add to the List',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   void nagotKladd() {
//     List<String> _inCurrentView = [];
//     data.forEach(
//       (element) {
//         if (currentViewValues.contains(checkMap[element])) {
//           _inCurrentView.add(element);
//         }
//       },
//     );
//     setState(() {
//       inCurrentView = _inCurrentView;
//     });
//   }

//   void _showDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Container(
//               height: 150,
//               width: 100,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         setState(() {
//                           currentViewValues = [true, false];
//                           nagotKladd();
//                         });
//                       },
//                       child: const Text('All')),
//                   TextButton(
//                       onPressed: () {
//                         setState(() {
//                           currentViewValues = [false];
//                           nagotKladd();
//                         });
//                       },
//                       child: const Text('Undone')),
//                   TextButton(
//                       onPressed: () {
//                         setState(() {
//                           currentViewValues = [true];
//                           nagotKladd();
//                         });
//                       },
//                       child: const Text('Done'))
//                 ],
//               )),
//         );
//       },
//     );
//   }

//   Widget _crossedoutListTitle(String listTitle, bool? value) {
//     if (value == true) {
//       return Text(
//         listTitle,
//         style: const TextStyle(decoration: TextDecoration.lineThrough),
//       );
//     } else {
//       return Text(listTitle);
//     }
//   }
// }

// class SecondView extends StatelessWidget {
//   final List<String> tasks;
//   final myController = TextEditingController();
//   final String title;

//   SecondView({super.key, required this.tasks, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Container(
//                 margin: const EdgeInsets.all(40),
//                 child: _addTextField(context)),
//             _addTextButton(context)
//           ],
//         ),
//       ),
//     );
//   }

//   void _addButtonPress(context) {
//     var toAdd = myController.text;
//     if (myController.text != '') {
//       if (tasks.contains(toAdd)) {
//         var n = 2;

//         while (tasks.contains(toAdd + ' ($n)')) {
//           n++;
//         }

//         toAdd += (' ($n)');
//       }

//       tasks.add(toAdd);
//       Navigator.pop(context, tasks);
//     }

//     myController.text = '';
//   }

//   Widget _addTextField(BuildContext context) {
//     return TextField(
//       decoration: const InputDecoration(
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.black, width: 2)),
//           focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                   color: Color.fromARGB(255, 22, 184, 46), width: 2)),
//           hintText: 'Vad vill/behöver du göra?'),
//       controller: myController,
//       onSubmitted: (value) {
//         _addButtonPress(context);
//       },
//     );
//   }

//   Widget _addTextButton(BuildContext context) {
//     return TextButton(
//       style: ButtonStyle(
//         foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
//       ),
//       onPressed: () {
//         _addButtonPress(context);
//       },
//       child: Container(
//         width: 80,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Icon(Icons.add),
//             Text('ADD'),
//           ],
//         ),
//       ),
//     );
//   }
// }
