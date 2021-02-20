import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/cubit/authentication/authentication_bloc.dart';
import 'package:mbunge/cubit/delegate.dart';
import 'package:mbunge/repository/share_preferences.dart';
import 'package:mbunge/util/agora.dart';
import 'package:mbunge/util/fcm.dart';
import 'package:mbunge/util/mqtt.dart';
import 'package:mbunge/util/routes.dart';

import 'widgets/restart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  // setFirebase
  PushNotification pushNotification = PushNotification();
  pushNotification.initialize();
  pushNotification.subscribeTopic(topic: "/topics/notifications");

  // // Mqtt
  // MQTTclient mqttClient = MQTTclient();
  // await mqttClient.initConnection();
  // mqttClient.subscribeTopic("6024916d82ca2106514d0d67");

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      // statusBarBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // runApp(MyApp());
  runApp(
    MultiBlocProvider(
      providers: [
        // Auth
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            var myBloc = AuthenticationBloc(SharePreferenceRepo());
            myBloc.add(AppStarted());
            return myBloc;
          },
        ),
      ],
      child: RestartWidget(child: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // AgoraClient _agoraClient = AgoraClient();

  @override
  void initState() {
    // _agoraClient.initialize();
    super.initState();
  }

  @override
  void dispose() {
    // _agoraClient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mbunge App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: "Source Sans Pro",
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0.0,
          color: Colors.white,
          textTheme: Theme.of(context).primaryTextTheme.copyWith(
                headline6: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black,
                    ),
              ),
          brightness: Brightness.dark,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MainScreen(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
