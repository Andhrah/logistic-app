import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/merchant/active_Container.dart';
import 'package:trakk/screens/merchant/all_vehicle_container.dart';
import 'package:trakk/screens/merchant/merchant_rider_profile.dart';
import 'package:trakk/screens/merchant/inactive_vehicle.dart';
import 'package:trakk/screens/merchant/rider_list_container.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';

import '../../provider/merchant/vehicles_provider.dart';
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

    Map<String, dynamic>? responseHolder ;
  dynamic? itemCount;
  Map<String, dynamic>? responseKey;

  @override
  void initState() {
    // fetchVehicleList().whenComplete((){
    //       setState(() {});
    //    });
    //  fetchVehicleList();
    
    super.initState();
  }

  fetchVehicleList() async {
     var box = await Hive.openBox('riderData');
    var response =
        await VehiclesProvider.vehiclesProvider(context).getVehiclesList();
    print("responseData=> ${response["data"][0]["attributes"]}");
    print("))))))overdose=> ${response["meta"]["pagination"]["total"]}");

    responseHolder = await response["data"][0]["attributes"];

    itemCount = response["meta"]["pagination"]["total"];
  }

  // fetchVehicleList() async {
  //   var response = await VehiclesProvider.vehiclesProvider(context)
  //       .getVehiclesList();
  //   print(
  //       "responseData=> ${response}");

  //   // responseHolder =
  //   //     response["data"]["attributes"]["orders"]["data"][0]["attributes"];
  // }

  var vehicles = [
    "All vehicles",
    "Search",
  ];

  String _listOfVehicles = 'All vehicles';

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
          physics: ScrollPhysics(),
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
                              8.0), //border raiuds of dropdown button
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(8),
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
                                // if (newValue.contains("All vahicles")) {
                                //   showAll = showAll;
                                //   isActive = false;
                                // } else if (newValue
                                //     .contains("Active vehicles")) {
                                //   isActive = true;
                                //   showAll = false;
                                // } else if (newValue
                                //     .contains("Inactive vehicles")) {
                                //   isActive = false;
                                //   showAll = false;
                                // } else if (newValue.contains("search")) {
                                //   showAll = showAll;
                                //   isActive = false;
                                // }
                                isActive
                                    ? AllVehicleContainer()
                                    : InactiveContainer();
                              });

                              print(newValue);
                            },
                            items: vehicles.map((String value) {
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
                    _isButtonPress && _listOfVehicles == "All vehicles"
                        ? const Text(
                            " Choose vehicle",
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
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 24,
                        ),
                    itemCount: itemCount ?? 2,
                    itemBuilder: (BuildContext context, int index) {
                      //return RiderListContainer();
                      // if (showAll) {
                      //   return AllVehicleContainer();
                      // } else if (isActive) {
                      //   return ActiveContainer();
                      // } else if (!isActive) {
                      //   return InactiveContainer();
                      // }
                      // //return AllVehicleContainer();
                      // return SizedBox();
                      return Container(
                        padding: const EdgeInsets.all(8),
                        height: 200,
                        decoration:
                            const BoxDecoration(color: whiteColor, boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 230, 230, 230),
                            spreadRadius: 2,
                            offset: Offset(2.0, 2.0), //(x,y)
                            blurRadius: 8.0,
                          ),
                        ]),
                        margin: EdgeInsets.only(left: 22, right: 22),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
                          child: Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                          height: 44,
                                          width: 44,
                                          decoration: const BoxDecoration(
                                              color: whiteColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 230, 230, 230),
                                                  spreadRadius: 1,
                                                  offset:
                                                      Offset(2.0, 2.0), //(x,y)
                                                  blurRadius: 8.0,
                                                ),
                                              ]),
                                          child: const Icon(
                                              Remix.delete_bin_5_line)),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset('assets/images/bike.png'),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          responseHolder?["name"]
                                                   ?? '',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          
                                             responseHolder?["number"]
                                                   ?? "",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Button(
                                    text: 'Assigned to',
                                    onPress: () {
                                      Navigator.of(context)
                                          .pushNamed(MerchantRiderProfile.id);
                                    },
                                    color: appPrimaryColor,
                                    width:
                                        MediaQuery.of(context).size.width / 1,
                                    textColor: whiteColor,
                                    isLoading: false)
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        )));
  }
}

class AllVehicleContainer extends StatelessWidget {
  static const String id = 'allvehiclecontainer';

  const AllVehicleContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 200,
      decoration: const BoxDecoration(color: whiteColor, boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 230, 230, 230),
          spreadRadius: 2,
          offset: Offset(2.0, 2.0), //(x,y)
          blurRadius: 8.0,
        ),
      ]),
      margin: EdgeInsets.only(left: 22, right: 22),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: 44,
                        width: 44,
                        decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 230, 230, 230),
                                spreadRadius: 1,
                                offset: Offset(2.0, 2.0), //(x,y)
                                blurRadius: 8.0,
                              ),
                            ]),
                        child: const Icon(Remix.delete_bin_5_line)),
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Vehicle no. ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
              Button(
                  text: 'All',
                  onPress: () {
                    Navigator.of(context).pushNamed(MerchantRiderProfile.id);
                  },
                  color: appPrimaryColor,
                  width: MediaQuery.of(context).size.width / 1,
                  textColor: whiteColor,
                  isLoading: false)
            ],
          ),
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
