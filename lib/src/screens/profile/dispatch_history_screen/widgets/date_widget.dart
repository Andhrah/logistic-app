import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:trakk/src/bloc/rider/rider_order_history_bloc.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/utils/helper_utils.dart';

class DateDispatchHistory extends StatefulWidget {
  String startDate;
  String endDate;

  DateDispatchHistory(
      {Key? key, required this.startDate, required this.endDate})
      : super(key: key);

  @override
  State<DateDispatchHistory> createState() => _UserDispatcHistoryState();
}

class _UserDispatcHistoryState extends State<DateDispatchHistory> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 14,
        ),
        Text(
          'Select Date',
          style: theme.textTheme.subtitle2,
        ),
        const SizedBox(
          height: 5,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectDate(
                        onSelected: (String date) {
                          setState(() => widget.startDate = date);
                        },
                        previousValue: widget.startDate);
                  },
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(color: grayColor)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getLongDate(dateValue: widget.startDate), textScaleFactor: 1,
                            style: theme.textTheme.bodyText2!.copyWith(
                                //fontSize: 16, 
                                fontWeight: FontWeight.w400),
                          ),
                          Icon(
                            Icons.calendar_month,
                            size: 14,
                            color: theme.textTheme.bodyText2!.color,
                          )
                        ]),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text("To"),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectDate(
                        isStart: false,
                        onSelected: (String date) {
                          setState(() => widget.endDate = date);
                        },
                        previousValue: widget.endDate);
                  },
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(color: grayColor)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getLongDate(dateValue: widget.endDate), textScaleFactor: 1,
                            style: theme.textTheme.bodyText2!.copyWith(
                                fontWeight: FontWeight.w400),
                          ),
                          Icon(
                            Icons.calendar_month,
                            size: 14,
                            color: theme.textTheme.bodyText2!.color,
                          )
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  _selectDate(
      {bool isStart = true,
      Function(String date)? onSelected,
      required String previousValue}) {
    var minTime = isStart
        ? DateTime.now().subtract(const Duration(days: (365 * 100) + 1))
        : DateTime.now().subtract(const Duration(days: (365 * 100)));
    var maxTime = isStart
        ? DateTime.now().subtract(const Duration(days: 1))
        : DateTime.now();
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: minTime,
        maxTime: maxTime,
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
        ),
        onChanged: (date) {}, onConfirm: (date) {
      if (onSelected != null) {
        onSelected(date.toIso8601String());
      }

      if (DateTime.parse(widget.startDate)
          .isAfter(DateTime.parse(widget.endDate))) {
        if (onSelected != null) {
          onSelected(previousValue);
        }
        appToast('End date must be greater than start date',
            appToastType: AppToastType.failed);
        return;
      }

      getRiderOrderHistoryBloc.fetchCurrent(widget.startDate, widget.endDate);
    }, currentTime: maxTime, locale: LocaleType.en);
  }
}
