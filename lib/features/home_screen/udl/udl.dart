import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

class UDL extends StatefulWidget {
  const UDL({Key? key}) : super(key: key);

  @override
  State<UDL> createState() => _UDLState();
}

class _UDLState extends State<UDL> {
  final aController = TextEditingController();
  final bController = TextEditingController();
  final w1Controller = TextEditingController();
  final w2Controller = TextEditingController();
  final beamController = TextEditingController();
  final totalWeightController = TextEditingController();
  final pointAController = TextEditingController();
  final pointBController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard on tap
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Prevent image from shifting
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    ArrowBackButton(),
                    Spacer(),
                    Text("UDL", style: AppTextStyle.titleSmall),
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
                    Positioned.fill(child: Image.asset(AppAssets.udl)),

                    /// Exact manual placements
                    Positioned(
                      top: 62,
                      left: 38,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: aController,
                      ),
                    ),
                    Positioned(
                      top: 62,
                      left: 250,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: bController,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 178,
                      left: 38,
                      child: PrimaryTextField(
                        width: 70,
                        height: 20,
                        controller: w1Controller,

                        enable: false,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 178,
                      left: 254,
                      child: PrimaryTextField(
                        width: 70,
                        height: 20,
                        controller: w2Controller,

                        enable: false,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 222,
                      left: 144,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: beamController,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 422,
                      left: 144,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: totalWeightController,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 488,
                      left: 55,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: pointAController,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 488,
                      left: 235,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: pointBController,
                      ),
                    ),

                    ///
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
