import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/merchant/active_Container.dart';
import 'package:trakk/screens/merchant/all_vehicle_container.dart';
import 'package:trakk/screens/merchant/inactive_vehicle.dart';
import 'package:trakk/screens/merchant/rider_list_container.dart';
import 'package:trakk/utils/colors.dart';
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

class ListOfVehicles extends StatefulWidget {
  static const String id = 'listofvehicles';

  const ListOfVehicles({Key? key}) : super(key: key);

  @override
  State<ListOfVehicles> createState() => _ListOfVehiclesState();
}

class _ListOfVehiclesState extends State<ListOfVehicles> {
  bool _isButtonPress = false;

  var vehicles = [
    "All vehicles (120)",
    "Active vehicles (98)",
    "Inactive vehicles (22)",
    "Search",
  ];

  String _listOfVehicles = 'All vehicles (120)';

  double _width = 160;
  final List<Item> _data = generateItems(1);
  bool isActive = false;
  bool showAll = true;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
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
                      'LIST OF VEHICLES',
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
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
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: DropdownButton<String>(
                            value: _listOfVehicles,
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
                                _listOfVehicles = newValue!;
                              });
                            },
                            items: vehicles.map((String value) {
                              return DropdownMenuItem(onTap: () {
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
                    _isButtonPress && _listOfVehicles == "All vehicles (120)"
                        ? const Text(
                            " Choose vehicle",
                            textScaleFactor: 0.9,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )
                        : Container(),

                    // ExpansionPanelList(
                    //   //title: Text('vehicle'),
                    //   expansionCallback: (int index, bool isExpanded) {
                    //     setState(() {
                    //       _data[index].isExpanded = !isExpanded;
                    //     });
                    //   },
                    //   children: _data.map<ExpansionPanel>((Item item) {
                    //     return ExpansionPanel(
                    //       headerBuilder:
                    //           (BuildContext context, bool isExpanded) {
                    //         return Align(
                    //             alignment: Alignment.centerLeft,
                    //             child: Padding(
                    //               padding: EdgeInsets.all(12.0),
                    //               child: InkWell(
                    //                   onTap: () {
                    //                     setState(() {
                    //                       showAll = showAll;
                    //                       isActive = false;
                    //                     });
                    //                   },
                    //                   child: const Text('All vehicle (20)')),
                    //             ));
                    //         // return ListTile(
                    //         //   title: Text(item.headerValue),
                    //         // );
                    //       },
                    //       body: ListView(
                    //           //scrollDirection: Axis.vertical,
                    //           shrinkWrap: true,
                    //           padding: EdgeInsets.all(12),
                    //           children: [
                    //             InkWell(
                    //                 onTap: () {
                    //                   setState(() {
                    //                     isActive = true;
                    //                     showAll = false;
                    //                   });
                    //                 },
                    //                 child: Text('Active vehicle (20)')),
                    //             SizedBox(
                    //               height: 10,
                    //             ),
                    //             InkWell(
                    //                 onTap: () {
                    //                   setState(() {
                    //                     isActive = false;
                    //                     showAll = false;
                    //                   });
                    //                 },
                    //                 child: Text('Inactive vehicle (22)')),
                    //             Padding(
                    //               padding: const EdgeInsets.symmetric(
                    //                   horizontal: 8, vertical: 16),
                    //               child: TextFormField(
                    //                 decoration: const InputDecoration(
                    //                   border: UnderlineInputBorder(),
                    //                   labelText: 'Enter your username',
                    //                 ),
                    //               ),
                    //             ),
                    //           ]),
                    //       isExpanded: item.isExpanded,
                    //     );
                    //   }).toList(),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: mediaQuery.size.height,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 24,
                        ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      //return RiderListContainer();
                      if (showAll) {
                        return AllVehicleContainer();
                      } else if (isActive) {
                        return ActiveContainer();
                      } else if (!isActive) {
                        return InactiveContainer();
                      }
                      //return AllVehicleContainer();
                      return SizedBox();
                      //return isActive ? ActiveContainer() : InactiveContainer();
                    }),
              )
            ],
          ),
        )));
  }
}
