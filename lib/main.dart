import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/utils/blocdelegate.dart';
import 'package:mbunge/utils/firebase.dart';

import 'mbunge.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  // setFirebase
  PushNotification pushNotification = PushNotification();
  pushNotification.initialize();
  pushNotification.subscribeTopic(topic: "notifications");

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}
