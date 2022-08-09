import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/colors.dart';
import 'package:trakk/src/widgets/button.dart';

class DeliveryCodeWidget extends StatefulWidget {
  final String title;

  final String positiveLabel;
  final Function(String value) onPositiveCallback;
  final String negativeLabel;
  final Function() onNegativeCallback;

  const DeliveryCodeWidget(this.title, this.positiveLabel,
      this.onPositiveCallback, this.negativeLabel, this.onNegativeCallback,
      {Key? key})
      : super(key: key);

  @override
  State<DeliveryCodeWidget> createState() => _DeliveryCodeWidgetState();
}

class _DeliveryCodeWidgetState extends State<DeliveryCodeWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Container(
        margin: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
        constraints: const BoxConstraints(maxWidth: 450),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 54),
        decoration: const BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50), topLeft: Radius.circular(50))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.title.isNotEmpty) 24.heightInPixel(),
            if (widget.title.isNotEmpty)
              Center(
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(),
                ),
              ),
            if (widget.title.isNotEmpty) 24.heightInPixel(),
            Column(
              children: [
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'Code',
                    labelStyle: const TextStyle(
                        fontSize: 18.0, color: Color(0xFFCDCDCD)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: darkerPurple.withOpacity(0.3), width: 0.0),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Button(
                      text: widget.positiveLabel,
                      fontSize: 12,
                      onPress: () {
                        widget.onPositiveCallback(_controller.text);
                      },
                      borderRadius: 12,
                      color: kTextColor,
                      width: double.infinity,
                      textColor: whiteColor,
                      isLoading: false),
                ),
                20.widthInPixel(),
                Expanded(
                  child: Button(
                      text: widget.negativeLabel,
                      fontSize: 12,
                      onPress: () {
                        widget.onNegativeCallback();
                      },
                      borderRadius: 12,
                      color: redColor,
                      width: double.infinity,
                      textColor: whiteColor,
                      isLoading: false),
                ),
              ],
            ),
          ],
        ));
  }
}
