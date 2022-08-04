import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/merchant/get_vehicles_for_merchant_list_bloc.dart';
import 'package:trakk/src/mixins/merchant_update_rider_and_vehicle_helper.dart';
import 'package:trakk/src/mixins/profile_helper.dart';
import 'package:trakk/src/models/merchant/get_riders_for_merchant_response.dart';
import 'package:trakk/src/models/merchant/get_vehicles_for_merchant_response.dart';
import 'package:trakk/src/models/rider/add_vehicle_to_merchant_model.dart';
import 'package:trakk/src/screens/merchant/inactive_vehicle.dart';
import 'package:trakk/src/screens/merchant/list_of_riders.dart';
import 'package:trakk/src/screens/merchant/merchant_rider_profile/merchant_rider_profile.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/button.dart';
import 'package:trakk/src/widgets/general_widget.dart';

import '../../widgets/back_icon.dart';
import '../../widgets/cancel_button.dart';
import 'company_home.dart';

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
  static const String id = 'listOfVehicles';

  const ListOfVehicles({Key? key}) : super(key: key);

  @override
  State<ListOfVehicles> createState() => _ListOfVehiclesState();
}

class _ListOfVehiclesState extends State<ListOfVehicles>
    with MerchantUpdateRiderAndVehicleHelper, ProfileHelper {
  bool _isButtonPress = false;

  dynamic itemCount;
  dynamic responseKey;
  dynamic responseId;

  String filter = 'Assigned';

  List<String> filters = ['Assigned', 'Unassigned'];

  @override
  void initState() {
    filter = filters.first;
    getVehiclesForMerchantListBloc.fetchCurrent(filter == 'Unassigned');
    fetchVehicleList().whenComplete(() {
      setState(() {});
    });
    fetchVehicleList();

    super.initState();
  }

  fetchVehicleList() async {}

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
    var theme = Theme.of(context);

    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
            child: Column(children: [
          const SizedBox(height: 10.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 75,
                  child: Row(
                    children: [
                      BackIcon(
                        padding: EdgeInsets.zero,
                        onPress: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                Text(
                  'LIST OF VEHICLES',
                  style: theme.textTheme.subtitle2!.copyWith(
                    color: appPrimaryColor, fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 75,
                  child: DropdownButton<String>(
                    value: filter,
                    icon: const Icon(
                      Icons.filter_alt,
                      size: 18,
                    ),
                    elevation: 16,
                    isExpanded: true,
                    style: TextStyle(
                      color: appPrimaryColor.withOpacity(0.8),
                      fontSize: 18.0,
                    ),
                    underline: Container(),
                    items: filters
                        .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: theme.textTheme.caption!.copyWith(
                                  color: appPrimaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  // decoration: TextDecoration.underline,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        filter = value ?? filters.first;
                      });

                      getVehiclesForMerchantListBloc
                          .fetchCurrent(filter == 'Unassigned');
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultLayoutPadding, vertical: 12),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: appPrimaryColor.withOpacity(0.9),
                        width: 0.3), //border of dropdown button
                    borderRadius: BorderRadius.circular(
                        8.0), //border raiuds of dropdown button
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultLayoutPadding),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(8),
                      value: _listOfVehicles,
                      icon: const Icon(Remix.arrow_down_s_line),
                      elevation: 16,
                      isExpanded: true,
                      style: theme.textTheme.bodyText2!.copyWith(
                        color: appPrimaryColor.withOpacity(0.8),
                      ),
                      underline: Container(),
                      //empty line
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
                              ? const AllVehicleContainer()
                              : const InactiveContainer();
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
                  ),
                ),
              ),
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
              Expanded(
                child: CustomStreamBuilder<List<GetVehiclesForMerchantDatum>,
                    String>(
                  stream: getVehiclesForMerchantListBloc.behaviorSubject,
                  dataBuilder: (context, data) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
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

                          String id = '${data.elementAt(index).id ?? ''}';
                          String avatar =
                              data.elementAt(index).attributes?.image ?? '';
                          String name =
                              data.elementAt(index).attributes?.name ?? '';
                          String number =
                              data.elementAt(index).attributes?.number ?? '';

                          bool isAssigned = data
                                  .elementAt(index)
                                  .attributes
                                  ?.riderId
                                  ?.data
                                  ?.attributes !=
                              null;

                          return Container(
                            padding: const EdgeInsets.all(8),
                            height: 200,
                            decoration: const BoxDecoration(
                                color: whiteColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 230, 230, 230),
                                    spreadRadius: 2,
                                    offset: Offset(2.0, 2.0), //(x,y)
                                    blurRadius: 8.0,
                                  ),
                                ]),
                            margin: const EdgeInsets.only(
                                left: 22, right: 22, bottom: 7, top: 7),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () => showDialog<String>(
                                          // barrierDismissible: true,
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            // title: const Text('AlertDialog Title'),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20.0,
                                                    vertical: 15.0),
                                            content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const CancelButton())
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  SizedBox(
                                                    width: 300,
                                                    child: Text(
                                                      'You are about to remove ${name}\nVeh.No. 889 from the list of \nvehicles',
                                                      // maxLines: 2,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 14,
                                                  ),
                                                  Button(
                                                    text: 'Delete',
                                                    onPress: () {
                                                      Navigator.pop(context);
                                                      doDeleteVehicle(id,
                                                          onSuccessful: () {
                                                        showDialog<String>(
                                                          // barrierDismissible: true,
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            // title: const Text('AlertDialog Title'),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20.0,
                                                                    vertical:
                                                                        15.0),
                                                            content: SizedBox(
                                                              height: 220.0,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pushNamed(CompanyHome.id);
                                                                        },
                                                                        child:
                                                                            const CancelButton(),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            30),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Center(
                                                                          child:
                                                                              Text(
                                                                            '  You have successfully removed\n${name} Veh.No${number} from the list \nof riders',
                                                                            // maxLines: 2,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                10),
                                                                        const Icon(
                                                                            Remix.delete_bin_6_line),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    color: redColor,
                                                    textColor: whiteColor,
                                                    isLoading: false,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                  ),
                                                  20.heightInPixel(),
                                                  Button(
                                                    text: 'Don\'t delete',
                                                    onPress: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    color: appPrimaryColor,
                                                    textColor: whiteColor,
                                                    isLoading: false,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.6,
                                                  )
                                                ]),
                                          ),
                                        ),
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
                                                    offset: Offset(2.0, 2.0),
                                                    //(x,y)
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
                                      CachedNetworkImage(
                                        imageUrl: avatar,
                                        width: 80,
                                        height: 80,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                          Assets.ride,
                                          width: 80,
                                          height: 80,
                                        ),
                                        errorWidget: (context, url, err) =>
                                            Image.asset(
                                          Assets.ride,
                                          width: 80,
                                          height: 80,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            number,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Button(
                                      text: isAssigned
                                          ? 'Assigned to ${data.elementAt(index).attributes?.riderId?.data?.attributes?.userId?.data?.attributes?.firstName ?? ''} ${data.elementAt(index).attributes?.riderId?.data?.attributes?.userId?.data?.attributes?.lastName ?? ''}'
                                          : 'Assign to',
                                      onPress: () async {
                                        if (isAssigned) {
                                          VehicleRequest vehicleModel =
                                              VehicleRequest(
                                                  data: AddRiderToMerchantData(
                                                      riderId: ''));

                                          yesNoDialog(context,
                                              title:
                                                  'Remove vehicle from ${data.elementAt(index).attributes?.riderId?.data?.attributes?.userId?.data?.attributes?.firstName ?? ''} ${data.elementAt(index).attributes?.riderId?.data?.attributes?.userId?.data?.attributes?.lastName ?? ''}',
                                              positiveCallback: () {
                                                Navigator.pop(context);
                                                updateVehicle(id, vehicleModel);
                                              },
                                              negativeCallback: () =>
                                                  Navigator.pop(context));
                                        } else {
                                          var result =
                                              await Navigator.of(context)
                                                  .pushNamed(ListOfRiders.id,
                                                      arguments: {
                                                previousScreenTag:
                                                    ListOfVehicles.id
                                              });
                                          if (result != null &&
                                              result is Map<String, dynamic>) {
                                            GetRidersForMerchantResponseDatum
                                                datum =
                                                GetRidersForMerchantResponseDatum
                                                    .fromJson(result);

                                            //  do add vehicle to merchant

                                            VehicleRequest vehicleModel =
                                                VehicleRequest(
                                                    data: AddRiderToMerchantData(
                                                        riderId:
                                                            '${datum.id ?? ''}'));
                                            updateVehicle(id, vehicleModel);
                                          }
                                        }
                                      },
                                      color: appPrimaryColor,
                                      width:
                                          MediaQuery.of(context).size.width / 1,
                                      textColor: whiteColor,
                                      isLoading: false)
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  loadingBuilder: (context) => const Center(
                    child: kCircularProgressIndicator,
                  ),
                  errorBuilder: (context, err) => Center(
                    child: Text(err),
                  ),
                ),
              ),
            ],
          ))
        ])));
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
      padding: const EdgeInsets.all(8),
      height: 200,
      decoration: const BoxDecoration(color: whiteColor, boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 230, 230, 230),
          spreadRadius: 2,
          offset: Offset(2.0, 2.0), //(x,y)
          blurRadius: 8.0,
        ),
      ]),
      margin: const EdgeInsets.only(left: 22, right: 22),
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
      margin: const EdgeInsets.only(left: 22, right: 22),
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
