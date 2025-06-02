import 'package:clay_rigging_bridle/features/home_screen/breasting_line/breasting_line.dart';
import 'package:clay_rigging_bridle/features/home_screen/bridle_apex/bridle_apex.dart';
import 'package:clay_rigging_bridle/features/home_screen/bridle_leg/bridle_leg.dart';
import 'package:clay_rigging_bridle/features/home_screen/cantivlever/cantivlever.dart';
import 'package:clay_rigging_bridle/features/home_screen/cantivlever_udl/cantivlever_udl.dart';
import 'package:clay_rigging_bridle/features/home_screen/complex_udl/complex_udl.dart';
import 'package:clay_rigging_bridle/features/home_screen/information/information.dart';
import 'package:clay_rigging_bridle/features/home_screen/udl/udl.dart';
import 'package:clay_rigging_bridle/features/home_screen/unit_converter/unit_converter.dart';
import 'package:clay_rigging_bridle/features/home_screen/weight_shifting/weight_shifting.dart';
import 'package:clay_rigging_bridle/utils/app_labels.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/utils/show_snackbar.dart';
import 'package:clay_rigging_bridle/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController(), permanent: true);

  @override
  void initState() {
    super.initState();
    controller.selectedIndex.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.05),
              Text(AppLabels.appName, style: AppTextStyle.headlineMedium),
              SizedBox(height: size.height * 0.01),
              Text(
                'Welcome to the ultimate tool for calculating rigging bridle load distributions with precision and confidence',
                style: AppTextStyle.bodyMedium,
              ),
              SizedBox(height: size.height * 0.05),

              Text('Calculator', style: AppTextStyle.bodyMedium),
              SizedBox(height: size.height * 0.01),

              /// Wrap in Obx so that the dropdown rebuilds when selectedIndex changes
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: controller.screensList[controller.selectedIndex.value],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  items:
                      controller.screensList.map((name) {
                        return DropdownMenuItem<String>(
                          value: name,
                          child: Text(name, style: AppTextStyle.bodyMedium),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue == null) return;
                    final index = controller.screensList.indexOf(newValue);
                    controller.selectedIndex.value = index;
                  },
                );
              }),

              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: PrimaryButton(
                  title: "Next",
                  onPressed: () {
                    navigateToScreen(index: controller.selectedIndex.value);
                  },
                ),
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToScreen({required int index}) {
    switch (index) {
      case 0:
        Get.to(() => const InformationScreen());
        break;
      case 1:
        Get.to(() => const BridleLeg());
        break;
      case 2:
        Get.to(() => const BridleApex());
        break;
      case 3:
        Get.to(() => const WeightShifting());
        break;
      case 4:
        Get.to(() => const UDL());
        break;
      case 5:
        Get.to(() => const ComplexUDL());
        break;
      case 6:
        Get.to(() => const Cantivlever());
        break;
      case 7:
        Get.to(() => const CantivleverUDL());
        break;
      case 8:
        Get.to(() => const BreastingLine());
        break;
      case 9:
        Get.to(() => const UnitConverter());
        break;
      default:
        showErrorMessage("Invalid screen selected");
    }
  }
}
