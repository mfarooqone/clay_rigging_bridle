import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UDL extends StatefulWidget {
  const UDL({Key? key}) : super(key: key);

  @override
  State<UDL> createState() => _UDLState();
}

class _UDLState extends State<UDL> {
  // ── controllers ──
  final aController = TextEditingController(); // Point A WLL
  final bController = TextEditingController(); // Point B WLL
  final beamController = TextEditingController(); // Beam span L
  final totalWeightController = TextEditingController(); // UDL total W
  final pointAController = TextEditingController(); // Dist A→CG
  final pointBController = TextEditingController(); // Dist B→CG

  // outputs
  final w1Controller = TextEditingController(); // reaction @ A
  final w2Controller = TextEditingController(); // reaction @ B

  // reactive state
  final w1Color = Colors.black.obs;
  final w2Color = Colors.black.obs;
  final isCalculateEnabled = false.obs;

  bool _updatingPoints = false;

  @override
  void initState() {
    super.initState();

    // recalc button-enabled any time an input changes
    for (final c in [
      aController,
      bController,
      beamController,
      totalWeightController,
      pointAController,
      pointBController,
    ]) {
      c.addListener(_updateCalculateState);
    }
    // keep PointA + PointB == Beam, or clear them on Beam change
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
      totalWeightController,
      pointAController,
      pointBController,
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
        totalWeightController.text.isNotEmpty &&
        pointAController.text.isNotEmpty &&
        pointBController.text.isNotEmpty;
    isCalculateEnabled.value = allFilled;
  }

  void _onReset() {
    FocusScope.of(context).unfocus();
    for (final c in [
      aController,
      bController,
      beamController,
      totalWeightController,
      pointAController,
      pointBController,
      w1Controller,
      w2Controller,
    ]) {
      c.clear();
    }
    w1Color.value = Colors.black;
    w2Color.value = Colors.black;
    isCalculateEnabled.value = false;
  }

  /// When the Beam changes: clear A & B
  void _onBeamChanged() {
    if (_updatingPoints) return;
    _updatingPoints = true;

    // clamp beam to ≥0
    var beam = int.tryParse(beamController.text) ?? 0;
    if (beam < 0) beam = 0;
    beamController.text = beam.toString();

    // clear the CG distances entirely
    pointAController.clear();
    pointBController.clear();

    _updatingPoints = false;
  }

  /// When user edits Point A:
  ///   clamp A ≤ Beam, then set B = Beam − A
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

  /// When user edits Point B:
  ///   clamp B ≤ Beam, then set A = Beam − B
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

  void _calculate() {
    final W = double.tryParse(totalWeightController.text) ?? 0.0;
    final L = double.tryParse(beamController.text) ?? 1.0;
    final DA = double.tryParse(pointAController.text) ?? 0.0;
    final DB = double.tryParse(pointBController.text) ?? 0.0;

    // reactions for a point‐load at CG:
    final R1 = (L > 0) ? W * DB / L : 0.0;
    final R2 = (L > 0) ? W * DA / L : 0.0;

    w1Controller.text = R1.toStringAsFixed(1);
    w2Controller.text = R2.toStringAsFixed(1);

    final WLL_A = double.tryParse(aController.text) ?? double.infinity;
    final WLL_B = double.tryParse(bController.text) ?? double.infinity;

    w1Color.value = (R1 > WLL_A) ? Colors.red : Colors.green;
    w2Color.value = (R2 > WLL_B) ? Colors.red : Colors.green;
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

              Center(
                child: Container(
                  width: 360,
                  height: 600,
                  child: Stack(
                    children: [
                      Positioned.fill(child: Image.asset(AppAssets.udl)),

                      // Point A WLL
                      Positioned(
                        top: 78,
                        left: 38,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: aController,
                        ),
                      ),

                      // Point B WLL
                      Positioned(
                        top: 78,
                        left: 250,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: bController,
                        ),
                      ),

                      // W1
                      Positioned(
                        top: 188,
                        left: 38,
                        child: PrimaryTextField(
                          width: 70,
                          height: 20,
                          controller: w1Controller,
                          enable: false,
                          calculatedColor: w1Color.value,
                        ),
                      ),

                      // W2
                      Positioned(
                        top: 188,
                        left: 254,
                        child: PrimaryTextField(
                          width: 70,
                          height: 20,
                          controller: w2Controller,
                          enable: false,
                          calculatedColor: w2Color.value,
                        ),
                      ),

                      // Beam L
                      Positioned(
                        top: 235,
                        left: 144,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: beamController,
                          onChanged: (value) {
                            _onBeamChanged();
                          },
                        ),
                      ),

                      // Total Wt
                      Positioned(
                        top: 436,
                        left: 144,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: totalWeightController,
                        ),
                      ),

                      // Dist A→CG
                      Positioned(
                        top: 500,
                        left: 55,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: pointAController,

                          onChanged: (value) {
                            _onPointAChanged();
                          },
                        ),
                      ),

                      // Dist B→CG
                      Positioned(
                        top: 500,
                        left: 235,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: pointBController,

                          onChanged: (value) {
                            _onPointBChanged();
                          },
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
                onPressed: isCalculateEnabled.value ? _calculate : () {},
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
