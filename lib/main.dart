import 'dart:io';

import 'package:clay_rigging_bridle/app_bindings.dart';
import 'package:clay_rigging_bridle/common/controllers/preference_controller.dart';
import 'package:clay_rigging_bridle/features/splash_screen/test_screen.dart';
import 'package:clay_rigging_bridle/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      )
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferencesController appPreferencesController = Get.put(
    AppPreferencesController(),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nobese',
      debugShowCheckedModeBanner: false,
      initialBinding: createBindings(context),
      navigatorObservers: [routeObserver],
      // home: SubscriptionPage(),
      home: TestScreen(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
    );
  }
}
