import 'package:clay_rigging_bridle/features/home_screen/home_controller.dart';
import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BridleLeg extends StatefulWidget {
  const BridleLeg({Key? key}) : super(key: key);

  @override
  State<BridleLeg> createState() => _BridleLegState();
}

class _BridleLegState extends State<BridleLeg> {
  final HomeController controller = Get.find();

  final atoBController = TextEditingController();
  final atoXController = TextEditingController();
  final btoXController = TextEditingController();
  final iController = TextEditingController();
  final l1Controller = TextEditingController();
  final l2Controller = TextEditingController();

  final totalWeightController = TextEditingController();
  final wllController = TextEditingController();
  final apexHeightController = TextEditingController();
  final aHeightController = TextEditingController();
  final bHeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard on tap
      },
      child: Obx(() {
        return Scaffold(
          resizeToAvoidBottomInset: false, // Prevent image from shifting
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          ArrowBackButton(),
                          Spacer(),
                          Text(
                            "Bridle Leg Length",
                            style: AppTextStyle.titleSmall,
                          ),
                          Spacer(),
                          ArrowBackButton(color: Colors.transparent),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// Fixed-size layout
                  Center(
                    child: Container(
                      width: 360, // Fixed width
                      height: 600, // Fixed height for consistent layout
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(AppAssets.bridleLeg),
                          ),

                          /// Exact manual placements
                          Positioned(
                            top: 50,
                            left: 138,
                            child: PrimaryTextField(
                              width: 90,
                              height: 25,
                              controller: atoBController,
                              hintText: 'A to B',
                              onChanged: (value) {
                                controller.isLoading.value = true;
                                String val =
                                    (int.parse(atoBController.text) / 2)
                                        .toString();
                                atoXController.text = val;
                                btoXController.text = val;
                                controller.isLoading.value = false;
                              },
                            ),
                          ),

                          ///
                          Positioned(
                            top: 120,
                            left: 58,
                            child: PrimaryTextField(
                              width: 50,
                              height: 25,
                              controller: atoXController,
                              hintText: 'A to X',
                              maxLength: 2,
                            ),
                          ),
                          Positioned(
                            top: 120,
                            left: 262,
                            child: PrimaryTextField(
                              width: 50,
                              height: 25,
                              controller: btoXController,
                              hintText: 'B to X',
                              maxLength: 2,
                            ),
                          ),

                          ///
                          Positioned(
                            top: 155,
                            left: 158,
                            child: PrimaryTextField(
                              width: 50,
                              height: 20,
                              controller: iController,
                              hintText: 'I',
                              maxLength: 2,
                            ),
                          ),

                          ///
                          Positioned(
                            top: 205,
                            left: 88,
                            child: PrimaryTextField(
                              width: 50,
                              height: 20,
                              controller: l1Controller,
                              hintText: 'L1',
                              maxLength: 2,
                            ),
                          ),

                          ///
                          Positioned(
                            top: 205,
                            left: 233,
                            child: PrimaryTextField(
                              width: 50,
                              height: 20,
                              controller: l2Controller,
                              hintText: 'L2',
                              maxLength: 2,
                            ),
                          ),

                          ///
                          Positioned(
                            top: 285,
                            left: 28,
                            child: PrimaryTextField(
                              width: 80,
                              height: 25,
                              controller: aHeightController,
                              hintText: 'A Height',
                              maxLength: 2,
                            ),
                          ),

                          ///
                          Positioned(
                            top: 285,
                            left: 252,
                            child: PrimaryTextField(
                              width: 80,
                              height: 25,
                              controller: bHeightController,
                              hintText: 'B Height',
                              maxLength: 2,
                            ),
                          ),

                          ///
                          Positioned(
                            top: 420,
                            left: 55,
                            child: PrimaryTextField(
                              width: 70,
                              height: 25,
                              controller: wllController,
                              hintText: 'WLL',
                              maxLength: 2,
                            ),
                          ),

                          ///
                          Positioned(
                            top: 420,
                            left: 245,
                            child: PrimaryTextField(
                              width: 70,
                              height: 25,
                              controller: apexHeightController,
                              hintText: 'Height',
                              maxLength: 2,
                            ),
                          ),

                          ///
                          Positioned(
                            top: 454,
                            left: 144,
                            child: PrimaryTextField(
                              width: 70,
                              height: 25,
                              controller: totalWeightController,
                              hintText: 'Total Weight',
                              maxLength: 2,
                            ),
                          ),

                          ///
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (controller.isLoading.value) const SizedBox(),
            ],
          ),
        );
      }),
    );
  }
}
