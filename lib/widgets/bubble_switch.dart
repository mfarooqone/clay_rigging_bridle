import 'package:clay_rigging_bridle/utils/theme/constants/app_constants.dart';
import 'package:flutter/material.dart';

class BubbleSwitch extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? selectedColor;

  const BubbleSwitch({
    super.key,
    this.margin,
    required this.title,
    required this.value,
    required this.onChanged,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Container(
      margin: margin,
      width: 36.0,
      height: 25.0,
      child: Material(
        borderRadius: BorderRadius.circular(2),
        color:
            value
                ? selectedColor ?? appTheme.primaryColor
                : appTheme.colorScheme.secondaryContainer,
        child: InkWell(
          onTap: () => onChanged(!value),
          borderRadius: BorderRadius.circular(2),
          child: Container(
            width: double.infinity,
            height: 25,
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: appTheme.textTheme.bodyMedium?.copyWith(
                color: value ? AppColors.white : appTheme.iconTheme.color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
