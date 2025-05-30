import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

class BreastingLine extends StatefulWidget {
  const BreastingLine({Key? key}) : super(key: key);

  @override
  State<BreastingLine> createState() => _BreastingLineState();
}

class _BreastingLineState extends State<BreastingLine> {
  // ── Controllers ──
  final aToXController = TextEditingController();
  final phToBlController = TextEditingController();
  final weightController = TextEditingController();
  final horizontalForceController = TextEditingController();

  // ── UI state ──
  bool isCalculateEnabled = false;

  @override
  void initState() {
    super.initState();
    // Re-evaluate Calculate whenever any input changes
    for (final c in [aToXController, phToBlController, weightController]) {
      c.addListener(_updateCalculateState);
    }
  }

  @override
  void dispose() {
    for (final c in [
      aToXController,
      phToBlController,
      weightController,
      horizontalForceController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  /// Enable the button only when all three inputs are non-empty.
  void _updateCalculateState() {
    final ready =
        aToXController.text.isNotEmpty &&
        phToBlController.text.isNotEmpty &&
        weightController.text.isNotEmpty;
    setState(() => isCalculateEnabled = ready);
  }

  void _onCalculate() {
    final x = double.tryParse(aToXController.text) ?? 0.0; // A→X
    final p = double.tryParse(phToBlController.text) ?? 1.0; // PH→BL
    final W = double.tryParse(weightController.text) ?? 0.0; // weight

    // Correct formula:
    final FH = (p > 0) ? W * x / p : 0.0;

    horizontalForceController.text = FH.toStringAsFixed(1);
  }

  /// Clear everything and disable the button again.
  void _onReset() {
    FocusScope.of(context).unfocus();
    for (final c in [
      aToXController,
      phToBlController,
      weightController,
      horizontalForceController,
    ]) {
      c.clear();
    }
    setState(() => isCalculateEnabled = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    Text("Breasting Line", style: AppTextStyle.titleSmall),
                    Spacer(),
                    ArrowBackButton(color: Colors.transparent),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            Center(
              child: Container(
                width: 360,
                height: 600,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(AppAssets.breastingLine),
                    ),

                    // A → X
                    Positioned(
                      top: 98,
                      left: 125,
                      child: PrimaryTextField(
                        width: 41,
                        height: 20,
                        controller: aToXController,
                      ),
                    ),

                    // PH → BL
                    Positioned(
                      top: 275,
                      left: 16,
                      child: PrimaryTextField(
                        width: 60,
                        height: 20,
                        controller: phToBlController,
                      ),
                    ),

                    // Horizontal force (output)
                    Positioned(
                      top: 322,
                      left: 299,
                      child: PrimaryTextField(
                        width: 50,
                        height: 20,
                        controller: horizontalForceController,

                        enable: false,
                      ),
                    ),

                    // W (weight)
                    Positioned(
                      top: 461,
                      left: 209,
                      child: PrimaryTextField(
                        width: 70,
                        height: 20,
                        controller: weightController,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            PrimaryButton(
              title: "Calculate",
              enabled: isCalculateEnabled,
              onPressed: isCalculateEnabled ? _onCalculate : () {},
            ),

            const SizedBox(height: 10),
            PrimaryButton(
              title: "Reset",
              backgroundColor: Colors.red,
              onPressed: _onReset,
            ),
          ],
        ),
      ),
    );
  }
}
