import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_place/google_place.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/default_container.dart';
import 'package:trakk/widgets/input_field.dart';

import '../../widgets/back_icon.dart';

class ReferredRides extends StatefulWidget {
  static const String id = 'referredrides';

  const ReferredRides({Key? key}) : super(key: key);

  @override
  State<ReferredRides> createState() => _ReferredRidesState();
}

class _ReferredRidesState extends State<ReferredRides> {
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
  dynamic _buttonText = "";
  dynamic _previousRoute = "";

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  //Timer? _debounce;

  DetailsResult? _pickUp;
  DetailsResult? _dropOff;

  bool _isItemImage = false;

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
    var box = await Hive.openBox('routes');
    setState(() {
      _previousRoute = box.get('previousRoute');
    });
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
  _onAddItemPress() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      var box = await Hive.openBox('userOrder');
      box.putAll({
        "pickUp": _pickUp,
        "dropOff": _dropOff,
        "receiverName": _receiverName,
        "receiverPhoneNumber": _receiverPhoneNumber,
        "item": _item,
        "itemDescription": _itemDescription,
        "pickUpDate": _pickUpDate,
        "dropOffDate": _dropOffDate,
        "itemImage": _itemImage,
      });
      // Navigator.of(context).pushNamed( NextOfKin.id);
    }
  }

  _saveEdittedItem() async {
    var box = await Hive.openBox('routes');
    setState(() {
      _previousRoute = box.delete('previousRoute');
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    'DISPATCH HISTORY',
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
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                  //rossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  obscureText: false,
                                  text: 'Select Date',
                                  hintText: '24/3/2022',
                                  textHeight: 5.0,
                                  node: _pickUpDateNode,
                                  textController: _pickUpDateController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                            date.timeZoneOffset.inHours
                                                .toString());
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
                                    icon: const Icon(
                                      Remix.calendar_2_fill,
                                      size: 22.0,
                                      color: secondaryColor,
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
                              Align(alignment: Alignment.center,
                                child: Text('To', style: TextStyle(fontSize: 18),)),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: InputField(
                                  obscureText: false,
                                  text: '',
                                  hintText: '26/3/2022',
                                  textHeight: 5.0,
                                  node: _dropOffDateNode,
                                  textController: _dropOffDateController,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                            date.timeZoneOffset.inHours
                                                .toString());
                                      }, onConfirm: (date) {
                                        print('confirm $date');
                                        _dropOffDateController.text =
                                            _parseDate(date.toString());
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.en);
                                    },
                                    icon: const Icon(
                                      Remix.calendar_2_fill,
                                      size: 22.0,
                                      color: secondaryColor,
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
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today\'s referrred ride',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      color: appPrimaryColor,
                      fontWeight: FontWeight.bold,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Color(0xffEEEEEE),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("None"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )));
  }
}
