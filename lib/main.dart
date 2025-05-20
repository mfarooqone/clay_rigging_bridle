import 'dart:io';

import 'package:clay_rigging_bridle/app_bindings.dart';
import 'package:clay_rigging_bridle/common/controllers/preference_controller.dart';
import 'package:clay_rigging_bridle/firebase_options.dart';
import 'package:clay_rigging_bridle/utils/preference_labels.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/theme/app_dark_theme.dart';
import 'utils/theme/app_light_theme.dart';

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

  ThemeMode themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    String? savedTheme = await appPreferencesController.getString(
      key: AppPreferenceLabels.userTheme,
    );
    setState(() {
      themeMode = ThemeMode.values.firstWhere(
        (e) => e.toString() == savedTheme,
        orElse: () => ThemeMode.system,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nobese',
      debugShowCheckedModeBanner: false,
      initialBinding: createBindings(context),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      navigatorObservers: [routeObserver],
      // home: SubscriptionPage(),
      home: Container(),
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
