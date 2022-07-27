/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/validation_bloc.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/input_field.dart';

typedef SearchableListCallback = Function(int index, String value);

class SearchableListModal extends StatefulWidget {
  final SearchableListCallback searchableListCallback;
  final List<String> _list;
  final String title;
  final bool isSearchable;

  const SearchableListModal(
      this._list, this.searchableListCallback, this.isSearchable, this.title,
      {Key? key})
      : super(key: key);

  @override
  State<SearchableListModal> createState() => _SearchableListModalState();
}

class _SearchableListModalState extends State<SearchableListModal> {
  TextEditingController textEditingController = TextEditingController();

  final formValidator = ValidationBloc();

  List<String> _freqList = [];

  @override
  void initState() {
    super.initState();
    _freqList = widget._list;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    formValidator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    MediaQueryData mediaQuery;
    mediaQuery = MediaQuery.of(context);

    var shortestSide = mediaQuery.size.shortestSide;
// Determine if we should use mobile layout or not. The
// number 600 here is a common breakpoint for a typical
// 7-inch tablet.
    final bool useMobileLayout = shortestSide < 600;

    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
              color: isDark ? kDarkThemeBackgroundColor : kBackgroundColor,
              borderRadius: Radii.k20TopSymmetricRadius),
          child: Container(
            decoration: BoxDecoration(
                color: isDark ? kDarkThemeBackgroundColor : kBackgroundColor,
                borderRadius: Radii.k20TopSymmetricRadius),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SafeArea(
                  child: 10.heightInPixel(),
                ),
                Text(
                  widget.title,
                  style: theme.textTheme.subtitle1!.copyWith(
                    fontWeight: kBoldWeight,
                  ),
                ),
                24.heightInPixel(),
                if (widget.isSearchable)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultLayoutPadding),
                    child: InputField(
                      textController: textEditingController,
                      validator: formValidator.singleInputValidator,
                      labelText: null,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: appPrimaryColor,
                      ),
                      hintText: 'Enter keyword',
                      keyboardType: TextInputType.text,
                      onChanged: (String? value) {
                        setState(() => _freqList = widget._list
                            .where((element) => element
                                .toLowerCase()
                                .contains(value!.toLowerCase()))
                            .toList());
                      },
                      textHeight: 5,
                      text: 'Search',
                    ),
                  ),
                if (widget.isSearchable)
                  SizedBox(
                    height: 10,
                  ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _freqList.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        close(context);
                        widget.searchableListCallback(
                            index, _freqList.elementAt(index));
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            _freqList.elementAt(index),
                            style: theme.textTheme.subtitle2!.copyWith(
                              fontWeight: kSemiBoldWeight,
                            ),
                          )),
                    ),
                    separatorBuilder: (context, index) => const Divider(
                      color: appPrimaryColor,
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  close(context) {
    Navigator.pop(context);
  }
}
