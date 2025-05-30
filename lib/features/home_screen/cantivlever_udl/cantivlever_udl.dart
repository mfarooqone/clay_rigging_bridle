import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

class CantivleverUDL extends StatefulWidget {
  const CantivleverUDL({Key? key}) : super(key: key);

  @override
  State<CantivleverUDL> createState() => _CantivleverUDLState();
}

class _CantivleverUDLState extends State<CantivleverUDL> {
  final aController = TextEditingController();
  final bController = TextEditingController();
  final w1Controller = TextEditingController();
  final w2Controller = TextEditingController();
  final totalWeightController = TextEditingController();
  final aTobController = TextEditingController();
  final bToWController = TextEditingController();
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
                    Text("Cantivlever UDL", style: AppTextStyle.titleSmall),
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
                      child: Image.asset(AppAssets.cantivleverUDL),
                    ),

                    /// Exact manual placements
                    Positioned(
                      top: 74,
                      left: 15,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: aController,
                        hintText: 'A',
                        maxLength: 2,
                      ),
                    ),
                    Positioned(
                      top: 74,
                      left: 165,
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
                      top: 180,
                      left: 13,
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
                      top: 180,
                      left: 165,
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
                      top: 262,
                      left: 75,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: aTobController,
                        hintText: 'A to B',
                        maxLength: 2,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 262,
                      left: 244,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: bToWController,
                        hintText: 'B to W',
                        maxLength: 2,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 400,
                      left: 100,
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
                      top: 490,
                      left: 245,
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
