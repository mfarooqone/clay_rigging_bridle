import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

class CantivleverUDL extends StatefulWidget {
  const CantivleverUDL({Key? key}) : super(key: key);

  @override
  State<CantivleverUDL> createState() => _CantivleverUDLState();
}

class _CantivleverUDLState extends State<CantivleverUDL> {
  // ── Controllers ──
  final aController = TextEditingController(); // top‐row A WLL
  final bController = TextEditingController(); // top‐row B WLL
  final w1Controller = TextEditingController(); // bottom‐row W1
  final w2Controller = TextEditingController(); // bottom‐row W2
  final aToBController = TextEditingController(); // span A→B
  final bToCGController = TextEditingController(); // dist B→CG
  final aToCGController = TextEditingController(); // dist A→CG (read‐only)
  final totalWeightController = TextEditingController(); // total UDL weight

  // ── UI state ──
  bool _syncingPoints = false;
  bool isCalculateEnabled = false;
  Color w1FieldColor = Colors.black;
  Color w2FieldColor = Colors.black;

  @override
  void initState() {
    super.initState();
    // 1) whenever span or B→CG changes, recompute A→CG = span + B→CG
    aToBController.addListener(_syncAToCG);
    bToCGController.addListener(_syncAToCG);

    // 2) when any input changes, re-evaluate “Calculate” enabled
    for (final c in [
      aController,
      bController,
      aToBController,
      bToCGController,
      totalWeightController,
    ]) {
      c.addListener(_updateCalculateState);
    }
  }

  @override
  void dispose() {
    for (final c in [
      aController,
      bController,
      w1Controller,
      w2Controller,
      aToBController,
      bToCGController,
      aToCGController,
      totalWeightController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  /// Recompute A→CG = (A→B + B→CG)
  void _syncAToCG() {
    if (_syncingPoints) return;
    _syncingPoints = true;

    final span = double.tryParse(aToBController.text) ?? 0.0;
    final bCG = double.tryParse(bToCGController.text) ?? 0.0;
    final aCG = span + bCG;
    aToCGController.text = aCG.toStringAsFixed(1);

    _syncingPoints = false;
    _updateCalculateState();
  }

  /// Enable Calculate only when all inputs are filled
  void _updateCalculateState() {
    final ready =
        aController.text.isNotEmpty &&
        bController.text.isNotEmpty &&
        aToBController.text.isNotEmpty &&
        bToCGController.text.isNotEmpty &&
        aToCGController.text.isNotEmpty &&
        totalWeightController.text.isNotEmpty;
    setState(() => isCalculateEnabled = ready);
  }

  /// Reset everything
  void _onReset() {
    FocusScope.of(context).unfocus();
    for (final c in [
      aController,
      bController,
      w1Controller,
      w2Controller,
      aToBController,
      bToCGController,
      aToCGController,
      totalWeightController,
    ]) {
      c.clear();
    }
    setState(() {
      isCalculateEnabled = false;
      w1FieldColor = Colors.black;
      w2FieldColor = Colors.black;
    });
  }

  /// Compute reactions for a UDL treated as a single resultant at CG:
  void _onCalculate() {
    final W = double.tryParse(totalWeightController.text) ?? 0.0;
    final L = double.tryParse(aToBController.text) ?? 1.0;
    final a = double.tryParse(bToCGController.text) ?? 0.0;

    // compute original reactions
    final rawR1 = (L > 0) ? W * (L + a) / L : 0.0; // original at A
    final rawR2 = (L > 0) ? -W * a / L : 0.0; // original at B

    // 3) write them swapped into the bottom fields:
    w1Controller.text = rawR2.toStringAsFixed(1); // swapped into W1
    w2Controller.text = rawR1.toStringAsFixed(1); // swapped into W2

    // 4) compare to top‐row WLL caps and flag negatives/overloads
    final capA = double.tryParse(aController.text) ?? double.infinity;
    final capB = double.tryParse(bController.text) ?? double.infinity;

    setState(() {
      w1FieldColor =
          (rawR2 < 0 || rawR2.abs() > capA) ? Colors.red : Colors.green;
      w2FieldColor =
          (rawR1 < 0 || rawR1.abs() > capB) ? Colors.red : Colors.green;
    });
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
                    Text("Cantivlever UDL", style: AppTextStyle.titleSmall),
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
                      child: Image.asset(AppAssets.cantivleverUDL),
                    ),
                    // A WLL
                    Positioned(
                      top: 87,
                      left: 15,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: aController,

                        onChanged: (v) => _updateCalculateState(),
                      ),
                    ),
                    // B WLL
                    Positioned(
                      top: 87,
                      left: 165,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: bController,

                        onChanged: (v) => _updateCalculateState(),
                      ),
                    ),
                    // W1 (bottom)
                    Positioned(
                      top: 190,
                      left: 13,
                      child: PrimaryTextField(
                        width: 70,
                        height: 20,
                        controller: w1Controller,

                        enable: false,
                        calculatedColor: w1FieldColor,
                      ),
                    ),
                    // W2 (bottom)
                    Positioned(
                      top: 190,
                      left: 165,
                      child: PrimaryTextField(
                        width: 70,
                        height: 20,
                        controller: w2Controller,

                        enable: false,
                        calculatedColor: w2FieldColor,
                      ),
                    ),
                    // A→B
                    Positioned(
                      top: 272,
                      left: 75,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: aToBController,

                        onChanged: (v) => _syncAToCG(),
                      ),
                    ),
                    // B→CG
                    Positioned(
                      top: 272,
                      left: 244,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: bToCGController,

                        onChanged: (v) => _syncAToCG(),
                      ),
                    ),
                    // A→CG (auto)
                    Positioned(
                      top: 415,
                      left: 100,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: aToCGController,

                        enable: false,
                      ),
                    ),
                    // Total Wt
                    Positioned(
                      top: 505,
                      left: 245,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: totalWeightController,

                        onChanged: (v) => _updateCalculateState(),
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
