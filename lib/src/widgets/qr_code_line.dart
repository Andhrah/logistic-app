import 'package:flutter/material.dart';

class QrLineContainer extends StatelessWidget {
  final String title;

  const QrLineContainer({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 344,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.solid),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
      ),
    );
  }
}
