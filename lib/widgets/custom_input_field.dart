import 'package:flutter/material.dart';
import 'package:trakk/utils/colors.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
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
    this.keyboardType,
    this.validator,
    this.onTap,
    this.onSaved,
    this.onChanged,
    this.autovalidateMode,
    required this.obscureText,
    this.maxLines, this.textColor,
  }) : _node = node, super(key: key);

  final TextEditingController? textController;
  final FocusNode? _node;
  final String? labelText;
  final String? hintText;
  final String text;
  final Widget? suffixIcon;
  final double textHeight;
  final Color borderColor;
  final Color? textColor;
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


  @override
  Widget build(BuildContext context) {
    return 
    Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(text),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(color: whiteColor,),
          child: TextFormField(
            controller: textController,
            focusNode: _node,
            maxLines: maxLines ?? area,
            keyboardType: keyboardType,
            validator: validator,
            onTap: onTap,
            onSaved: onSaved,
            onChanged: onChanged,
            autovalidateMode: autovalidateMode,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
              enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 0.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryColor.withOpacity(0.8)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: redColor.withOpacity(0.8)),
              ),
              // labelText: labelText,
              labelStyle: const TextStyle(fontSize: 18.0, color: Color(0xFF8C8C8C), fontWeight: FontWeight.w600),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 18.0, color: Color(0xFFBDBDBD), fontWeight: FontWeight.w400),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}