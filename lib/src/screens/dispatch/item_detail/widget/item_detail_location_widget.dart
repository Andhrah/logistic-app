import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:location/location.dart' as Loca;
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/.env.dart';
import 'package:trakk/src/models/order/order.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/input_field.dart';

typedef _OnInputCallback = Function(
    OrderLocation pickUpOrderLocation, OrderLocation dropOffOrderLocation);

class ItemDetailLocationWidget extends StatefulWidget {
  final _OnInputCallback callback;

  const ItemDetailLocationWidget(this.callback, {Key? key}) : super(key: key);

  @override
  _ItemDetailLocationWidgetState createState() =>
      _ItemDetailLocationWidgetState();
}

class _ItemDetailLocationWidgetState extends State<ItemDetailLocationWidget> {
  final TextEditingController _pickUpController = TextEditingController();
  final TextEditingController _dropOffController = TextEditingController();

  final FocusNode _pickUpNode = FocusNode();
  final FocusNode _dropOffNode = FocusNode();

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];

  String? _pickUp;
  String? _dropOff;

  LatLng? pickUpLatLng;
  LatLng? dropOffLatLng;

  Timer? _debounce;

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    googlePlace = GooglePlace(googleAPIKey);
    init();
  }

  init() async {
    var loca = await fetchLocation();

    if (loca != null) {
      pickUpLatLng = LatLng(loca.latitude ?? 0.0, loca.longitude ?? 0.0);

      var list = (await geocoding.placemarkFromCoordinates(
          pickUpLatLng?.latitude ?? 0.0, pickUpLatLng?.longitude ?? 0.0));
      if (list.isNotEmpty) {
        // for (var data in list) {
        //   print(data.name);
        //   print(data.street);
        //   print(data.subLocality);
        //   print(data.subAdministrativeArea);
        //   print(data.thoroughfare);
        //   print(data.subThoroughfare);
        //   print(data.country);
        // }
        _pickUp = list.first.street;

        setState(() {
          _pickUpController.text = _pickUp ?? '';
        });

        doCallback();
      }
    }
  }

  Future<Loca.LocationData?> fetchLocation() async {
    Loca.LocationData? locationData;
    final Loca.Location location = Loca.Location();
    bool serviceEnabled;
    Loca.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return locationData;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == Loca.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      //TODO: do your logic to manage when user denies the permission
      if (permissionGranted != Loca.PermissionStatus.granted) {
        appToast('Permission not granted', appToastType: AppToastType.failed);
        return locationData;
      }
    }
    locationData = await location.getLocation();

    return locationData;
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    _pickUpNode.dispose();
    _dropOffNode.dispose();
  }

  doCallback() => widget.callback(
      OrderLocation(
        address: _pickUp,
        latitude: pickUpLatLng?.latitude,
        longitude: pickUpLatLng?.longitude,
        isPickUp: true,
      ),
      OrderLocation(
        address: _dropOff,
        latitude: dropOffLatLng?.latitude,
        longitude: dropOffLatLng?.longitude,
        isDelivery: true,
      ));

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Row(
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textHeight: 0.0,
                      borderColor: appPrimaryColor.withOpacity(0.5),
                      validator: (value) {
                        if (value!.trim().length > 2) {
                          return null;
                        }
                        return "Enter a valid pick-up location";
                      },
                      onSaved: (value) {
                        doCallback();
                        return null;
                      },
                      onChanged: (value) {
                        // cancel _debounce if its active and restart it if user type in something again
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        // prevent the autoCompleteSearch from search on every little keypress
                        _debounce =
                            Timer(const Duration(milliseconds: 1000), () {
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textHeight: 0,
                      borderColor: appPrimaryColor.withOpacity(0.5),
                      validator: (value) {
                        if (value!.trim().length > 2) {
                          return null;
                        }
                        return "Enter a valid drop-off location";
                      },
                      onSaved: (value) {
                        doCallback();
                        return null;
                      },
                      onChanged: (value) {
                        // cancel _debounce if its active and restart it if user type in something again
                        if (_debounce?.isActive ?? false) _debounce!.cancel();
                        // prevent the autoCompleteSearch from search on every little keypress
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
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
        ListView.builder(
            shrinkWrap: true,
            itemCount: predictions.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: appPrimaryColor,
                  radius: 20,
                  child: Icon(
                    Remix.pin_distance_fill,
                    color: secondaryColor,
                    size: 18,
                  ),
                ),
                title: Text(
                  predictions[index].description.toString(),
                  style: theme.textTheme.bodyText2,
                ),
                onTap: () async {
                  final placeId = predictions[index].placeId!;
                  final details = await googlePlace.details.get(placeId);
                  if (details != null && details.result != null && mounted) {
                    print("+++++++++++++++++++++++++++++");
                    print(details.result!.addressComponents);
                    if (_pickUpNode.hasFocus) {
                      setState(() {
                        _pickUp = details.result!.name!;
                        pickUpLatLng = LatLng(
                            details.result?.geometry?.location?.lat ?? 0.0,
                            details.result?.geometry?.location?.lng ?? 0.0);
                        print('******************************');
                        print(_pickUp.runtimeType);
                        _pickUpController.text = details.result!.name!;
                        predictions = [];
                      });
                    } else {
                      setState(() {
                        _dropOff = details.result!.name!;
                        _dropOffController.text = details.result!.name!;
                        dropOffLatLng = LatLng(
                            details.result?.geometry?.location?.lat ?? 0.0,
                            details.result?.geometry?.location?.lng ?? 0.0);

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
      ],
    );
  }
}
