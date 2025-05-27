import 'package:clay_rigging_bridle/features/home_screen/breasting_line/breasting_line.dart';
import 'package:clay_rigging_bridle/features/home_screen/bridle_apex/bridle_apex.dart';
import 'package:clay_rigging_bridle/features/home_screen/bridle_leg/bridle_leg.dart';
import 'package:clay_rigging_bridle/features/home_screen/cantivlever/cantivlever.dart';
import 'package:clay_rigging_bridle/features/home_screen/complex_udl/complex_udl.dart';
import 'package:clay_rigging_bridle/features/home_screen/udl/udl.dart';
import 'package:clay_rigging_bridle/features/home_screen/weight_shifting/weight_shifting.dart';
import 'package:clay_rigging_bridle/utils/app_colors.dart';
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
  ///
  ///
  ///
  final controller = Get.put(HomeController());

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Container(
          height: height,
          width: width,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: height * 0.05),

                  ///
                  ///
                  ///
                  Text(
                    'Rigging Bridle Calculator',
                    style: AppTextStyle.headlineSmall,
                  ),

                  ///
                  ///
                  ///
                  SizedBox(
                    width: 312,
                    child: Text(
                      'Welcome to the ultimate tool for calculating rigging bridle load distributions with precision and confidence',
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: const Color(0xFF4A4F4E),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  ///
                  ///
                  SizedBox(height: height * 0.05),
                  Text('Calculator', style: AppTextStyle.titleMedium),

                  ///
                  ///
                  ///
                  ///
                  DropdownButton<String>(
                    hint: Text(
                      "Select Calculator",
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: AppColors.greyColor, // Hint text color
                      ),
                    ),
                    value: controller.selectedScreen.value,
                    isExpanded: true,
                    items:
                        controller.screensList.map((String type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(
                              type,
                              style: TextStyle(
                                color:
                                    type == "Select Calculator"
                                        ? AppColors.greyColor
                                        : Colors
                                            .black, // Apply grey color to the hint
                              ),
                            ),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        controller.isLoading.value = true;
                        controller.selectedScreen(newValue);
                        controller.isLoading.value = false;
                      }
                    },
                    underline: Container(
                      height: 1,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: PrimaryButton(
                      onPressed: () {
                        if (controller.selectedScreen.value ==
                            "Select Calculator") {
                          showErrorMessage("Please select a calculator");
                        } else {
                          // Get.to(() => BreastingLine());
                          navigateToScreen(
                            selectedScreen: controller.selectedScreen.value,
                          );
                        }
                      },
                      title: "Next",
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void navigateToScreen({required String selectedScreen}) {
    switch (selectedScreen) {
      case 'Bridle Leg Length':
        Get.to(() => BridleLeg());
        break;
      case 'Bridle Apex and Point Position':
        Get.to(() => BridleApex());
        break;
      case 'Weight Shifting':
        Get.to(() => WeightShifting());
        break;
      case 'UDL':
        Get.to(() => UDL());
        break;
      case 'Complex UDL':
        Get.to(() => ComplexUDL());
        break;
      case 'Cantivlever':
        Get.to(() => Cantivlever());
        break;
      case 'Breasting Line':
        Get.to(() => BreastingLine());
        break;
      case 'Calculator':
        break;
      default:
        showErrorMessage("Invalid screen selected");
    }
  }
}
