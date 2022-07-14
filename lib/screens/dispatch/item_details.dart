import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/bloc/app_settings_bloc.dart';
import 'package:trakk/models/app_settings.dart';
import 'package:trakk/models/order/order.dart';
import 'package:trakk/provider/order/order.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/header.dart';
import 'package:trakk/widgets/input_field.dart';

class ItemDetails extends StatefulWidget {
  static const String id = 'itemDetails';

  const ItemDetails({Key? key}) : super(key: key);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.

class _ItemDetailsState extends State<ItemDetails>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _pickUpController;
  late TextEditingController _dropOffController;
  late TextEditingController _itemController;
  late TextEditingController _itemDescriptionController;
  TextEditingController? _receiverNameController;
  late TextEditingController _senderNameController;
  late TextEditingController _receiverPhoneNumberController;
  late TextEditingController _senderPhoneNumberController;
  late TextEditingController _pickUpDateController;
  late TextEditingController _dropOffDateController;

  late AnimationController controller;
  late Animation<Color?> animation;

  FocusNode? _pickUpNode;
  FocusNode? _dropOffNode;
  FocusNode? _receiverNameNode;
  FocusNode? _senderNameNode;
  FocusNode? _receiverphoneNumberNode;
  FocusNode? _senderphoneNumberNode;
  FocusNode? _itemNode;
  FocusNode? _itemDescriptionNode;
  FocusNode? _pickUpDateNode;
  FocusNode? _dropOffDateNode;

  String? _receiverName;
  String? _receiverPhoneNumber;
  String? _item;
  String? _itemDescription;
  String _itemImage = "";
  String? _pickUpDate;
  String? _dropOffDate;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  Timer? _debounce;

  String? _pickUp;
  String? _dropOff;

  bool _isItemImage = false;
  String _pickItem = "Food";
  var itemsCategory = ["Food", "Cloth", "Electronics", "others (specify)"];

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  _getPreviousRoute() async {
    // setState(() {
    //   _previousRoute = box.get('previousRoute');
    // });
  }

  @override
  void initState() {
    super.initState();

    String apiKey = "AIzaSyBvxkb0Gv6kwpiplPtmeQZhG4_V-KvLZ1U";
    googlePlace = GooglePlace(apiKey);

    _pickUpController = TextEditingController();
    _dropOffController = TextEditingController();
    _itemController = TextEditingController();
    _itemDescriptionController = TextEditingController();
    _receiverNameController = TextEditingController();
    _senderNameController = TextEditingController();
    _receiverPhoneNumberController = TextEditingController();
    _senderPhoneNumberController = TextEditingController();
    _pickUpDateController = TextEditingController();
    _dropOffDateController = TextEditingController();

    _pickUpNode = FocusNode();
    _dropOffNode = FocusNode();
    _itemNode = FocusNode();
    _itemDescriptionNode = FocusNode();
    _pickUpDateNode = FocusNode();
    _dropOffDateNode = FocusNode();
    _receiverNameNode = FocusNode();
    _senderNameNode = FocusNode();
    _receiverphoneNumberNode = FocusNode();
    _senderphoneNumberNode = FocusNode();

    _getPreviousRoute();

    controller = AnimationController(
      vsync: this, // the TickerProviderStateMixin
      duration: const Duration(seconds: 5),
    );

    // animation = controller.drive(
    //   ColorTween(
    //     begin: appPrimaryColor,
    //     end: secondaryColor,
    //   )
    // );

    animation = ColorTween(begin: appPrimaryColor, end: secondaryColor)
        .animate(controller);
    controller.repeat();
    // controller.addListener(() {
    //   setState(() {});
    // });

    // controller.forward();

    // controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed){
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _debounce?.cancel();
    controller.dispose();
    _pickUpNode!.dispose();
    _dropOffNode!.dispose();
  }

  uploadItemImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // Open single file open
      final file = result.files.first;
      print("Image Name: ${file.name}");
      setState(() {
        _itemImage = file.name;
        _isItemImage = true;
      });
      return;
    }
  }

  _parseDate(value) {
    var date = DateTime.parse(value);
    var formattedDate = "${date.day}-${date.month}-${date.year}";
    return formattedDate;

    // print(formattedDate);
  }

  /*
   * This method handles the onsubmit event annd validates users input. It triggers validation and sends data to the API
  */
  _onAddItemPress(BuildContext cxt) async {
    final FormState? form = _formKey.currentState;
    // print(_itemDescription);
    // Order _orderProvider = Provider.of<Order>(cxt, listen: false);
    // _orderProvider.setOrder(OrderModel(
    //     pickUpLocation: OrderLocation(
    //       address: _pickUp.toString(),
    //       latitude: 19,
    //       longitude: 10,
    //       isPickUp: false,
    //       isDelivery: false,
    //     ),
    //     deliveryLocation: OrderLocation(
    //       address: _pickUp.toString(),
    //       latitude: 19,
    //       longitude: 10,
    //       isPickUp: false,
    //       isDelivery: false,
    //     ),
    //     orderItem: OrderItem(
    //         orderItemTypeId: 1,
    //         description: _itemDescription,
    //         imageReference: _itemImage,
    //         weight: "none"),
    //     notes: "Hello"));
    if (form!.validate()) {
      form.save();

      print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&');
      print(_itemDescription);
      print(_pickUp.toString());
      print(_dropOff);
      Order _orderProvider = Provider.of<Order>(cxt, listen: false);
      _orderProvider.setOrder(OrderModel(
          pickUpLocation: OrderLocation(
            address: _pickUp.toString(),
            latitude: 19,
            longitude: 10,
            isPickUp: false,
            isDelivery: false,
          ),
          deliveryLocation: OrderLocation(
            address: _pickUp.toString(),
            latitude: 19,
            longitude: 10,
            isPickUp: false,
            isDelivery: false,
          ),
          orderItem: OrderItem(
              orderItemTypeId: 1,
              description: _itemDescription,
              imageReference: _itemImage,
              weight: "none"),
          notes: "Hello"));
      // var box = await Hive.openBox('userOrder');
      // box.putAll({
      //   "pickUp": _pickUp,
      //   "dropOff": _dropOff,
      //   "receiverName": _receiverName,
      //   "receiverPhoneNumber": _receiverPhoneNumber,
      //   "item": _item,
      //   "itemDescription": _itemDescription,
      //   "pickUpDate": _pickUpDate,
      //   "dropOffDate": _dropOffDate,
      //   "itemImage": _itemImage,
      // });
      // Navigator.of(context).pushNamed( NextOfKin.id);
    }
  }

  _saveEdittedItem() async {
    Navigator.pop(context);
  }

  _onButtonPress() async {
    // Navigator.of(context).pushNamed(PickRide.id);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TweenAnimationBuilder(
              //   tween: Tween(begin: const Duration(minutes: 2), end: Duration.zero),
              //   duration: const Duration(minutes: 3),
              //   builder: (BuildContext context, Duration value, Widget? child) {
              //     final minutes = value.inMinutes;
              //     final seconds = value.inSeconds % 60;
              //     return Container(
              //       height: 150.0,
              //       width: 150.0,
              //       decoration: const BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: appPrimaryColor,
              //       ),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Text(
              //             '$minutes:$seconds',
              //             textAlign: TextAlign.center,
              //             style: const TextStyle(
              //               color: secondaryColor,
              //               fontWeight: FontWeight.bold,
              //               fontSize: 30
              //             )
              //           )
              //         ],
              //       )
              //     );
              //   }
              // ),

              const SizedBox(height: 80.0),
              Container(
                  padding: const EdgeInsetsDirectional.only(top: 20.0),
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    // color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(children: [
                    const SizedBox(height: 20.0),
                    const Text(
                      'Searching for a rider',
                      style: TextStyle(
                        color: appPrimaryColor,
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    //   ListTile(
                    //   leading: Container(
                    //     height: 50.0,
                    //     width: 50.0,
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: Colors.grey.shade200
                    //     ),
                    //     child: const Icon(
                    //       Remix.user_3_fill,
                    //       size: 30.0,
                    //       color: appPrimaryColor,
                    //     ),
                    //   ),
                    //   title: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const Text(
                    //         'Order ID',
                    //         textScaleFactor: 1.2,
                    //         style: TextStyle(
                    //           color: appPrimaryColor,
                    //           fontWeight: FontWeight.bold
                    //         ),
                    //       ),

                    //       const SizedBox(height: 10.0),
                    //       Text(
                    //         '#234516',
                    //         textScaleFactor: 1.0,
                    //         style: TextStyle(
                    //           color: appPrimaryColor.withOpacity(0.5),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //   },
                    // ),
                    Divider(
                      color: appPrimaryColor.withOpacity(0.4),
                    ),

                    const SizedBox(height: 20.0),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Hold on while Trakk find you a rider",
                          style: TextStyle(color: appPrimaryColor),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30.0),

                    Stack(
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: CircularProgressIndicator(
                            // backgroundColor: Colors.pinkAccent,
                            strokeWidth: 5.0,
                            // value: 0.7,
                            valueColor: animation,
                            // valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ),
                        Positioned(
                            left: 25,
                            top: 20,
                            child: Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                  "assets/images/rider_vehicle.png",
                                  // height: 60,
                                  // width: 60,
                                ),
                              ),
                            ))
                      ],
                    ),

                    const SizedBox(height: 30.0),
                  ])),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            kSizeBox,
            const Header(
              text: 'DISPATCH ITEM',
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/empty_map.png"),
                fit: BoxFit.fill,
              )),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/order_highlighter2.png",
                          height: 100.0,
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            width: 280.0,
                            child: Column(
                              children: [
                                InputField(
                                  obscureText: false,
                                  text: '',
                                  hintText: 'Pick Up',
                                  node: _pickUpNode,
                                  textController: _pickUpController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textHeight: 0.0,
                                  borderColor: appPrimaryColor.withOpacity(0.5),
                                  validator: (value) {
                                    if (value!.trim().length > 2) {
                                      return null;
                                    }
                                    return "Enter a valid pick-up location";
                                  },
                                  // onSaved: (value) {
                                  //   _pickUp = value!.trim() as DetailsResult?;
                                  //   return null;
                                  // },
                                  onChanged: (value) {
                                    // cancel _debounce if its active and restart it if user type in something again
                                    if (_debounce?.isActive ?? false)
                                      _debounce!.cancel();
                                    // prevent the autoCompleteSearch from search on every little keypress
                                    _debounce = Timer(
                                        const Duration(milliseconds: 1000), () {
                                      if (value!.isNotEmpty) {
                                        // placces api
                                        autoCompleteSearch(value);
                                      } else {
                                        // clear out result
                                      }
                                    });
                                  },
                                ),
                                InputField(
                                  obscureText: false,
                                  text: '',
                                  hintText: 'Drop Off',
                                  node: _dropOffNode,
                                  textController: _dropOffController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textHeight: 0,
                                  borderColor: appPrimaryColor.withOpacity(0.5),
                                  validator: (value) {
                                    if (value!.trim().length > 2) {
                                      return null;
                                    }
                                    return "Enter a valid drop-off location";
                                  },
                                  // onSaved: (value) {
                                  //   _dropOff = value!.trim() as DetailsResult;
                                  //   return null;
                                  // },
                                  onChanged: (value) {
                                    // cancel _debounce if its active and restart it if user type in something again
                                    if (_debounce?.isActive ?? false)
                                      _debounce!.cancel();
                                    // prevent the autoCompleteSearch from search on every little keypress
                                    _debounce = Timer(
                                        const Duration(milliseconds: 500), () {
                                      if (value!.isNotEmpty) {
                                        // placces api
                                        autoCompleteSearch(value);
                                      } else {
                                        // clear out result
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: predictions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: appPrimaryColor,
                            child: Icon(
                              Remix.pin_distance_fill,
                              color: secondaryColor,
                            ),
                          ),
                          title:
                              Text(predictions[index].description.toString()),
                          onTap: () async {
                            final placeId = predictions[index].placeId!;
                            final details =
                                await googlePlace.details.get(placeId);
                            if (details != null &&
                                details.result != null &&
                                mounted) {
                              print("+++++++++++++++++++++++++++++");
                              print(details.result!.addressComponents);
                              if (_pickUpNode!.hasFocus) {
                                setState(() {
                                  _pickUp = details.result!.name!;
                                  print('******************************');
                                  print(_pickUp.runtimeType);
                                  _pickUpController.text =
                                      details.result!.name!;
                                  predictions = [];
                                });
                              } else {
                                setState(() {
                                  _dropOff = details.result!.name!;
                                  _dropOffController.text =
                                      details.result!.name!;
                                  predictions = [];
                                });
                              }
                            }
                          },
                        );
                      }),

                  // InputField(
                  //   obscureText: false,
                  //   text: '',
                  //   hintText: 'Item',
                  //   textHeight: 0,
                  //   node: _itemNode,
                  //   textController: _itemController,
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   borderColor: appPrimaryColor.withOpacity(0.5),
                  //   validator: (value) {
                  //     if (value!.trim().length > 2) {
                  //       return null;
                  //     }
                  //     return "Enter a valid item name";
                  //   },
                  //   onSaved: (value) {
                  //     _item = value!.trim();
                  //     return null;
                  //   },
                  //   suffixIcon: DropdownButton<String>(
                  //     // value: _pickItem,
                  //     hint: Text(
                  //       " choose category of item",
                  //       style: TextStyle(
                  //         color: appPrimaryColor.withOpacity(0.3)
                  //       ),
                  //     ),
                  //     icon: const Icon(Remix.arrow_down_s_line),
                  //     elevation: 16,
                  //     isExpanded: true,
                  //     style: TextStyle(
                  //       color: appPrimaryColor.withOpacity(0.8),
                  //       fontSize: 18.0,
                  //     ),
                  //     underline: Container(), //empty line
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         _pickItem = newValue!;
                  //       });
                  //     },
                  //     items: itemsCategory.map((String value) {
                  //       return DropdownMenuItem(
                  //         value: value,
                  //         child: Text(value),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),

                  DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: appPrimaryColor.withOpacity(0.5),
                            width: 0.3), //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            5.0), //border raiuds of dropdown button
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DropdownButton<String>(
                          value: _pickItem,
                          hint: Text(
                            "choose category of item",
                            style: TextStyle(
                                color: appPrimaryColor.withOpacity(0.3)),
                          ),
                          icon: const Icon(Remix.arrow_down_s_line),
                          elevation: 16,
                          isExpanded: true,
                          style: TextStyle(
                            color: appPrimaryColor.withOpacity(0.8),
                            fontSize: 18.0,
                          ),
                          underline: Container(),
                          //empty line
                          onChanged: (String? newValue) {
                            setState(() {
                              _pickItem = newValue!;
                            });
                          },
                          items: itemsCategory.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      )),

                  InputField(
                    obscureText: false,
                    text: '',
                    hintText: 'Item details',
                    textHeight: 0,
                    node: _itemDescriptionNode,
                    textController: _itemDescriptionController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    borderColor: appPrimaryColor.withOpacity(0.5),
                    area: null,
                    validator: (value) {
                      if (value!.trim().length > 1) {
                        return null;
                      }
                      return "Enter a valid item description";
                    },
                    onSaved: (value) {
                      _itemDescription = value!.trim();
                      return null;
                    },
                  ),

                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: InputField(
                          obscureText: false,
                          text: 'Pickup Date',
                          hintText: '24/3/2022',
                          textHeight: 5.0,
                          node: _pickUpDateNode,
                          textController: _pickUpDateController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          borderColor: appPrimaryColor.withOpacity(0.5),
                          area: null,
                          suffixIcon: IconButton(
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2022, 3, 5),
                                  maxTime: DateTime(2100, 6, 7),
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
                                print(_parseDate(date.toString()));
                              }, onConfirm: (date) {
                                _pickUpDateController.text =
                                    _parseDate(date.toString());
                                print('confirm $date');
                                print(_parseDate(date.toString()));
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            icon: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: secondaryColor.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50))),
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
                            _pickUpDate = value!.trim();
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: InputField(
                          obscureText: false,
                          text: 'Dropoff Date',
                          hintText: '26/3/2022',
                          textHeight: 5.0,
                          node: _dropOffDateNode,
                          textController: _dropOffDateController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          borderColor: appPrimaryColor.withOpacity(0.5),
                          area: null,
                          suffixIcon: IconButton(
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2022, 3, 5),
                                  maxTime: DateTime(2100, 6, 7),
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
                                    _parseDate(date.toString());
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            icon: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  color: secondaryColor.withOpacity(0.2),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50))),
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
                            _dropOffDate = value!.trim();
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30.0),

                  StreamBuilder<AppSettings>(
                      stream: appSettingsBloc.appSettings,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            (snapshot.data?.loginResponse?.data?.token ?? '')
                                .isNotEmpty) {
                          return Column(
                            children: [
                              const Text(
                                'Sender’s Info',
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                  color: appPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InputField(
                                key: const Key('senderName'),
                                textController: _senderNameController,
                                node: _senderNameNode,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                text: '',
                                hintText: 'Name',
                                textHeight: 0.0,
                                borderColor: appPrimaryColor.withOpacity(0.9),
                                suffixIcon: const Icon(
                                  Remix.user_line,
                                  size: 18.0,
                                  color: Color(0xFF909090),
                                ),
                                validator: (value) {
                                  if (value!.trim().length > 2) {
                                    return null;
                                  }
                                  return "Enter a valid name";
                                },
                                onSaved: (value) {
                                  _receiverName = value!.trim();
                                  return null;
                                },
                              ),

                              // const SizedBox(height: 30.0),
                              InputField(
                                key: const Key('senderPhoneNumber'),
                                textController: _senderPhoneNumberController,
                                node: _senderphoneNumberNode,
                                keyboardType: TextInputType.phone,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                text: '',
                                hintText: 'Phone number',
                                textHeight: 0.0,
                                borderColor: appPrimaryColor.withOpacity(0.9),
                                suffixIcon: const Icon(
                                  Remix.phone_line,
                                  size: 18.0,
                                  color: Color(0xFF909090),
                                ),
                                validator: (value) {
                                  if (value!.trim().length == 11) {
                                    return null;
                                  }
                                  return "Enter a valid phone number";
                                },
                                onSaved: (value) {
                                  _receiverPhoneNumber = value!.trim();
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20.0),
                            ],
                          );
                        }
                        return const SizedBox();
                      }),

                  const Text(
                    'Receiver’s Info',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InputField(
                    key: const Key('receiverName'),
                    textController: _receiverNameController,
                    node: _receiverNameNode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    text: '',
                    hintText: 'Name',
                    textHeight: 0.0,
                    borderColor: appPrimaryColor.withOpacity(0.9),
                    suffixIcon: const Icon(
                      Remix.user_line,
                      size: 18.0,
                      color: Color(0xFF909090),
                    ),
                    validator: (value) {
                      if (value!.trim().length > 2) {
                        return null;
                      }
                      return "Enter a valid name";
                    },
                    onSaved: (value) {
                      _receiverName = value!.trim();
                      return null;
                    },
                  ),

                  // const SizedBox(height: 30.0),
                  InputField(
                    key: const Key('receiverPhoneNumber'),
                    textController: _receiverPhoneNumberController,
                    node: _receiverphoneNumberNode,
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    text: '',
                    hintText: 'Phone number',
                    textHeight: 0.0,
                    borderColor: appPrimaryColor.withOpacity(0.9),
                    suffixIcon: const Icon(
                      Remix.phone_line,
                      size: 18.0,
                      color: Color(0xFF909090),
                    ),
                    validator: (value) {
                      if (value!.trim().length == 11) {
                        return null;
                      }
                      return "Enter a valid phone number";
                    },
                    onSaved: (value) {
                      _receiverPhoneNumber = value!.trim();
                      return null;
                    },
                  ),

                  const SizedBox(height: 20.0),
                  _isItemImage == false
                      ? InkWell(
                          splashColor: Colors.black12.withAlpha(30),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: appPrimaryColor.withOpacity(0.3),
                                  width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 3.4,
                              height: MediaQuery.of(context).size.height / 8.7,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Remix.upload_2_line),
                                    SizedBox(height: 5.0),
                                    Text('Upload item image',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: appPrimaryColor,
                                            fontWeight: FontWeight.w400))
                                  ]),
                            ),
                          ),
                          onTap: uploadItemImage,
                        )
                      : Text(
                          _itemImage,
                          textScaleFactor: 1.5,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                  const SizedBox(height: 30.0),

                  Button(
                    // text: _buttonText.length < 1 ? 'Add Item' : _buttonText,
                    text: 'Proceed',
                    onPress: _onButtonPress,
                    // onPress: _buttonText.length < 1 ? () => _onAddItemPress(context) : () => _saveEdittedItem,
                    color: appPrimaryColor,
                    textColor: whiteColor,
                    isLoading: false,
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),

                  const SizedBox(height: 40.0),
                ]),
              ),
            ),
          ],
        )),
      ),
      //   floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.camera, color: Colors.white, size: 29),
      //   backgroundColor: secondaryColor,
      //   tooltip: 'Capture Picture',
      //   elevation: 5,
      //   splashColor: Colors.grey,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Container(
      //     padding: EdgeInsets.only(bottom: 100.0),
      //     child: Align(
      //       alignment: Alignment.bottomCenter,
      //       child: FloatingActionButton.extended(
      //         onPressed: (){},
      //         icon: Icon(Icons.phone_android),
      //         label: Text("Authenticate using Phone"),
      //       ),
      //     ),
      //   ),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
    // );
  }
}
