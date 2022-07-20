import 'package:flutter/material.dart';

class ExpandedText extends StatefulWidget {
  static const String id = "expandedText";

  final String text;

  const ExpandedText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText>{


  @override
  void initState() {
    super.initState();
  
  }

 
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      child: Text(widget.text),
    );
    }}