import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:clay_rigging_bridle/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    this.margin,
    required this.controller,
    this.label,
    this.hintText,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType = TextInputType.number,
    this.inputAction = TextInputAction.done,
    this.textAlign = TextAlign.center,
    this.onSubmitted,
    this.enable = true,
    this.maxLines = 1,
    this.focusNode,
    this.obscureText = false,
    this.mandatory = false,
    this.autoFocus = false,
    this.onChanged,
    this.maxLength,
    this.infoIcon,
    this.infoIconMessage = 'info',
    this.contentPadding = const EdgeInsets.only(left: 8.0),
    this.textInputFormatter = const [],
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.labelFontSize,
    required this.width,
    required this.height,
    this.backgroungColor = Colors.transparent,
    this.calculatedColor = Colors.black,
  });

  final EdgeInsetsGeometry? margin;
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final TextAlign textAlign;
  final ValueChanged<String>? onSubmitted;
  final bool enable;
  final int maxLines;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool mandatory;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final Icon? infoIcon;
  final String infoIconMessage;
  final EdgeInsets? contentPadding;
  final List<TextInputFormatter> textInputFormatter;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final InputBorder? border;
  final double? labelFontSize;
  final double width;
  final double height;
  final Color? backgroungColor;
  final Color? calculatedColor;

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Container(
      margin: margin,
      // clipBehavior ensures nothing can paint outside this box
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(color: backgroungColor),
      width: width,
      height:
          height + (label != null ? 20 : 0), // leave room for optional label
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: RichText(
                text: TextSpan(
                  text: label,
                  style: appTheme.textTheme.bodyMedium?.copyWith(
                    fontSize: labelFontSize ?? 12,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    if (mandatory)
                      TextSpan(
                        text: ' *',
                        style: appTheme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.negativeColor,
                        ),
                      ),
                  ],
                ),
              ),
            ),

          Container(
            color: Colors.red.withValues(alpha: 0.3),
            width: width,
            height: height,
            child: AutoSizeTextField(
              controller: controller,
              minFontSize: 8,
              maxLines: 1,
              cursorHeight: 12,
              onTap: onTap,
              obscureText: obscureText,
              enabled: enable,
              style: appTheme.textTheme.bodyMedium?.copyWith(
                color: enable ? appTheme.iconTheme.color : calculatedColor,
                fontWeight: FontWeight.bold,
              ),
              onChanged: onChanged,
              maxLength: maxLength,
              textCapitalization: textCapitalization,
              textAlignVertical: TextAlignVertical.bottom,
              textAlign: textAlign,
              keyboardType: keyboardType,
              textInputAction: inputAction,
              onSubmitted: onSubmitted,
              autofocus: autoFocus,
              focusNode: focusNode,
              inputFormatters: textInputFormatter,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: contentPadding,
                hintText: hintText,
                hintStyle: appTheme.textTheme.bodySmall,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                border: border ?? InputBorder.none,
                enabledBorder: border ?? InputBorder.none,
                focusedBorder: border ?? InputBorder.none,
                counterText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
