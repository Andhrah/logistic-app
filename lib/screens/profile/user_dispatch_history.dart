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

class UserDispatchHistory extends StatefulWidget {
  static const String id = 'userdispatchhistory';

  const UserDispatchHistory({Key? key}) : super(key: key);

  @override
  State<UserDispatchHistory> createState() => _UserDispatcHistoryState();
}

class _UserDispatcHistoryState extends State<UserDispatchHistory> {
  final _formKey = GlobalKey<FormState>();

  //final List<Item> _data = generateItems(1);

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
  bool _expanded = false;
  bool _expanded1 = false;

   Color color = whiteColor;

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
            child: SingleChildScrollView(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Expanded(
                        child: InputField(
                          obscureText: false,
                          text: '',
                          hintText: 'Select date',
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
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(color: grayColor)),
                        child: Center(
                            child: Text(
                          '30/01/2022',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("To"),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(color: grayColor)),
                        child: Center(
                          child: Text(
                            '30/01/2022',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, right: 30, left: 30),
                child: Text(
                  'Today\'s delivery',
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                child: ListView.separated(padding: EdgeInsets.only(left: 15, right: 20),
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10,);
                },
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            ExpansionPanelList(
                              elevation: 1,
                              animationDuration: Duration(milliseconds: 200),
                              children: [
                                ExpansionPanel(
                                  headerBuilder: (context, isExpanded) {
                                    return ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Expanded(
                                                child: Text(
                                                  'Delivery to Ikorodu',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  '#4000',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5,),
                                          const Text(
                                            '21/2/2022',
                                            style: TextStyle(
                                                color: grayColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  body: Column(
                                    children: [
                                      Divider(
                                        thickness: 2,
                                        color: appPrimaryColor,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 20,
                                            left: 0,
                                            right: 8,
                                            bottom: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 50,
                                                  //height: 100,
                                                  //color: appPrimaryColor,
                                                  child: Image.asset(
                                                    "assets/images/order_highlighter2.png",
                                                    height: 100.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 0.0),
                                                Column(
                                                  children: [
                                                    Text('Pickup Location'),
                                                    const SizedBox(
                                                        height: 65.0),
                                                    Text(
                                                      'Delivery Location',
                                                      // style: TextStyle(
                                                      //     fontSize: 16,
                                                      //     fontWeight:
                                                      //         FontWeight
                                                      //             .w500),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Pickup Location'),
                                                    const SizedBox(
                                                        height: 65.0),
                                                    Text(
                                                      'Delivery ',
                                                      // style: TextStyle(
                                                      //     fontSize: 16,
                                                      //     fontWeight:
                                                      //         FontWeight
                                                      //             .w500),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Radio(
                                                          value: null,
                                                          groupValue: null,
                                                          fillColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      secondaryColor),

                                                          onChanged: null,

                                                          //mouseCursor: MouseCursor.uncontrolled,
                                                        ),
                                                        Text("Item"),
                                                        SizedBox(
                                                          width: 95,
                                                        ),
                                                        Text(
                                                          'Black handbag',
                                                          style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Radio(
                                                          value: null,
                                                          groupValue: null,
                                                          fillColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      secondaryColor),

                                                          onChanged: null,

                                                          //mouseCursor: MouseCursor.uncontrolled,
                                                        ),
                                                        Text("Rider"),
                                                        // const SizedBox(
                                                        //   width: 20,
                                                        // ),
                                                        SizedBox(
                                                          width: 95,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: const [
                                                            Text(
                                                              'Malik Johnson',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'Boxer 0098',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  isExpanded: _expanded,
                                  canTapOnHeader: true,
                                ),
                              ],
                              dividerColor: Color.fromARGB(255, 143, 141, 141),
                              expansionCallback: (int panelIndex, bool isExpanded) {
                                 _expanded = !_expanded;
                                setState(() {
                                  isExpanded ? Colors.blue : Colors.grey;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: Text(
                  'Previous Dispatch',
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    // decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right:20),
                  child: ListView.builder(
                    //padding: EdgeInsets.only(left: 15, right: 20),
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              ExpansionPanelList(
                                elevation: 1,
                                animationDuration: Duration(milliseconds: 200),
                                children: [
                                  ExpansionPanel(
                                    backgroundColor: color,
                                    headerBuilder: (context, isExpanded) {
                                      return ListTile(
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: const [
                                                Expanded(
                                                  child: Text(
                                                    'Delivery to Ikorodu',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '#4000',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Text(
                                              '21/2/2022',
                                              style: TextStyle(
                                                  color: grayColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    body: Column(
                                      children: [
                                        Divider(
                                          thickness: 2,
                                          color: appPrimaryColor,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 20,
                                              left: 0,
                                              right: 8,
                                              bottom: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    //height: 100,
                                                    //color: appPrimaryColor,
                                                    child: Image.asset(
                                                      "assets/images/order_highlighter2.png",
                                                      height: 100.0,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 0.0),
                                                  Column(
                                                    children: [
                                                      Text('Pickup Location'),
                                                      const SizedBox(
                                                          height: 65.0),
                                                      Text(
                                                        'Delivery Location',
                                                        // style: TextStyle(
                                                        //     fontSize: 16,
                                                        //     fontWeight:
                                                        //         FontWeight
                                                        //             .w500),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Pickup Location'),
                                                      const SizedBox(
                                                          height: 65.0),
                                                      Text(
                                                        'Delivery ',
                                                        // style: TextStyle(
                                                        //     fontSize: 16,
                                                        //     fontWeight:
                                                        //         FontWeight
                                                        //             .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Radio(
                                                            value: null,
                                                            groupValue: null,
                                                            fillColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                                        secondaryColor),

                                                            onChanged: null,

                                                            //mouseCursor: MouseCursor.uncontrolled,
                                                          ),
                                                          Text("Item"),
                                                          SizedBox(
                                                            width: 95,
                                                          ),
                                                          Text(
                                                            'Black handbag',
                                                            style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Radio(
                                                            value: null,
                                                            groupValue: null,
                                                            fillColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                                        secondaryColor),

                                                            onChanged: null,

                                                            //mouseCursor: MouseCursor.uncontrolled,
                                                          ),
                                                          Text("Rider"),
                                                          // const SizedBox(
                                                          //   width: 20,
                                                          // ),
                                                          SizedBox(
                                                            width: 95,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: const [
                                                              Text(
                                                                'Malik Johnson',
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                'Boxer 0098',
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    isExpanded: _expanded1,
                                    canTapOnHeader: true,
                                  ),
                                ],
                                dividerColor: Color.fromARGB(255, 143, 141, 141),
                                expansionCallback: (int panelIndex, bool isExpanded) {
                                  setState(() {
                                    isExpanded = !_expanded1;
                                   !isExpanded ? color  : grayColor;
                                  });
                                   _expanded1 = !_expanded1;
                                   if(_expanded1 == true){
                                     setState(() {
                                        color = whiteColor;
                                     });
                                    
                                   }else if(_expanded1 == false){
                                     setState(() {
                                       color = Color.fromARGB(255, 235, 235, 235);
                                     });
                                   }
                                  
                                },
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        )));
  }
}

