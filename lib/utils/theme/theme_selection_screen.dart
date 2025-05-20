import 'package:clay_rigging_bridle/common/controllers/preference_controller.dart';
import 'package:clay_rigging_bridle/utils/preference_labels.dart';
import 'package:clay_rigging_bridle/utils/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSelectionScreen extends StatefulWidget {
  const ThemeSelectionScreen({super.key, this.onThemeChangePressed});
  final VoidCallback? onThemeChangePressed;
  @override
  State<ThemeSelectionScreen> createState() => _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends State<ThemeSelectionScreen> {
  final themeController = Get.put(ThemeController());
  final AppPreferencesController appPreferencesController = Get.put(
    AppPreferencesController(),
  );

  String? savedTheme;

  Future<void> getData() async {
    String theme = await appPreferencesController.getString(
      key: AppPreferenceLabels.userTheme,
    );
    setState(() {
      savedTheme = theme;
      if (savedTheme != null) {
        themeController.selectedTheme.value = ThemeMode.values.firstWhere(
          (e) => e.toString() == savedTheme,
          orElse: () => ThemeMode.system,
        );
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: appTheme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Theme Selection')),
      body: Obx(() {
        final selectedTheme = themeController.selectedTheme.value;
        return Column(
          children: [
            ListTile(
              title: const Text('Light Theme'),
              onTap: () {
                themeController.setTheme(ThemeMode.light);
              },
              trailing:
                  selectedTheme == ThemeMode.light
                      ? Icon(Icons.check, color: appTheme.iconTheme.color)
                      : null,
            ),
            ListTile(
              title: const Text('Dark Theme'),
              onTap: () {
                themeController.setTheme(ThemeMode.dark);
              },
              trailing:
                  selectedTheme == ThemeMode.dark
                      ? Icon(Icons.check, color: appTheme.iconTheme.color)
                      : null,
            ),
            ListTile(
              title: const Text('System Theme'),
              onTap: () {
                themeController.setTheme(ThemeMode.system);
              },
              trailing:
                  selectedTheme == ThemeMode.system
                      ? Icon(Icons.check, color: appTheme.iconTheme.color)
                      : null,
            ),
          ],
        );
      }),
    );
  }
}
