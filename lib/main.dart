import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbunge/repository/share_preferences.dart';
import 'package:mbunge/utils/blocdelegate.dart';
import 'package:mbunge/utils/firebase.dart';

import 'blocs/authentication/authentication_bloc.dart';
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
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            var myBloc = AuthenticationBloc(
              SharePreferenceRepo(),
            );
            myBloc.add(
              AppStarted(),
            );
            return myBloc;
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}
