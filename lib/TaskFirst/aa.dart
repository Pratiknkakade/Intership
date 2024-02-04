// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   final CollectionReference users =
//       FirebaseFirestore.instance.collection('9922535136');

//   Future<List<DocumentSnapshot>> getUsers() async {
//     QuerySnapshot querySnapshot = await users.get();
//     return querySnapshot.docs;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Firestore GridView'),
//       ),
//       body: FutureBuilder<List<DocumentSnapshot>>(
//         future: getUsers(),
//         builder: (BuildContext context,
//             AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }

//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }

//           List<DocumentSnapshot> data = snapshot.data!;

//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 4,
//               crossAxisSpacing: 8.0,
//               mainAxisSpacing: 8.0,
//             ),
//             itemCount: data.length,
//             itemBuilder: (BuildContext context, int index) {
//               var document = data[index];
//               var name = document['name'];

//               return Card(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(name),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }








// rContainer(
//                           padding: const EdgeInsets.all(10),
//                           margin: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 5,
//                                 spreadRadius: 2,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             children: [
//                               // Center(
//                               //     child: Text(
//                               //         data[infoprovider.inputValue[index]])),
//                               Center(child: infoprovider.dateWidgets[index]),
//                             ],
//                           ),
//                         );









  // return GridView.builder(
  //                   gridDelegate:
  //                       const SliverGridDelegateWithFixedCrossAxisCount(
  //                     crossAxisCount: 4,
  //                     crossAxisSpacing: 8.0,
  //                     mainAxisSpacing: 8.0,
  //                   ),
  //                   itemCount: data.length,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     var document = data[index];
  //                     var name = document['1'];

  //                     return Card(
  //                       child: Column(
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Text(name),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 );








// void main() {
//   String jsonString = '{1:11,2:22,3:33,17:22,25:22}';

//   // Remove '{' and '}' and split the string into key-value pairs
//   List<String> keyValuePairs = jsonString.substring(1, jsonString.length - 1).split(',');

//   // Create a Map with integer keys
//   Map<int, int> intKeyMap = {};

//   // Iterate over key-value pairs and convert keys to integers
//   keyValuePairs.forEach((keyValuePair) {
//     List<String> parts = keyValuePair.split(':');
//     int key = int.parse(parts[0]);
//     int value = int.parse(parts[1]);
//     intKeyMap[key] = value;
//   });

//   // Print the resulting map
//   intKeyMap.forEach((key, value) {
//     print('$key: $value');
//   });
// }













