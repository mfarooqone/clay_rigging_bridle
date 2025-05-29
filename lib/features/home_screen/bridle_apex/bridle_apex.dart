import 'dart:math';

import 'package:clay_rigging_bridle/features/home_screen/home_controller.dart';
import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BridleApex extends StatefulWidget {
  const BridleApex({Key? key}) : super(key: key);
  @override
  State<BridleApex> createState() => _BridleApexState();
}

class _BridleApexState extends State<BridleApex> {
  final HomeController controller = Get.find();

  // input controllers
  final atoBController = TextEditingController(); // full span A→B (unused here)
  final atoXController = TextEditingController(); // horizontal from A to apex
  final btoXController = TextEditingController(); // horizontal from B to apex
  final iController = TextEditingController(); // apex angle
  final l1Controller = TextEditingController(); // leg1 length
  final l2Controller = TextEditingController(); // leg2 length
  final aHeightController = TextEditingController(); // A attach height
  final bHeightController = TextEditingController(); // B attach height
  final wllController = TextEditingController(); // WLL capacity
  final apexHeightController = TextEditingController(); // apex vertical height
  final totalWeightController = TextEditingController(); // load weight

  // colors for calculated fields
  Color l1FieldColor = Colors.black;
  Color l2FieldColor = Colors.black;
  Color wllFieldColor = Colors.black;
  Color angleFieldColor = Colors.black;

  bool _updatingHalves = false;
  bool _updatingApex = false;
  bool isCalculateEnabled = false;

  @override
  void initState() {
    super.initState();
    // re‐evaluate Calculate button enabled state whenever relevant inputs change
    for (final c in [
      atoXController,
      btoXController,
      aHeightController,
      bHeightController,
      wllController,
      apexHeightController,
      totalWeightController,
    ]) {
      c.addListener(_updateCalculateState);
    }
  }

  @override
  void dispose() {
    for (final c in [
      atoBController,
      atoXController,
      btoXController,
      iController,
      l1Controller,
      l2Controller,
      aHeightController,
      bHeightController,
      wllController,
      apexHeightController,
      totalWeightController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _updateCalculateState() {
    final allFilled =
        atoXController.text.isNotEmpty &&
        btoXController.text.isNotEmpty &&
        aHeightController.text.isNotEmpty &&
        bHeightController.text.isNotEmpty &&
        wllController.text.isNotEmpty &&
        apexHeightController.text.isNotEmpty &&
        totalWeightController.text.isNotEmpty;
    if (allFilled != isCalculateEnabled) {
      setState(() => isCalculateEnabled = allFilled);
    }
  }

  void _onReset() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      for (final c in [
        atoBController,
        atoXController,
        btoXController,
        iController,
        l1Controller,
        l2Controller,
        aHeightController,
        bHeightController,
        wllController,
        apexHeightController,
        totalWeightController,
      ]) {
        c.clear();
      }
      l1FieldColor = Colors.black;
      l2FieldColor = Colors.black;
      wllFieldColor = Colors.black;
      angleFieldColor = Colors.black;
      isCalculateEnabled = false;
    });
  }

  /// clamp A→X ≤ A→B, mirror into B→X
  void _onAtoXChanged(String v) {
    if (_updatingHalves) return;
    _updatingHalves = true;
    final full = int.tryParse(atoBController.text) ?? 0;
    var x = int.tryParse(v) ?? 0;
    if (x > full) {
      x = full;
      atoXController.text = x.toString();
      atoXController.selection = TextSelection.collapsed(
        offset: x.toString().length,
      );
    }
    btoXController.text = (full - x).toString();
    _updatingHalves = false;
  }

  /// clamp B→X ≤ A→B, mirror into A→X
  void _onBtoXChanged(String v) {
    if (_updatingHalves) return;
    _updatingHalves = true;
    final full = int.tryParse(atoBController.text) ?? 0;
    var b = int.tryParse(v) ?? 0;
    if (b > full) {
      b = full;
      btoXController.text = b.toString();
      btoXController.selection = TextSelection.collapsed(
        offset: b.toString().length,
      );
    }
    atoXController.text = (full - b).toString();
    _updatingHalves = false;
  }

  /// clamp Apex Height < B Height
  void _onApexHeightChanged(String v) {
    if (_updatingApex) return;
    _updatingApex = true;
    final bVal = int.tryParse(bHeightController.text) ?? 0;
    var aVal = int.tryParse(v) ?? 0;
    if (aVal >= bVal) {
      aVal = (bVal > 0 ? bVal - 1 : 0);
      apexHeightController.text = aVal.toString();
      apexHeightController.selection = TextSelection.collapsed(
        offset: aVal.toString().length,
      );
    }
    _updatingApex = false;
  }

  /// Compute L₁, L₂, I angle, then update colors via Donovan formulas
  void _onCalculate() {
    // horizontals
    final H1 = double.tryParse(atoXController.text) ?? 0.0;
    final H2 = double.tryParse(btoXController.text) ?? 0.0;
    // verticals
    final V1 =
        (double.tryParse(aHeightController.text) ?? 0.0) -
        (double.tryParse(apexHeightController.text) ?? 0.0);
    final V2 =
        (double.tryParse(bHeightController.text) ?? 0.0) -
        (double.tryParse(apexHeightController.text) ?? 0.0);

    // 1) leg lengths
    final L1 = sqrt(V1 * V1 + H1 * H1);
    final L2 = sqrt(V2 * V2 + H2 * H2);
    l1Controller.text = L1.toStringAsFixed(1);
    l2Controller.text = L2.toStringAsFixed(1);

    // 2) apex angle
    final dot = -H1 * H2 + V1 * V2;
    final cosA = (L1 * L2) > 0 ? (dot / (L1 * L2)).clamp(-1.0, 1.0) : 1.0;
    final angleRad = acos(cosA);
    final angleDeg = angleRad * 180 / pi;
    iController.text = "${angleDeg.toStringAsFixed(1)}°";

    // 3) color logic
    _updateFieldColors(V1, V2, H1, H2, L1, L2, angleDeg);
  }

  void _updateFieldColors(
    double V1,
    double V2,
    double H1,
    double H2,
    double L1,
    double L2,
    double angleDeg,
  ) {
    final weight = double.tryParse(totalWeightController.text) ?? 0.0;
    final wll = double.tryParse(wllController.text) ?? 0.0;
    final denom = V1 * H2 + V2 * H1;

    // T₁ & T₂ from Donovan sheet
    final T1 = denom > 0 ? weight * L1 * H2 / denom : double.infinity;
    final T2 = denom > 0 ? weight * L2 * H1 / denom : double.infinity;

    final over1 = T1 > wll;
    final over2 = T2 > wll;
    final anyOver = over1 || over2;
    final angleSafe = angleDeg <= 120.0;

    setState(() {
      l1FieldColor = over1 ? Colors.red : Colors.black;
      l2FieldColor = over2 ? Colors.red : Colors.black;
      wllFieldColor = anyOver ? Colors.red : Colors.black;
      angleFieldColor = angleSafe ? Colors.green : Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    // ── header ──
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            ArrowBackButton(),
                            Spacer(),
                            Text(
                              "Bridle Apex and Point Position",
                              style: AppTextStyle.titleSmall,
                            ),
                            Spacer(),
                            ArrowBackButton(color: Colors.transparent),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ── diagram & inputs ──
                    Center(
                      child: Container(
                        width: 360,
                        height: 600,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(AppAssets.bridleApex),
                            ),

                            // A→B (you can still type full span if needed)
                            Positioned(
                              top: 65,
                              left: 138,
                              child: PrimaryTextField(
                                width: 90,
                                height: 25,
                                controller: atoBController,
                                onChanged: (v) {
                                  controller.isLoading.value = true;
                                  // reset X spans when full span changes
                                  atoXController.clear();
                                  btoXController.clear();
                                  controller.isLoading.value = false;
                                },
                              ),
                            ),

                            // A→X
                            Positioned(
                              top: 138,
                              left: 58,
                              child: PrimaryTextField(
                                width: 50,
                                height: 25,
                                controller: atoXController,
                                onChanged: (v) {
                                  controller.isLoading.value = true;
                                  _onAtoXChanged(v);
                                  controller.isLoading.value = false;
                                },
                              ),
                            ),

                            // B→X
                            Positioned(
                              top: 138,
                              left: 262,
                              child: PrimaryTextField(
                                width: 50,
                                height: 25,
                                controller: btoXController,
                                onChanged: (v) {
                                  controller.isLoading.value = true;
                                  _onBtoXChanged(v);
                                  controller.isLoading.value = false;
                                },
                              ),
                            ),

                            // I (angle)
                            Positioned(
                              top: 165,
                              left: 158,
                              child: PrimaryTextField(
                                width: 50,
                                height: 25,
                                controller: iController,
                                enable: false,
                                calculatedColor: angleFieldColor,
                              ),
                            ),

                            // L1
                            Positioned(
                              top: 215,
                              left: 88,
                              child: PrimaryTextField(
                                width: 50,
                                height: 25,
                                controller: l1Controller,
                                enable: false,
                                calculatedColor: l1FieldColor,
                              ),
                            ),

                            // L2
                            Positioned(
                              top: 215,
                              left: 233,
                              child: PrimaryTextField(
                                width: 50,
                                height: 25,
                                controller: l2Controller,
                                enable: false,
                                calculatedColor: l2FieldColor,
                              ),
                            ),

                            // A Height
                            Positioned(
                              top: 300,
                              left: 28,
                              child: PrimaryTextField(
                                width: 80,
                                height: 25,
                                controller: aHeightController,
                              ),
                            ),

                            // B Height
                            Positioned(
                              top: 300,
                              left: 252,
                              child: PrimaryTextField(
                                width: 80,
                                height: 25,
                                controller: bHeightController,
                              ),
                            ),

                            // WLL
                            Positioned(
                              top: 433,
                              left: 55,
                              child: PrimaryTextField(
                                width: 70,
                                height: 25,
                                controller: wllController,
                                calculatedColor: wllFieldColor,
                              ),
                            ),

                            // Apex Height
                            Positioned(
                              top: 433,
                              left: 245,
                              child: PrimaryTextField(
                                width: 70,
                                height: 25,
                                controller: apexHeightController,
                                onChanged: (v) {
                                  controller.isLoading.value = true;
                                  _onApexHeightChanged(v);
                                  controller.isLoading.value = false;
                                },
                              ),
                            ),

                            // Weight
                            Positioned(
                              top: 470,
                              left: 150,
                              child: PrimaryTextField(
                                width: 70,
                                height: 25,
                                controller: totalWeightController,
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
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.isLoading.value = true;
                        _onCalculate();
                        controller.isLoading.value = false;
                      },
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
            if (controller.isLoading.value) SizedBox(),
          ],
        ),
      ),
    );
  }
}
