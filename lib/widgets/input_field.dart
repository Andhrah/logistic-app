import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    this.textController,
    FocusNode? node,
    this.labelText,
    this.hintText,
    required this.text,
    this.suffixIcon,
    required this.textHeight,
    required this.borderColor,
    // this.maxLines,
    this.area,
  }) : _node = node, super(key: key);

  final TextEditingController? textController;
  final FocusNode? _node;
  final String? labelText;
  final String? hintText;
  final String text;
  final Widget? suffixIcon;
  final double textHeight;
  final Color borderColor;
  // final double maxLines;
  final int? area;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          text,
          textScaleFactor: 1.2,
          style: const TextStyle(
            color: appPrimaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: textHeight),
        TextFormField(
          controller: textController,
          focusNode: _node,
          maxLines: area,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
            enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 0.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor.withOpacity(0.8)),
            ),
            // labelText: labelText,
            labelStyle: const TextStyle(fontSize: 18.0, color: Color(0xFF8C8C8C), fontWeight: FontWeight.w600),
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 18.0, color: Color(0xFFBDBDBD), fontWeight: FontWeight.w400),
            suffixIcon: suffixIcon,
          ),
        )
      ],
    );
  }
}