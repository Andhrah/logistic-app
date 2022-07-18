import 'dart:ui';

import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/bloc/merchant/get_riders_list_bloc.dart';
import 'package:trakk/models/merchant/get_riders_for_merchant_response.dart';
import 'package:trakk/screens/merchant/inactive_vehicle.dart';
import 'package:trakk/screens/merchant/merchant_rider_profile.dart';
import 'package:trakk/screens/merchant/rider_list_container.dart';
import 'package:trakk/screens/merchant/rider_profile.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/utils/styles.dart';
import 'package:trakk/widgets/button.dart';

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
  static const String id = 'listofriders';

  const ListOfRiders({Key? key}) : super(key: key);

  @override
  State<ListOfRiders> createState() => _ListOfRidersState();
}

class _ListOfRidersState extends State<ListOfRiders> {
  bool _isButtonPress = false;

  var riders = [
    "All riders (120)",
    "Active riders (98)",
    "Inactive riders (22)",
  ];

  String _listOfRiders = 'All riders (120)';

  double _width = 160;
  final List<Item> _data = generateItems(1);
  bool isActive = false;
  bool showAll = true;

  @override
  void initState() {
    super.initState();

    getRidersListBloc.fetchCurrent();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: ListView(
          physics: ScrollPhysics(),
          children: [
            const SizedBox(height: 10.0),
            Row(
              children: [
                BackIcon(
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 40.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'LIST OF RIDERS',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
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
                          style: TextStyle(
                            color: appPrimaryColor.withOpacity(0.8),
                            fontSize: 18.0,
                          ),
                          underline: Container(), //empty line
                          onChanged: (String? newValue) {
                            setState(() {
                              _listOfRiders = newValue!;
                              if (newValue.contains("All riders")) {
                                showAll = showAll;
                                isActive = false;
                              } else if (newValue.contains("Active riders")) {
                                isActive = true;
                                showAll = false;
                              } else if (newValue.contains("Inactive riders")) {
                                isActive = false;
                                showAll = false;
                              }
                            });
                          },
                          items: riders.map((String value) {
                            return DropdownMenuItem(
                              onTap: () {
                                setState(() {
                                  showAll = showAll;
                                  isActive = false;
                                });
                              },
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )),
                  const SizedBox(height: 5.0),
                  _isButtonPress && _listOfRiders == "All riders (120)"
                      ? const Text(
                          " Choose rider",
                          textScaleFactor: 0.9,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: mediaQuery.size.height,
              child: CustomStreamBuilder<
                  List<GetRidersForMerchantResponseDatum>, String>(
                stream: getRidersListBloc.behaviorSubject,
                dataBuilder: (context, data) {
                  return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 24,
                          ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        //return RiderListContainer();
                        if (showAll) {
                          return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(RiderProfile.id, arguments: {
                                  'rider_datum':
                                      data.elementAt(index).attributes!.toJson()
                                });
                              },
                              child: RiderListContainer(data.elementAt(index)));
                        } else if (isActive) {
                          return ActiveContainer();
                        } else if (!isActive) {
                          return InactiveContainer();
                        }
                        //return AllVehicleContainer();
                        return SizedBox();
                        //return isActive ? ActiveContainer() : InactiveContainer();
                      });
                },
                loadingBuilder: (context) => const Center(
                  child: kCircularProgressIndicator,
                ),
                errorBuilder: (context, err) => Center(child: Text(err)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ActiveContainer extends StatelessWidget {
  const ActiveContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(color: whiteColor, boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 230, 230, 230),
          spreadRadius: 1,
          offset: Offset(2.0, 2.0), //(x,y)
          blurRadius: 8.0,
        ),
      ]),
      margin: EdgeInsets.only(left: 22, right: 22),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  'assets/images/cancel.svg',
                  color: Colors.black,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/bike.png'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Suzuki',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Vehicle no. 887',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            ),
            Button(
                text: 'Assigned to Malik Johnson',
                onPress: () {
                  Navigator.of(context).pushNamed(MerchantRiderProfile.id);
                },
                color: appPrimaryColor,
                width: 290,
                textColor: whiteColor,
                isLoading: false)
          ],
        ),
      ),
    );
  }
}
