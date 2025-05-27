import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

class BreastingLine extends StatefulWidget {
  const BreastingLine({Key? key}) : super(key: key);

  @override
  State<BreastingLine> createState() => _BreastingLineState();
}

class _BreastingLineState extends State<BreastingLine> {
  final _aToBController = TextEditingController();
  final _aToXController = TextEditingController();
  final _phToBlController = TextEditingController();
  final _l1Controller = TextEditingController();
  final _horizontalForceController = TextEditingController();
  final _weightController = TextEditingController();

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
                    Positioned.fill(
                      child: Image.asset(AppAssets.breastingLine),
                    ),

                    /// Exact manual placements
                    Positioned(
                      top: 34,
                      left: 127,
                      child: PrimaryTextField(
                        width: 80,
                        height: 20,
                        controller: _aToBController,
                        hintText: 'A to B',
                        maxLength: 2,
                      ),
                    ),

                    Positioned(
                      top: 98,
                      left: 125,
                      child: PrimaryTextField(
                        width: 46,
                        height: 20,
                        controller: _aToXController,
                        hintText: 'A to X',
                        maxLength: 2,
                      ),
                    ),

                    ///
                    Positioned(
                      top: 179,
                      left: 150,
                      child: PrimaryTextField(
                        width: 50,
                        height: 20,
                        controller: _l1Controller,
                        hintText: 'L1',
                        maxLength: 2,
                      ),
                    ),

                    ///
                    ///
                    ///
                    Positioned(
                      top: 278,
                      left: 16,
                      child: PrimaryTextField(
                        width: 60,
                        height: 20,
                        controller: _phToBlController,
                        hintText: 'PH to BL',
                        maxLength: 2,
                      ),
                    ),

                    ///
                    ///
                    ///
                    Positioned(
                      top: 322,
                      left: 299,
                      child: PrimaryTextField(
                        width: 50,
                        height: 20,
                        controller: _horizontalForceController,
                        hintText: 'Horizontal Force',
                        maxLength: 2,
                      ),
                    ),
                    Positioned(
                      top: 461,
                      left: 209,
                      child: PrimaryTextField(
                        width: 70,
                        height: 20,
                        controller: _weightController,
                        hintText: 'Weight',
                        maxLength: 2,
                      ),
                    ),
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
