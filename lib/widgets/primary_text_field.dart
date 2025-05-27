import 'package:clay_rigging_bridle/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  /// Creates a PrimaryTextField.
  ///
  ///
  final EdgeInsetsGeometry? margin;
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final TextInputAction inputAction;
  final TextAlign textAlign;
  final ValueChanged<String>? onSubmitted;
  final bool enable;
  final int maxLines;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool mandatory;
  final bool autoFocus;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
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

  const PrimaryTextField({
    super.key,
    this.margin,
    required this.controller,
    this.label,
    this.hintText,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType,
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
    this.contentPadding = const EdgeInsets.only(left: 16.0),
    this.textInputFormatter = const [],
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.labelFontSize,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          label != null
              ? Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '$label',
                          style: appTheme.textTheme.bodyMedium?.copyWith(
                            fontSize: labelFontSize ?? 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            if (mandatory)
                              TextSpan(
                                text: '*',
                                style: appTheme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.negativeColor,
                                  fontSize: 24.0,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : const SizedBox(),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.3)),
            child: TextField(
              cursorHeight: 10,
              onTap: onTap,
              obscureText: obscureText,
              textAlignVertical: TextAlignVertical.center,
              enabled: enable,
              style: appTheme.textTheme.bodyMedium?.copyWith(
                color:
                    enable
                        ? appTheme.iconTheme.color
                        : appTheme.colorScheme.primaryContainer,
              ),
              onChanged: onChanged,
              controller: controller,
              maxLength: maxLength,
              textCapitalization: textCapitalization,
              textAlign: textAlign,
              keyboardType: keyboardType,
              textInputAction: inputAction,
              onSubmitted: onSubmitted,
              autofocus: autoFocus,

              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: appTheme.textTheme.bodySmall,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                counterText: '',

                suffixIconConstraints: const BoxConstraints(
                  maxWidth: 80,
                  maxHeight: 50,
                ),
              ),
              maxLines: maxLines,
              focusNode: focusNode,
              inputFormatters: textInputFormatter,
            ),
          ),
        ],
      ),
    );
  }
}
