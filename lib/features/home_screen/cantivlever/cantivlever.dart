import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

class Cantivlever extends StatefulWidget {
  const Cantivlever({Key? key}) : super(key: key);

  @override
  State<Cantivlever> createState() => _CantivleverState();
}

class _CantivleverState extends State<Cantivlever> {
  // ── Controllers ──
  final aController = TextEditingController(); // WLL @ A
  final bController = TextEditingController(); // WLL @ B
  final aToBController = TextEditingController(); // dist A→B
  final bToWController = TextEditingController(); // dist B→W
  final aToWController = TextEditingController(); // dist A→W (read‐only)
  final totalWeightController = TextEditingController(); // load W

  // ── Reaction outputs ──
  final w1Controller = TextEditingController();
  final w2Controller = TextEditingController();

  // ── UI state ──
  bool _syncing = false;
  bool isCalculateEnabled = false;
  Color w1FieldColor = Colors.black;
  Color w2FieldColor = Colors.black;

  @override
  void initState() {
    super.initState();

    // Re-evaluate Calculate button whenever any input changes
    for (final c in [
      aController,
      bController,
      aToBController,
      bToWController,
      totalWeightController,
    ]) {
      c.addListener(_updateCalculateState);
    }

    // Keep A→W = A→B + B→W, clamp both ≤ span where needed
    aToBController.addListener(_syncAToW);
    bToWController.addListener(_syncAToW);
  }

  @override
  void dispose() {
    for (final c in [
      aController,
      bController,
      aToBController,
      bToWController,
      aToWController,
      totalWeightController,
      w1Controller,
      w2Controller,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _updateCalculateState() {
    final ready =
        aController.text.isNotEmpty &&
        bController.text.isNotEmpty &&
        aToBController.text.isNotEmpty &&
        bToWController.text.isNotEmpty &&
        aToWController.text.isNotEmpty &&
        totalWeightController.text.isNotEmpty;
    setState(() => isCalculateEnabled = ready);
  }

  void _onReset() {
    FocusScope.of(context).unfocus();
    for (final c in [
      aController,
      bController,
      aToBController,
      bToWController,
      aToWController,
      totalWeightController,
      w1Controller,
      w2Controller,
    ]) {
      c.clear();
    }
    setState(() {
      isCalculateEnabled = false;
      w1FieldColor = Colors.black;
      w2FieldColor = Colors.black;
    });
  }

  /// Whenever A→B or B→W changes, recompute A→W = A→B + B→W
  void _syncAToW() {
    if (_syncing) return;
    _syncing = true;

    final ab = int.tryParse(aToBController.text) ?? 0;
    final bw = int.tryParse(bToWController.text) ?? 0;
    // clamp distances to ≥0
    final aB = ab < 0 ? 0 : ab;
    final bW = bw < 0 ? 0 : bw;
    aToBController.text = aB.toString();
    bToWController.text = bW.toString();

    // total distance
    final aW = aB + bW;
    aToWController.text = aW.toString();

    _syncing = false;
    _updateCalculateState();
  }

  void _onCalculate() {
    // 1) parse inputs
    final W = double.tryParse(totalWeightController.text) ?? 0.0;
    final L = double.tryParse(aToBController.text) ?? 1.0; // span A→B
    final a = double.tryParse(bToWController.text) ?? 0.0; // overhang

    // 2) compute raw overhang reactions
    final rawR1 = (L > 0) ? W * (L + a) / L : 0.0; // originally at A
    final rawR2 = (L > 0) ? -W * a / L : 0.0; // originally at B

    // 3) swap them
    final R1 = rawR2; // now bottom‐left
    final R2 = rawR1; // now bottom‐right

    // 4) write into the bottom reaction fields
    w1Controller.text = R1.toStringAsFixed(1);
    w2Controller.text = R2.toStringAsFixed(1);

    // 5) compare to top‐row WLL caps and flag negatives/overloads in red
    final capA = double.tryParse(aController.text) ?? double.infinity;
    final capB = double.tryParse(bController.text) ?? double.infinity;

    setState(() {
      w1FieldColor = (R1 < 0 || R1.abs() > capA) ? Colors.red : Colors.green;
      w2FieldColor = (R2 < 0 || R2.abs() > capB) ? Colors.red : Colors.green;
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
                    Text("Cantivlever", style: AppTextStyle.titleSmall),
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
                    Positioned.fill(child: Image.asset(AppAssets.cantivlever)),

                    // A WLL
                    Positioned(
                      top: 86,
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
                      top: 86,
                      left: 165,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: bController,

                        onChanged: (v) => _updateCalculateState(),
                      ),
                    ),

                    // W1
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

                    // W2
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
                      top: 275,
                      left: 75,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: aToBController,
                        onChanged: (v) {
                          _syncAToW();
                        },
                      ),
                    ),

                    // B→W
                    Positioned(
                      top: 275,
                      left: 244,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: bToWController,
                        onChanged: (v) {
                          _syncAToW();
                        },
                      ),
                    ),

                    // A→W (disabled, auto-sum)
                    Positioned(
                      top: 415,
                      left: 100,
                      child: PrimaryTextField(
                        width: 70,
                        height: 25,
                        controller: aToWController,
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
