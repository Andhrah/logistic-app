import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/helper_utils.dart';
import 'package:trakk/widgets/input_field.dart';

class ItemDetailDateWidget extends StatefulWidget {
  final Function(String? pickup, String? dropOff) onDateSelected;

  const ItemDetailDateWidget(this.onDateSelected, {Key? key}) : super(key: key);

  @override
  _ItemDetailDateWidgetState createState() => _ItemDetailDateWidgetState();
}

class _ItemDetailDateWidgetState extends State<ItemDetailDateWidget> {
  final TextEditingController _pickUpDateController = TextEditingController();
  final TextEditingController _dropOffDateController = TextEditingController();

  final FocusNode _pickUpDateNode = FocusNode();
  final FocusNode _dropOffDateNode = FocusNode();

  String? _pickupDate;
  String? _dropOffDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pickUpDateController.dispose();
    _dropOffDateController.dispose();
    _pickUpDateNode.dispose();
    _dropOffDateNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime.now().add(const Duration(days: 36500)),
                  theme: const DatePickerTheme(
                    headerColor: appPrimaryColor,
                    backgroundColor: whiteColor,
                    itemStyle: TextStyle(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    doneStyle: TextStyle(
                      color: secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    cancelStyle: TextStyle(
                      color: secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ), onChanged: (date) {
                print('change $date in time zone ' +
                    date.timeZoneOffset.inHours.toString());
                print(date);
              }, onConfirm: (date) {
                _pickUpDateController.text =
                    getLongDate(dateValue: date.toIso8601String());

                _pickupDate = date.toIso8601String();

                widget.onDateSelected(_pickupDate, _dropOffDate);
                print('confirm $date');
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: InputField(
              obscureText: false,
              text: 'Pickup Date',
              hintText: '24/3/2022',
              textHeight: 5.0,
              node: _pickUpDateNode,
              enabled: false,
              textController: _pickUpDateController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              borderColor: appPrimaryColor.withOpacity(0.5),
              area: null,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  child: const Icon(
                    Remix.calendar_2_fill,
                    size: 18.0,
                    color: secondaryColor,
                  ),
                ),
              ),
              validator: (value) {
                if (value!.trim().length > 6) {
                  return null;
                }
                return "Enter a valid date";
              },
              onSaved: (value) {
                return null;
              },
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: GestureDetector(
            onTap: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime.now().add(const Duration(days: 36500)),
                  theme: const DatePickerTheme(
                    headerColor: appPrimaryColor,
                    backgroundColor: whiteColor,
                    itemStyle: TextStyle(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    doneStyle: TextStyle(
                      color: secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    cancelStyle: TextStyle(
                      color: secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ), onChanged: (date) {
                print('change $date in time zone ' +
                    date.timeZoneOffset.inHours.toString());
              }, onConfirm: (date) {
                print('confirm $date');
                _dropOffDateController.text =
                    getLongDate(dateValue: date.toString());

                _dropOffDate = date.toIso8601String();
                widget.onDateSelected(_pickupDate, _dropOffDate);
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: InputField(
              obscureText: false,
              text: 'Dropoff Date',
              hintText: '26/3/2022',
              textHeight: 5.0,
              enabled: false,
              node: _dropOffDateNode,
              textController: _dropOffDateController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              borderColor: appPrimaryColor.withOpacity(0.5),
              area: null,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  child: const Icon(
                    Remix.calendar_2_fill,
                    size: 18.0,
                    color: secondaryColor,
                  ),
                ),
              ),
              validator: (value) {
                if (value!.trim().length > 6) {
                  return null;
                }
                return "Enter a valid date";
              },
              onSaved: (value) {
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
