import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'mbunge.dart';

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
void setFirebase() {
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('icon_notif');

  var initializationSettingsIOS = IOSInitializationSettings();

  var initializationSettings = InitializationSettings(
    initializationSettingsAndroid,
    initializationSettingsIOS,
  );

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: onSelect,
  );

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _firebaseMessaging.configure(
    onBackgroundMessage: myBackgroundMessageHandler,
    onMessage: (message) async {
      print("onMessage: $message");
      return myBackgroundMessageHandler(message);
    },
    onLaunch: (message) async {
      print("onLaunch: $message");
      return myBackgroundMessageHandler(message);
    },
    onResume: (message) async {
      print("onResume: $message");
      return myBackgroundMessageHandler(message);
    },
  );

  _firebaseMessaging.getToken().then((String token) {
    print("Push Messaging token: $token");
    // Push messaging to this token later
  });
}

Future<String> onSelect(String data) async {
  print("onSelectNotification $data");
}

//updated myBackgroundMessageHandler
Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("myBackgroundMessageHandler message: $message");
  int msgId = int.tryParse(message["data"]["msgId"].toString()) ?? 0;
  print("msgId $msgId");
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel description',
    groupKey: 'ninja.iampato.mbunge',
    enableVibration: true,
    color: Colors.red.shade300,
    importance: Importance.Max,
    priority: Priority.High,
    ticker: 'ticker',
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    androidPlatformChannelSpecifics,
    iOSPlatformChannelSpecifics,
  );
  flutterLocalNotificationsPlugin.show(
    msgId,
    message["notification"]["title"],
    message["notification"]["body"],
    platformChannelSpecifics,
    payload: message["data"]["data"],
  );
  return Future<void>.value();
}

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //setFirebase();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}
