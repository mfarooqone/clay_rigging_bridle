import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class UnitConverter extends StatefulWidget {
  const UnitConverter({Key? key}) : super(key: key);

  @override
  State<UnitConverter> createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  final TextEditingController aController = TextEditingController();
  String? fromUnit;
  String? toUnit;
  double? result;
  String selectedCategory = 'Length';

  final Map<String, List<String>> unitCategories = {
    'Length': ['Centimeters', 'Inches', 'Meters', 'Feet'],
    'Weight': ['Kilograms', 'Pounds', 'Tons'],
  };

  @override
  Widget build(BuildContext context) {
    List<String> currentUnits = unitCategories[selectedCategory]!;

    // Reset toUnit if it becomes invalid (same as fromUnit or not in current category)
    if (fromUnit != null && toUnit == fromUnit) {
      toUnit = null;
    }
    if (toUnit != null && !currentUnits.contains(toUnit)) {
      toUnit = null;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF4F6FA),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                child: Row(
                  children: [
                    const ArrowBackButton(),
                    const Spacer(),
                    Text("Unit Converter", style: AppTextStyle.titleSmall),
                    const Spacer(),
                    const ArrowBackButton(color: Colors.transparent),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        value: selectedCategory,
                        isExpanded: true,
                        items:
                            unitCategories.keys
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                            fromUnit = null;
                            toUnit = null;
                            result = null;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              value: fromUnit,
                              isExpanded: true,
                              hint: const Text('From'),
                              onChanged: (value) {
                                setState(() {
                                  fromUnit = value;
                                  if (toUnit == value) toUnit = null;
                                });
                              },
                              items:
                                  currentUnits
                                      .map(
                                        (unit) => DropdownMenuItem(
                                          value: unit,
                                          child: Text(unit),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.compare_arrows),
                          ),
                          Expanded(
                            child: DropdownButton<String>(
                              value: toUnit,
                              isExpanded: true,
                              hint: const Text('To'),
                              onChanged:
                                  (value) => setState(() => toUnit = value),
                              items:
                                  currentUnits
                                      .where((unit) => unit != fromUnit)
                                      .map(
                                        (unit) => DropdownMenuItem(
                                          value: unit,
                                          child: Text(unit),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: aController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Enter value",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              title: "CONVERT",
                              onPressed: convertUnit,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: PrimaryButton(
                              backgroundColor: Colors.red,
                              title: "RESET",
                              onPressed: () {
                                aController.clear();
                                setState(() {
                                  result = null;
                                  fromUnit = null;
                                  toUnit = null;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (result != null)
                Center(
                  child: Text(
                    "Result: $result",
                    style: AppTextStyle.titleSmall,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void convertUnit() {
    double? value = double.tryParse(aController.text);
    if (value == null || fromUnit == null || toUnit == null) return;

    double conversionFactor = getConversionFactor(fromUnit!, toUnit!);
    setState(() => result = value * conversionFactor);
  }

  double getConversionFactor(String from, String to) {
    Map<String, Map<String, double>> conversionMap = {
      'Centimeters': {'Inches': 0.393701, 'Meters': 0.01, 'Feet': 0.0328084},
      'Inches': {'Centimeters': 2.54, 'Meters': 0.0254, 'Feet': 0.0833333},
      'Meters': {'Centimeters': 100, 'Inches': 39.3701, 'Feet': 3.28084},
      'Feet': {'Centimeters': 30.48, 'Inches': 12, 'Meters': 0.3048},
      'Kilograms': {'Pounds': 2.20462, 'Tons': 0.00110231},
      'Pounds': {'Kilograms': 0.453592, 'Tons': 0.0005},
      'Tons': {'Kilograms': 907.185, 'Pounds': 2000},
    };

    return conversionMap[from]?[to] ?? 1.0;
  }
}
