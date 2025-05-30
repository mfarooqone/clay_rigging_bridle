import 'package:clay_rigging_bridle/utils/app_text_styles.dart';
import 'package:clay_rigging_bridle/widgets/arrow_back_button.dart';
import 'package:clay_rigging_bridle/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text("Information", style: AppTextStyle.titleSmall),
                  Spacer(),
                  ArrowBackButton(color: Colors.transparent),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _infoSection(
                    backgroundColor: Colors.red.shade100,
                    iconColor: Colors.red,
                    texts: const [
                      'Red color-WARNING-values exceed the given limits (WLL, weight, length, angle), represents the action of a force opposing gravity (negative force).',
                      'Always seek the advice of a suitably qualified rigger or engineer to determine the proper selection of rigging equipment and have it installed by a qualified rigger.',
                      'Remember that all rigging should be done by qualified personnel.',
                      'Remember the load must include all rigging hardware, cables, truss etc., up to the attachment points.',
                      'According to rigging rules, the total bridle angle should not exceed 120°',
                    ],
                  ),
                  const SizedBox(height: 16),
                  _infoSection(
                    backgroundColor: Colors.green.shade100,
                    iconColor: Colors.green,
                    texts: const [
                      'Green color - INFORMATION - the result values do not exceed the given limits and rigging rules.',
                      'The application accepts all units of measurement, both metric and imperial (cm, m, in, ft). Whether you input values in feet or meters, the results will be accurate and consistent with the unit you used.',
                    ],
                  ),
                  const SizedBox(height: 16),
                  _infoSection(
                    backgroundColor: Colors.grey.shade300,
                    iconColor: Colors.black,
                    texts: const [
                      'CG - Centre of Gravity.',
                      'UDL - Uniformly Distributed Load.',
                      'WLL - Working Load Limit.',
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryButton(
              title: "Close",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoSection({
    required Color backgroundColor,
    required Color iconColor,
    required List<String> texts,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children:
            texts.map((text) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.fitness_center, color: iconColor, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(color: iconColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
