import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.textController,
    required FocusNode node,
  }) : _node = node, super(key: key);

  final TextEditingController textController;
  final FocusNode _node;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: textController,
          focusNode: _node,
        )
      ],
    );
  }
}