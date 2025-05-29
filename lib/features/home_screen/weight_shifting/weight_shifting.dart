import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeightShifting extends StatefulWidget {
  const WeightShifting({Key? key}) : super(key: key);

  @override
  State<WeightShifting> createState() => _WeightShiftingState();
}

class _WeightShiftingState extends State<WeightShifting> {
  // ── text controllers ──
  final aController = TextEditingController();
  final bController = TextEditingController();
  final beamController = TextEditingController();
  final pointAController = TextEditingController();
  final pointBController = TextEditingController();
  final totalWeightController = TextEditingController();

  // outputs
  final w1Controller = TextEditingController();
  final w2Controller = TextEditingController();

  // ── reactive fields ──
  final w1FieldColor = Colors.black.obs;
  final w2FieldColor = Colors.black.obs;
  final isCalculateEnabled = false.obs;

  // guard to avoid loop when syncing A/B/Beam
  bool _updatingPoints = false;

  @override
  void initState() {
    super.initState();
    // re‐evaluate button state when any input changes
    for (final c in [
      aController,
      bController,
      beamController,
      pointAController,
      pointBController,
      totalWeightController,
    ]) {
      c.addListener(_updateCalculateState);
    }
    // keep PointA + PointB == Beam
    pointAController.addListener(_onPointAChanged);
    pointBController.addListener(_onPointBChanged);
    beamController.addListener(_onBeamChanged);
  }

  @override
  void dispose() {
    for (final c in [
      aController,
      bController,
      beamController,
      pointAController,
      pointBController,
      totalWeightController,
      w1Controller,
      w2Controller,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _updateCalculateState() {
    final allFilled =
        aController.text.isNotEmpty &&
        bController.text.isNotEmpty &&
        beamController.text.isNotEmpty &&
        pointAController.text.isNotEmpty &&
        pointBController.text.isNotEmpty &&
        totalWeightController.text.isNotEmpty;
    isCalculateEnabled.value = allFilled;
  }

  void _onReset() {
    FocusScope.of(context).unfocus();
    for (final c in [
      aController,
      bController,
      beamController,
      pointAController,
      pointBController,
      totalWeightController,
      w1Controller,
      w2Controller,
    ]) {
      c.clear();
    }
    w1FieldColor.value = Colors.black;
    w2FieldColor.value = Colors.black;
    isCalculateEnabled.value = false;
  }

  /// When the user edits Point A:
  /// • clamp A ≤ Beam
  /// • then set B = Beam − A
  void _onPointAChanged() {
    if (_updatingPoints) return;
    _updatingPoints = true;

    final beam = int.tryParse(beamController.text) ?? 0;
    var a = int.tryParse(pointAController.text) ?? 0;
    if (a > beam) a = beam;
    final b = beam - a;

    pointAController.text = a.toString();
    pointBController.text = b.toString();

    _updatingPoints = false;
  }

  /// When the user edits Point B:
  /// • clamp B ≤ Beam
  /// • then set A = Beam − B
  void _onPointBChanged() {
    if (_updatingPoints) return;
    _updatingPoints = true;

    final beam = int.tryParse(beamController.text) ?? 0;
    var b = int.tryParse(pointBController.text) ?? 0;
    if (b > beam) b = beam;
    final a = beam - b;

    pointBController.text = b.toString();
    pointAController.text = a.toString();

    _updatingPoints = false;
  }

  /// When the user edits Beam:
  /// • clamp Beam ≥ 0
  /// • then recalc B = Beam − A (A stays as‐is, clamped to Beam)
  void _onBeamChanged() {
    if (_updatingPoints) return;
    _updatingPoints = true;
    pointAController.clear();
    pointBController.clear();
    _updatingPoints = false;
  }

  void _onCalculate() {
    final W = double.tryParse(totalWeightController.text) ?? 0.0;
    final L = double.tryParse(beamController.text) ?? 1.0;
    final DA = double.tryParse(pointAController.text) ?? 0.0;
    final DB = double.tryParse(pointBController.text) ?? 0.0;

    // simple beam reactions
    final w1 = (L > 0) ? W * DB / L : 0.0;
    final w2 = (L > 0) ? W * DA / L : 0.0;

    w1Controller.text = w1.toStringAsFixed(1);
    w2Controller.text = w2.toStringAsFixed(1);

    final WLL_A = double.tryParse(aController.text) ?? double.infinity;
    final WLL_B = double.tryParse(bController.text) ?? double.infinity;

    w1FieldColor.value = (w1 > WLL_A) ? Colors.red : Colors.green;
    w2FieldColor.value = (w2 > WLL_B) ? Colors.red : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      ArrowBackButton(),
                      Spacer(),
                      Text("Weight Shifting", style: AppTextStyle.titleSmall),
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
                        child: Image.asset(AppAssets.weightShifting),
                      ),

                      // Point A WLL
                      Positioned(
                        top: 102,
                        left: 38,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: aController,
                          hintText: 'A',
                          maxLength: 3,
                        ),
                      ),

                      // Point B WLL
                      Positioned(
                        top: 102,
                        left: 250,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: bController,
                          hintText: 'B',
                          maxLength: 3,
                        ),
                      ),

                      // W1
                      Positioned(
                        top: 217,
                        left: 38,
                        child: PrimaryTextField(
                          width: 70,
                          height: 20,
                          controller: w1Controller,
                          hintText: 'W1',
                          enable: false,
                          calculatedColor: w1FieldColor.value,
                        ),
                      ),

                      // W2
                      Positioned(
                        top: 217,
                        left: 254,
                        child: PrimaryTextField(
                          width: 70,
                          height: 20,
                          controller: w2Controller,
                          hintText: 'W2',
                          enable: false,
                          calculatedColor: w2FieldColor.value,
                        ),
                      ),

                      // Beam
                      Positioned(
                        top: 262,
                        left: 144,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: beamController,
                          hintText: 'Beam',
                          onChanged: (val) {
                            _onBeamChanged();
                          },
                          maxLength: 4,
                        ),
                      ),

                      // Point A
                      Positioned(
                        top: 388,
                        left: 55,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: pointAController,
                          hintText: 'Point A',
                          onChanged: (val) {
                            _onPointAChanged();
                          },
                          maxLength: 4,
                        ),
                      ),

                      // Point B
                      Positioned(
                        top: 388,
                        left: 235,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: pointBController,
                          hintText: 'Point B',
                          onChanged: (val) {
                            _onPointBChanged();
                          },
                          maxLength: 4,
                        ),
                      ),

                      // Total Wt
                      Positioned(
                        top: 487,
                        left: 148,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: totalWeightController,
                          hintText: 'Total Wt',
                          maxLength: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),
              PrimaryButton(
                title: "Calculate",
                enabled: isCalculateEnabled.value,
                onPressed: isCalculateEnabled.value ? _onCalculate : () {},
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
      ),
    );
  }
}
