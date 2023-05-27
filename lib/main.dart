import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


