import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoProvider with ChangeNotifier {
  final TextEditingController numbercontroller = TextEditingController();
  final TextEditingController savecontroller = TextEditingController();
  final TextEditingController mobilecontroller = TextEditingController();
  final TextEditingController registermobilecontroller =
      TextEditingController();
  final TextEditingController namecontroller = TextEditingController();

  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('number').snapshots();
  String val = "0";
  String result = "0";
  String numberErrorText = '';
  String registernumber = '';
  String registerError = '-';
  bool showTextField = true;
  bool showText = true;
  bool login = false;
  bool addDocument = true;
  DateTime now = DateTime.now();
  List<Widget> dateWidgets = [];
  // List<String> inputValue = [];

  InfoProvider() {
    redText();
    print('--------redtest info------$result----------');
    redlogin();
    showDate();
    notifyListeners();
  }

  void showDate() {
    int year = now.year;
    for (int month = 1; month <= 12; month++) {
      for (int day = 1; day <= 31; day++) {
        try {
          DateTime date = DateTime(year, month, day);
          String formattedDate = DateFormat('dd-MM-yyyy').format(date);

          dateWidgets.add(
            Text(formattedDate),
          );
        } catch (e) {}
      }
    }

    notifyListeners();
  }

  void addnum() {
    checkDocumentExistence(documentName());

    notifyListeners();
  }

  void changetrue() {
    showTextField = true;
    notifyListeners();
  }

  void changefalse() {
    showTextField = false;
    notifyListeners();
  }

  void validateMobileNumber(String input) {
    if (input.length != 10) {
      numberErrorText = 'Number must be  1o characters';
    } else {
      numberErrorText = '';
      numberExist(input);
    }
    notifyListeners();
  }

  void addNumber() {
    int sr1 = int.parse(result);
    int sr2 = int.parse(val);
    int s = sr1 + sr2;
    saveText(s);
    print('-----------save text------$s----------');
    redText();
    print('--------redtest add num------$result----------');

    print(s);
    notifyListeners();
  }

  void saveText(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('ans', value);
    notifyListeners();
  }

  void redText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedValue = prefs.getInt('ans');
    if (savedValue != null) {
      result = savedValue.toString();
      savecontroller.text = savedValue.toString();
    }
    notifyListeners();
  }

  void saveLoginInfo(int valu, bool login) {
    savelogin(valu, login);
    redlogin();

    notifyListeners();
  }

  void savelogin(int valu, bool login) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('value', valu);
    prefs.setBool('login', login);
    notifyListeners();
  }

  void redlogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedValue = prefs.getInt('value');
    bool? savedlogin = prefs.getBool('login');
    if (savedValue != null) {
      registernumber = savedValue.toString();
    }
    if (savedlogin != null) {
      login = savedlogin;
    }
    notifyListeners();
  }

  Future<void> checkDocumentExistence(String Monthformat) async {
    CollectionReference numberCollection =
        FirebaseFirestore.instance.collection(registernumber);

    DocumentSnapshot documentSnapshot =
        await numberCollection.doc(Monthformat).get();

    if (documentSnapshot.exists) {
      FirebaseFirestore.instance
          .collection(registernumber)
          .doc(documentName())
          .update({
        formatToday(): numbercontroller.text,
      });

      numbercontroller.text = '';
      numberErrorText = '';
      addNumber();
    } else {
      FirebaseFirestore.instance
          .collection(registernumber)
          .doc(documentName())
          .set({
        formatToday(): numbercontroller.text,
      });
      numbercontroller.text = '';
      numberErrorText = '';
      addNumber();
    }
    notifyListeners();
  }

  void registerNumberOnFirebase() {
    FirebaseFirestore.instance
        .collection(registermobilecontroller.text)
        .doc(registermobilecontroller.text)
        .set({'name': namecontroller.text});
    notifyListeners();
  }

  Future<void> numberExist(String value2) async {
    CollectionReference numberCollection =
        FirebaseFirestore.instance.collection(value2);

    QuerySnapshot documentSnapshot = await numberCollection.get();

    if (documentSnapshot.docs.isNotEmpty) {
      registerError = '';
    } else {
      registerError = 'number is not register';
    }

    notifyListeners();
  }

  String formatToday() {
    String str = "${DateTime.now().day}";

    return str;
  }

  String documentName() {
    String Mon = "${DateTime.now().month}-${DateTime.now().year}";
    return Mon;
  }
}

// String formatToday() {
//   String str = "${DateTime.now().day}-${DateTime.now().month}";
//   return str;
// }