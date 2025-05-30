import 'package:clay_rigging_bridle/features/home_screen/breasting_line/breasting_line.dart';
import 'package:clay_rigging_bridle/features/home_screen/bridle_apex/bridle_apex.dart';
import 'package:clay_rigging_bridle/features/home_screen/bridle_leg/bridle_leg.dart';
import 'package:clay_rigging_bridle/features/home_screen/cantivlever_udl/cantivlever_udl.dart';
import 'package:clay_rigging_bridle/features/home_screen/complex_udl/complex_udl.dart';
import 'package:clay_rigging_bridle/features/home_screen/information/information.dart';
import 'package:clay_rigging_bridle/features/home_screen/udl/udl.dart';
import 'package:clay_rigging_bridle/features/home_screen/unit_converter/unit_converter.dart';
import 'package:clay_rigging_bridle/features/home_screen/weight_shifting/weight_shifting.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/utils/show_snackbar.dart';
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
  final controller = Get.put(HomeController(), permanent: true);

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
                    'Entertainment Rigging Calculator+',
                    style: AppTextStyle.headlineSmall,
                  ),

                  ///
                  ///
                  ///
                  ///
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,

                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: controller.screensList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                          ),
                      itemBuilder: (context, index) {
                        final item = controller.screensList[index];

                        return GestureDetector(
                          onTap: () {
                            navigateToScreen(index: index);
                          },
                          child: Container(
                            width: 122,
                            height: 122,
                            child: Image.asset(item, fit: BoxFit.contain),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void navigateToScreen({required int index}) {
    switch (index) {
      case 0:
        Get.to(() => InformationScreen());
      case 1:
        Get.to(() => BridleLeg());
        break;
      case 2:
        Get.to(() => BridleApex());
        break;
      case 3:
        Get.to(() => WeightShifting());
        break;
      case 4:
        Get.to(() => UDL());
        break;
      case 5:
        Get.to(() => ComplexUDL());
        break;
      case 6:
        Get.to(() => CantivleverUDL());
        break;
      case 7:
        Get.to(() => BreastingLine());
        break;
      case 8:
        Get.to(() => UnitConverter());
        break;
      default:
        showErrorMessage("Invalid screen selected");
    }
  }
}
