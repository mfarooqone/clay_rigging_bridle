import 'package:clay_rigging_bridle/utils/theme/constants/app_constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final String title;
  final VoidCallback onPressed;
  final bool enabled;
  final Color? backgroundColor;
  final Color? titleColor;
  final double? height;
  final double? width;

  final double? borderSize;
  final Color? borderColor;
  final double? borderRadius;
  final TextStyle? textStyle;

  const PrimaryButton({
    super.key,
    this.margin,
    this.padding,
    required this.title,
    required this.onPressed,
    this.enabled = true,
    this.backgroundColor,
    this.titleColor,
    this.height,
    this.width,
    this.borderSize,
    this.borderColor,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Container(
      margin: margin,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        color:
            enabled
                ? backgroundColor ?? appTheme.primaryColor
                : appTheme.colorScheme.primaryContainer,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          child: Container(
            width: width ?? 220,
            height: height ?? 48,
            alignment: Alignment.center,
            padding: padding,
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor ?? Colors.transparent,
                width: borderSize ?? 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style:
                  textStyle ??
                  appTheme.textTheme.bodyMedium?.copyWith(
                    color: titleColor ?? AppColors.white,
                    fontWeight: FontWeight.w600,
                  ), // Use provided textStyle or fallback
            ),
          ),
        ),
      ),
    );
  }
}
