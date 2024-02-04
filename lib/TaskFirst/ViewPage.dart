import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pratik/TaskFirst/AddNumber.dart';
import 'package:pratik/TaskFirst/ImfoProvider.dart';
import 'package:provider/provider.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final infoprovider = Provider.of<InfoProvider>(context);

    final CollectionReference users =
        FirebaseFirestore.instance.collection(infoprovider.registernumber);

    Future<List<DocumentSnapshot>> getUsers() async {
      QuerySnapshot querySnapshot = await users.get();
      return querySnapshot.docs;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('View page')),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/img3.jpg"), fit: BoxFit.cover)),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.yellow),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    infoprovider.savecontroller.text,
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                height: 100,
                child: FutureBuilder<List<DocumentSnapshot>>(
                  future: getUsers(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    List<DocumentSnapshot> data = snapshot.data!;
                    List<String> dd = [];

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        // crossAxisSpacing: 8.0,
                        // mainAxisSpacing: 8.0,
                        // childAspectRatio: 2,
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var document = data[index];
                        dd = [];
                        Map<String, dynamic> dataMap =
                            document.data() as Map<String, dynamic>;

                        Map<int, int> intKeyMap = {};

                        dataMap.entries.forEach((entry) {
                          try {
                            int key = int.parse(entry.key);

                            // Check if the value is non-empty and contains only digits
                            if (entry.value is int ||
                                (entry.value is String &&
                                    entry.value.isNotEmpty &&
                                    int.tryParse(entry.value) != null)) {
                              int value = entry.value is int
                                  ? entry.value
                                  : int.parse(entry.value.toString());
                              intKeyMap[key] = value;
                            } else {
                              print(
                                  'Invalid value for key $key: ${entry.value}');
                            }
                          } catch (e) {
                            print('Error parsing entry: $entry');
                            print('Error details: $e');
                          }
                        });

                        intKeyMap.forEach((key, value) {
                          dd.add(
                            '$value rs\n\ndate-$key',
                          );
                        });

                        String documentName = document.id;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Text(
                                ' $documentName,', // Add your label here
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 8,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                itemCount: dd.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        dd[index].toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(30, 40, 10, 50)),
                Expanded(
                  flex: 3,
                  child: AddNumber(infoprovider: infoprovider),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      infoprovider.addnum();
                    },
                    icon: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
