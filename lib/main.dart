import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_practice/provider/cart_provider.dart';
import 'package:firebase_practice/screens/api_get_screen.dart';
import 'package:firebase_practice/screens/api_post_screen.dart';
import 'package:firebase_practice/screens/home_screen.dart';
import 'package:firebase_practice/screens/uplode_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api_services/api_work.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessageingBackgroundHandler);
  
  runApp(const MyApp());
}
@pragma('vm:entry-point')
Future<void> _firebaseMessageingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_)=>CartProvider(),
      child: Builder(builder: (BuildContext context){
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home:  MianPageApi(),
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}


