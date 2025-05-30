import 'package:clay_rigging_bridle/utils/app_assets.dart';
import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplexUDL extends StatefulWidget {
  const ComplexUDL({Key? key}) : super(key: key);

  @override
  State<ComplexUDL> createState() => _ComplexUDLState();
}

class _ComplexUDLState extends State<ComplexUDL> {
  // ── Controllers ──
  final aController = TextEditingController(); // Point A WLL
  final bController = TextEditingController(); // Point B WLL
  final atoBController = TextEditingController(); // a to b length L
  final aToCGController = TextEditingController(); // Dist A→CG
  final bToCGController = TextEditingController(); // Dist B→CG
  final totalWeightController = TextEditingController(); // Total UDL weight

  // ── Outputs ──
  final w1Controller = TextEditingController(); // Reaction @ A
  final w2Controller = TextEditingController(); // Reaction @ B

  // ── Reactive state ──
  final w1Color = Colors.black.obs;
  final w2Color = Colors.black.obs;
  final isCalculateEnabled = false.obs;

  // guard to avoid listener recursion
  bool _syncing = false;

  /// Recompute whether all six inputs are non‐empty
  void _updateCalculateState() {
    final ready =
        aController.text.isNotEmpty &&
        bController.text.isNotEmpty &&
        atoBController.text.isNotEmpty &&
        aToCGController.text.isNotEmpty &&
        bToCGController.text.isNotEmpty &&
        totalWeightController.text.isNotEmpty;
    isCalculateEnabled.value = ready;
  }

  /// Reset everything
  void _onReset() {
    FocusScope.of(context).unfocus();
    for (final c in [
      aController,
      bController,
      atoBController,
      aToCGController,
      bToCGController,
      totalWeightController,
      w1Controller,
      w2Controller,
    ]) {
      c.clear();
    }
    w1Color.value = Colors.black;
    w2Color.value = Colors.black;
    isCalculateEnabled.value = false;
  }

  /// When aTob changes: clamp ≥0, then clear A→CG & B→CG
  void _onAtoBChanged() {
    if (_syncing) return;
    _syncing = true;

    var aTob = int.tryParse(atoBController.text) ?? 0;
    if (aTob < 0) aTob = 0;
    atoBController.text = aTob.toString();

    aToCGController.clear();
    bToCGController.clear();

    _syncing = false;
  }

  /// When A→CG changes: clamp ≤aTob, then set B→CG = aTob−A→CG
  void _onAToCGChanged() {
    if (_syncing) return;
    _syncing = true;

    final aTob = int.tryParse(atoBController.text) ?? 0;
    var a = int.tryParse(aToCGController.text) ?? 0;
    if (a > aTob) a = aTob;
    final b = aTob - a;

    aToCGController.text = a.toString();
    bToCGController.text = b.toString();

    _syncing = false;
  }

  /// When B→CG changes: clamp ≤aTob, then set A→CG = aTob−B→CG
  void _onBToCGChanged() {
    if (_syncing) return;
    _syncing = true;

    final aTob = int.tryParse(atoBController.text) ?? 0;
    var b = int.tryParse(bToCGController.text) ?? 0;
    if (b > aTob) b = aTob;
    final a = aTob - b;

    bToCGController.text = b.toString();
    aToCGController.text = a.toString();

    _syncing = false;
  }

  /// Compute reactions for a point‐load at the CG of the UDL:
  ///   R1 = W·(B→CG)/aTob,   R2 = W·(A→CG)/aTob
  void _onCalculate() {
    final W = double.tryParse(totalWeightController.text) ?? 0.0;
    final L = double.tryParse(atoBController.text) ?? 1.0;
    final DA = double.tryParse(aToCGController.text) ?? 0.0;
    final DB = double.tryParse(bToCGController.text) ?? 0.0;

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
  void initState() {
    super.initState();
    // nothing in initState—everything driven by onChanged handlers
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
                      Text("ComplexUDL", style: AppTextStyle.titleSmall),
                      Spacer(),
                      ArrowBackButton(color: Colors.transparent),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // diagram + fields
              Center(
                child: Container(
                  width: 360,
                  height: 600,
                  child: Stack(
                    children: [
                      Positioned.fill(child: Image.asset(AppAssets.complexUDL)),

                      // Point A WLL
                      Positioned(
                        top: 82,
                        left: 38,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: aController,
                          onChanged: (v) => _updateCalculateState(),
                        ),
                      ),

                      // Point B WLL
                      Positioned(
                        top: 82,
                        left: 250,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: bController,
                          onChanged: (v) => _updateCalculateState(),
                        ),
                      ),

                      // R1
                      Positioned(
                        top: 193,
                        left: 38,
                        child: PrimaryTextField(
                          width: 70,
                          height: 20,
                          controller: w1Controller,
                          enable: false,
                          calculatedColor: w1Color.value,
                        ),
                      ),

                      // R2
                      Positioned(
                        top: 193,
                        left: 254,
                        child: PrimaryTextField(
                          width: 70,
                          height: 20,
                          controller: w2Controller,
                          enable: false,
                          calculatedColor: w2Color.value,
                        ),
                      ),

                      // aTob
                      Positioned(
                        top: 240,
                        left: 144,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: atoBController,
                          onChanged: (v) {
                            _onAtoBChanged();
                            _updateCalculateState();
                          },
                        ),
                      ),

                      // A→CG
                      Positioned(
                        top: 431,
                        left: 54,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: aToCGController,
                          onChanged: (v) {
                            _onAToCGChanged();
                            _updateCalculateState();
                          },
                        ),
                      ),

                      // B→CG
                      Positioned(
                        top: 319,
                        left: 164,
                        child: PrimaryTextField(
                          width: 70,
                          height: 25,
                          controller: bToCGController,

                          onChanged: (v) {
                            _onBToCGChanged();
                            _updateCalculateState();
                          },
                        ),
                      ),

                      // Total Wt
                      Positioned(
                        top: 537,
                        left: 225,
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
