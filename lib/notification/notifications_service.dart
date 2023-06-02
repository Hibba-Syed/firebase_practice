import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_practice/screens/Product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // this function is use for get permission from user for Notifications
   void requestNotificationPermission() async{
    NotificationSettings settings = await messaging.requestPermission(
      badge: true,
      carPlay: true,
      alert: true,
      announcement: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    // this line use for android
    if(settings.authorizationStatus == AuthorizationStatus.authorized ){
      print("user allow permissions");
    }
    // this line use for ios
    else if (settings.authorizationStatus== AuthorizationStatus.provisional){
      print("user allow permissions");
    }
    else{
   AppSettings.openNotificationSettings();
    }

  }
  // this function is use for get notifications
  void initLocalNotifications(BuildContext context,RemoteMessage message)async{
     var androidInitialization = const AndroidInitializationSettings("@mipmap/ic_launcher");
     var isoInitialization = const DarwinInitializationSettings();
     var initializationSetting = InitializationSettings(
       android: androidInitialization,
       iOS: isoInitialization,
     );
     
     await _flutterLocalNotificationsPlugin.initialize(
       initializationSetting,
     onDidReceiveNotificationResponse: (payload){
         handleMessage(context, message);

     }
   );
  }
  // this function is use for
  void firebaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message) {
    if(kDebugMode){
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
      print(message.data.toString());
      print(message.data['type']);
    }
    if(Platform.isAndroid){
      initLocalNotifications(context, message);
      showNotification(message);
    }
else{
      showNotification(message);
    }
    });
  }
  Future<void> showNotification(RemoteMessage message)async{
     AndroidNotificationChannel channel = AndroidNotificationChannel(
         Random.secure().nextInt(100000).toString(),
         "High Importance Notification",
       importance: Importance.max,
     );
     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
         channel.id.toString(),
         channel.name.toString(),
         channelDescription: 'Your channel description',
       importance: Importance.high,
       priority: Priority.high,
       ticker: 'ticker'

     );
     DarwinNotificationDetails darwinNotificationDetails = const DarwinNotificationDetails(
     presentAlert: true,
       presentBadge: true,
       presentSound: true
     );
     NotificationDetails notificationDetails = NotificationDetails(
       android: androidNotificationDetails,
       iOS: darwinNotificationDetails
     );
     Future.delayed(Duration.zero,(){
       _flutterLocalNotificationsPlugin.show(
           0,
           message.notification!.title.toString(),
           message.notification!.body.toString(),
           notificationDetails
       );
     });
  }
  // this function is use for device token
// Future<String> getDeviceToken() async{
//      String? token = await messaging.getToken();
//      return token!;

//}
  // this function is use for refresh device token
void getTokenRefresh(){
     messaging.onTokenRefresh.listen((event) {
       event.toString();
       print("Refresh");
     });
}// when app is terminated
Future<void> setupInteractMessage(BuildContext context ) async{
     RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
     if(initialMessage != null){
       handleMessage(context, initialMessage);
     }
  // when app is in background
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
  handleMessage(context, event);
  });
}
void handleMessage(BuildContext context, RemoteMessage message){
if(message.data['type']== message){
  Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductScreen()));
  //id: message.data['id'],
}
}

}
