import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math' as math;

var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

class PushNotification {
  static final PushNotification _pushNotification =
      PushNotification._internal();

  factory PushNotification() {
    return _pushNotification;
  }

  PushNotification._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void initialize() {
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

    _firebaseMessaging.configure(
      // onBackgroundMessage: messageHandler,
      onMessage: (message) async {
        print("onMessage: $message");
        return messageHandler(message);
      },
      onLaunch: (message) async {
        print("onLaunch: $message");
        // return messageHandler(message);
      },
      onResume: (message) async {
        print("onResume: $message");
        // return messageHandler(message);
      },
    );

    _firebaseMessaging.getToken().then((String token) {
      print("Push Messaging token: $token");
    });
  }

  Future requestPermissions() async {
    await _firebaseMessaging
        .requestNotificationPermissions(IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));
  }

  void subscribeTopic({@required String topic}) {
    _firebaseMessaging.subscribeToTopic(topic).then((value) {
      print("successfully subscribe to topic: $topic");
    });
  }

  void unSubscribeTopic({@required String topic}) {
    _firebaseMessaging.unsubscribeFromTopic(topic).then((value) {
      print("successfully un subscribe to topic: $topic");
    });
  }

  /// onSelect
  /// handles what happens when you tap on the
  /// push notification
  Future<String> onSelect(String data) async {
    print("onSelectNotification $data");
    return Future.value("");
  }

  /// messageHandler
  /// handles the fcm messages
  static Future<dynamic> messageHandler(Map<String, dynamic> message) async {
    print("myBackgroundMessageHandler message: $message");
    int msgId = generateRandomId();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      groupKey: 'mbungeapp.tech',
      enableVibration: true,
      color: Colors.orange,
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'Mbunge app push notification',
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics,
    );
    flutterLocalNotificationsPlugin.show(
      msgId,
      message["data"]["notification"]["title"],
      message["data"]["notification"]["body"],
      platformChannelSpecifics,
      payload: message["data"]["data"],
    );
  }

  static int generateRandomId() {
    math.Random random = math.Random();
    return random.nextInt(100);
  }
}
