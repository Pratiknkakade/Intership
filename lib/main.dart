import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pratik/TaskFirst/ImfoProvider.dart';
import 'package:pratik/TaskFirst/LoginPage.dart';
import 'package:pratik/TaskFirst/ViewPage.dart';
import 'package:pratik/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => InfoProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final infoprovider = Provider.of<InfoProvider>(context);

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        hintColor: Colors.orange,
        appBarTheme: const AppBarTheme(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
        hintColor: Colors.amber,
        appBarTheme: const AppBarTheme(),
      ),

      home: infoprovider.login ? ViewPage() : LoginPage(),
      // home: ViewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
