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
  final TextAlign textAlignHorizontal;
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

  const PrimaryTextField({
    super.key,
    this.margin,
    required this.controller,
    this.label,
    this.hintText,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType,
    this.inputAction = TextInputAction.done,
    this.textAlignHorizontal = TextAlign.start,
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
          TextField(
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
            textAlign: textAlignHorizontal,
            keyboardType: keyboardType,
            textInputAction: inputAction,
            onSubmitted: onSubmitted,
            autofocus: autoFocus,

            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: appTheme.textTheme.bodySmall,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              suffixIconConstraints: const BoxConstraints(
                maxWidth: 80,
                maxHeight: 50,
              ),
            ),
            maxLines: maxLines,
            focusNode: focusNode,
            inputFormatters: textInputFormatter,
          ),
        ],
      ),
    );
  }
}

///
///
///

class PasswordTextField extends StatefulWidget {
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final ValueChanged<String>? onSubmitted;
  final bool enable;
  final int maxLines;
  final FocusNode? focusNode;
  final bool mandatory;
  final bool readOnly;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final EdgeInsets? contentPadding;
  final List<TextInputFormatter> textInputFormatter;

  const PasswordTextField({
    super.key,
    this.margin,
    this.controller,
    this.label,
    this.hintText,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.inputAction = TextInputAction.done,
    this.onSubmitted,
    this.enable = true,
    this.maxLines = 1,
    this.focusNode,
    this.mandatory = false,
    this.readOnly = true,
    this.onChanged,
    this.maxLength,
    this.onTap,
    this.onEditingComplete,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 8.0),
    this.textInputFormatter = const [],
  });

  @override
  // ignore: library_private_types_in_public_api
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool hidePassword = true;
  //
  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Container(
      padding: widget.contentPadding,
      child: Column(
        children: [
          widget.label != null
              ? Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Text(
                      widget.label!,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    if (widget.mandatory)
                      Text(
                        '*',
                        style: appTheme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.negativeColor,
                          fontSize: 24.0,
                        ),
                      ),
                  ],
                ),
              )
              : Container(),
          Stack(
            children: [
              TextField(
                obscureText: hidePassword,
                readOnly: widget.readOnly,
                textAlignVertical: TextAlignVertical.center,
                enabled: widget.enable,
                style: appTheme.textTheme.bodyMedium,
                onChanged: widget.onChanged,
                onTap: widget.onTap,
                onEditingComplete: widget.onEditingComplete,
                controller: widget.controller,
                maxLength: widget.maxLength,
                textInputAction: widget.inputAction,
                onSubmitted: widget.onSubmitted,
                textCapitalization: widget.textCapitalization,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: appTheme.textTheme.bodySmall,
                ),
                maxLines: widget.maxLines,
                focusNode: widget.focusNode,
                inputFormatters: widget.textInputFormatter,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    hidePassword
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                    size: 18,
                    color: appTheme.iconTheme.color,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CapitalizeAllWordsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isNotEmpty) {
      String capitalizedText = newValue.text
          .split(' ')
          .map((word) {
            if (word.isNotEmpty) {
              return word[0].toUpperCase() + word.substring(1);
            }
            return word;
          })
          .join(' ');

      return newValue.copyWith(
        text: capitalizedText,
        selection: newValue.selection,
      );
    }
    return newValue;
  }
}
