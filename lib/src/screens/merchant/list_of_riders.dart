import 'dart:ui';

import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/merchant/get_riders_list_bloc.dart';
import 'package:trakk/src/models/merchant/get_riders_for_merchant_response.dart';
import 'package:trakk/src/screens/merchant/list_of_vehicles.dart';
import 'package:trakk/src/screens/merchant/merchant_rider_profile/merchant_rider_profile.dart';
import 'package:trakk/src/screens/merchant/rider_list_container.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/styles.dart';
import 'package:trakk/src/values/values.dart';

import '../../widgets/back_icon.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class ListOfRiders extends StatefulWidget {
  static const String id = 'ListOfRiders';

  const ListOfRiders({Key? key}) : super(key: key);

  @override
  State<ListOfRiders> createState() => _ListOfRidersState();
}

class _ListOfRidersState extends State<ListOfRiders> {
  final riders = [
    "All riders",
    // "Active riders (98)",
    // "Inactive riders (22)",
  ];

  late String _listOfRiders = riders.first;

  double _width = 160;
  final List<Item> _data = generateItems(1);

  @override
  void initState() {
    super.initState();

    getRidersForMerchantListBloc.fetchCurrent();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isFromAssignVehicle = false;

    if (ModalRoute.of(context)!.settings.arguments != null) {
      var arg =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      isFromAssignVehicle = arg[previousScreenTag] != null &&
          arg[previousScreenTag] == ListOfVehicles.id;
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            10.heightInPixel(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  isFromAssignVehicle ? 'CHOOSE RIDER' : 'LIST OF RIDERS',
                  style: theme.textTheme.subtitle2!.copyWith(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: kDefaultFontFamilyHeading
                      // decoration: TextDecoration.underline,
                      ),
                ),
                BackIcon(onPress: () {}, isPlaceHolder: true),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
              child: Column(
                children: [
                  const SizedBox(height: 5.0),
                  DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: appPrimaryColor.withOpacity(0.9),
                            width: 0.3), //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            5.0), //border raiuds of dropdown button
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: DropdownButton<String>(
                          value: _listOfRiders,
                          icon: const Icon(Remix.arrow_down_s_line),
                          elevation: 16,
                          isExpanded: true,
                          style: theme.textTheme.bodyText2!.copyWith(
                            color: appPrimaryColor.withOpacity(0.8),
                          ),
                          hint: Text(
                            'Choose rider',
                            style: theme.textTheme.bodyText2,
                          ),
                          underline: Container(),
                          //empty line
                          onChanged: (String? newValue) {
                            setState(() {
                              _listOfRiders = newValue!;
                            });
                          },
                          items: riders.map((String value) {
                            return DropdownMenuItem(
                              onTap: () {},
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )),
                  const SizedBox(height: 5.0),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: CustomStreamBuilder<
                  List<GetRidersForMerchantResponseDatum>, String>(
                stream: getRidersForMerchantListBloc.behaviorSubject,
                dataBuilder: (context, data) {
                  return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 24,
                          ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              if (isFromAssignVehicle) {
                                Navigator.pop(
                                    context, data.elementAt(index).toJson());
                              } else {
                                Navigator.of(context).pushNamed(
                                    MerchantRiderProfile.id,
                                    arguments: {
                                      'rider_datum':
                                          data.elementAt(index).toJson()
                                    });
                              }
                            },
                            child: RiderListContainer(data.elementAt(index)));
                      });
                },
                loadingBuilder: (context) => const Center(
                  child: kCircularProgressIndicator,
                ),
                errorBuilder: (context, err) => Center(
                    child: Text(
                  err,
                  style: theme.textTheme.bodyText2,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
