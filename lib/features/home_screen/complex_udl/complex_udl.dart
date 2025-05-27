import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

class ComplexUDL extends StatefulWidget {
  const ComplexUDL({Key? key}) : super(key: key);

  @override
  State<ComplexUDL> createState() => _ComplexUDLState();
}

class _ComplexUDLState extends State<ComplexUDL> {
  final aController = TextEditingController();
  final bController = TextEditingController();
  final w1Controller = TextEditingController();
  final w2Controller = TextEditingController();
  final beamController = TextEditingController();
  final totalWeightController = TextEditingController();
  final bToCGController = TextEditingController();
  final aToCGController = TextEditingController();

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
                    Text(
                      "Breasting Line Calculator",
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
                    Positioned.fill(child: Image.asset(AppAssets.complexUDL)),

                    /// Exact manual placements
                    Positioned(
                      top: 68,
                      left: 38,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: aController,
                        hintText: 'A',
                        maxLength: 2,
                      ),
                    ),
                    Positioned(
                      top: 68,
                      left: 250,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: bController,
                        hintText: 'B',
                        maxLength: 2,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 182,
                      left: 38,
                      child: PrimaryTextField(
                        width: 70,
                        height: 20,
                        controller: w1Controller,
                        hintText: 'W1',
                        maxLength: 2,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 182,
                      left: 254,
                      child: PrimaryTextField(
                        width: 70,
                        height: 20,
                        controller: w2Controller,
                        hintText: 'W2',
                        maxLength: 2,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 228,
                      left: 144,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: beamController,
                        hintText: 'Beam',
                        maxLength: 2,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 419,
                      left: 54,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: aToCGController,
                        hintText: 'A to CG',
                        maxLength: 2,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 305,
                      left: 164,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: bToCGController,
                        hintText: 'B to CG',
                        maxLength: 2,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 523,
                      left: 225,
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
      ),
    );
  }
}
