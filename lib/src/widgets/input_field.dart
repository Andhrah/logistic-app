import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trakk/src/values/font.dart';
import 'package:trakk/src/values/values.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      this.textController,
      FocusNode? node,
      this.labelText,
      this.hintText,
      required this.text,
      this.suffixIcon,
      required this.textHeight,
      required this.borderColor,
      this.enabled = true,
      // this.maxLines,
      this.area,
      this.keyboardType,
      this.validator,
      this.onTap,
      this.onSaved,
      this.onChanged,
      this.autovalidateMode,
      required this.obscureText,
      this.maxLines,
      this.textColor,
      this.inputFormatters})
      : _node = node,
        super(key: key);

  final TextEditingController? textController;
  final FocusNode? _node;
  final String? labelText;
  final String? hintText;
  final String text;
  final Widget? suffixIcon;
  final double textHeight;
  final Color borderColor;
  final Color? textColor;
  final bool enabled;

  // final double maxLines;
  final int? area;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final String? Function(String?)? onSaved;
  final String? Function(String?)? onChanged;
  final AutovalidateMode? autovalidateMode;
  final bool obscureText;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: textHeight),
        TextFormField(
          controller: textController,
          focusNode: _node,
          enabled: enabled,
          maxLines: maxLines ?? area,
          keyboardType: keyboardType,
          validator: validator,
          onTap: onTap,
          onSaved: onSaved,
          onChanged: onChanged,
          autovalidateMode: autovalidateMode,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appPrimaryColor, width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor.withOpacity(0.8)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: redColor.withOpacity(0.8)),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 0.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: appPrimaryColor, width: 0.0),
            ),
            // labelText: labelText,
            labelStyle: theme.textTheme.bodyText2!.copyWith(
                color: const Color(0xFF8C8C8C), fontWeight: kSemiBoldWeight),
            hintText: hintText,
            hintStyle: theme.textTheme.bodyText2!
                .copyWith(color: const Color(0xFFBDBDBD)),
            suffixIcon: suffixIcon,
          ),
        )
      ],
    );
  }
}
