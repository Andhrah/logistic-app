import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/mixins/customer_order_helper.dart';
import 'package:trakk/src/models/order/available_rider_response.dart';
import 'package:trakk/src/models/order/order.dart';
import 'package:trakk/src/provider/customer/customer_map_provider.dart';
import 'package:trakk/src/screens/dispatch/dispatch_summary.dart';
import 'package:trakk/src/screens/dispatch/item_detail/widget/item_detail_category_widget.dart';
import 'package:trakk/src/screens/dispatch/item_detail/widget/item_detail_date_widget.dart';
import 'package:trakk/src/screens/dispatch/item_detail/widget/item_detail_image_selector_widget.dart';
import 'package:trakk/src/screens/dispatch/item_detail/widget/item_detail_location_widget.dart';
import 'package:trakk/src/screens/dispatch/item_detail/widget/item_detail_participant_widget.dart';
import 'package:trakk/src/screens/profile/profile_menu.dart';
import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/widgets/button.dart';

import '../../../models/app_settings.dart';
import '../../../widgets/menu_button.dart';

class ItemDetails extends StatefulWidget {
  static const String id = 'itemDetails';

  const ItemDetails({Key? key}) : super(key: key);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> with CustomerOrderHelper {
  final _formKey = GlobalKey<FormState>();

  String _itemName = '';
  String? _itemDescription;
  String? _itemWeight;

  String? _itemImagePath;

  String? _pickupDate;
  String? _dropOffDate;

  OrderLocation? pickupOrderLocation;
  OrderLocation? dropOffOrderLocation;
  String? _senName;
  String? _senEmail;
  String? _senPhone;
  String? _recName;
  String? _recEmail;
  String? _recPhone;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CustomerMapProvider injector =
          CustomerMapProvider.customerMapProvider(context);
      // injector.connect();
      injector.connectAndListenToSocket(
          onConnected: () {},
          onConnectionError: () {
            injector.disconnectSocket();
            // showDialogButton(context, 'Failed', 'Could not start service', 'Ok');
          });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _onAddItemPress() async {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      form.save();

      LatLng pickupLatLng = LatLng(pickupOrderLocation?.latitude ?? 0.0,
          pickupOrderLocation?.longitude ?? 0.0);
      LatLng dropOffLatLng = LatLng(dropOffOrderLocation?.latitude ?? 0.0,
          dropOffOrderLocation?.longitude ?? 0.0);

      // print('pickupLatLng latitude');
      // print(pickupLatLng.latitude);
      String userId = await appSettingsBloc.getUserID;
      OrderModel orderModel = OrderModel(
          data: OrderModelData(
              userId: int.tryParse(userId),
              pickup: pickupOrderLocation?.address,
              destination: dropOffOrderLocation?.address,
              pickupLatitude: pickupLatLng.latitude.toString(),
              pickupLongitude: pickupLatLng.longitude.toString(),
              destinationLatitude: dropOffLatLng.latitude.toString(),
              destinationLongitude: dropOffLatLng.longitude.toString(),
              distance:
                  '${(Geolocator.distanceBetween(pickupLatLng.latitude, pickupLatLng.longitude, dropOffLatLng.latitude, dropOffLatLng.longitude).round() / 1000).toStringAsFixed(2)} km',
              pickupDate: _pickupDate,
              deliveryDate: _dropOffDate,
              itemName: _itemName,
              itemDescription: _itemDescription,
              itemImage: _itemImagePath,
              weight: _itemWeight,
              senderName: _senName,
              senderEmail: _senEmail,
              senderPhone: _senPhone,
              receiverName: _recName,
              receiverEmail: _recEmail,
              receiverPhone: _recPhone));

      // print(orderModel.toJson());
      FocusScope.of(context).unfocus();
      doGetAvailableRiders(
        pickupLatLng,
        dropOffLatLng,
        loadingModal: () => _showFetchingModal(),
        closeModal: () {
          Navigator.pop(context);
        },
        successfulModal: (List<AvailableRiderDataRider> riders) =>
            _showRiders(orderModel, riders),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          //kSizeBox,
          // const Header(
          //   text: 'DISPATCH ITEM',
          //   padding: EdgeInsets.symmetric(horizontal: kDefaultLayoutPadding),
          //   showBackButton: false,
          // ),

          12.heightInPixel(),
          StreamBuilder<AppSettings>(
              stream: appSettingsBloc.appSettings,
              builder: (context, snapshot) {
                bool showMenu = false;
                if (snapshot.hasData) {
                  // showMenu = (snapshot.data?.loginResponse?.data?.user?.userType ??
                  //             '')=='guest';
                }

                return (showMenu == true)
                    ? Column(
                        children: [
                          Row(
                            children: [
                              MenuButton(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultLayoutPadding),
                                onPress: () {
                                  Navigator.pushNamed(context, ProfileMenu.id);
                                },
                              ),
                            ],
                          ),
                          12.heightInPixel(),
                        ],
                      )
                    : const SizedBox();
              }),

          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StreamBuilder<AppSettings>(
                        stream: appSettingsBloc.appSettings,
                        builder: (context, snapshot) {
                          String firstName = '';
                          if (snapshot.hasData) {
                            firstName = snapshot.data?.loginResponse?.data?.user
                                    ?.firstName ??
                                '';
                          }
                          return Text(
                            "Hello $firstName, ",
                            style: theme.textTheme.subtitle1!.copyWith(
                                fontWeight: kBoldWeight,
                                fontSize: 18,
                                fontFamily: kDefaultFontFamilyHeading
                                // decoration: TextDecoration.underline,
                                ),
                          );
                        }),
                    Text(
                      greetWithTime(),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: kBoldWeight,
                          color: appPrimaryColor,
                          fontFamily: kDefaultFontFamilyHeading),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //8.heightInPixel(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //kSizeBox,
                  //15.heightInPixel(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Kindly enter your Location and Item details",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: appPrimaryColor),
                    ),
                  ),
                  kSizeBox,
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultLayoutPadding),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(Assets.empty_map_bg),
                      fit: BoxFit.fill,
                    )),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        ItemDetailLocationWidget(
                            (OrderLocation? _pickupOrderLocation,
                                OrderLocation? _dropOffOrderLocation) {
                          pickupOrderLocation = _pickupOrderLocation;
                          dropOffOrderLocation = _dropOffOrderLocation;
                        }),
                        ItemDetailCategoryWidget((String? itemName,
                            String description, String weight) {
                          _itemName = itemName ?? '';
                          _itemDescription = description;
                          _itemWeight = weight;
                        }),
                        const SizedBox(height: 20.0),
                        ItemDetailDateWidget((pickup, dropOff) {
                          _pickupDate = pickup;
                          _dropOffDate = dropOff;
                        }),
                        const SizedBox(height: 30.0),
                        ItemDetailParticipantWidget((String senName,
                            String senEmail,
                            String senPhone,
                            String recName,
                            String recEmail,
                            String recPhone) {
                          _senName = senName;
                          _senEmail = senEmail;
                          _senPhone = senPhone;
                          _recName = recName;
                          _recEmail = recEmail;
                          _recPhone = recPhone;
                        }),
                        const SizedBox(height: 20.0),
                        ItemDetailImageSelectorWidget((String? itemImagePath) {
                          _itemImagePath = itemImagePath;
                        }),
                        const SizedBox(height: 30.0),
                        Button(
                          text: 'Proceed',
                          onPress: _onAddItemPress,
                          color: appPrimaryColor,
                          textColor: whiteColor,
                          isLoading: false,
                          width: double.infinity,
                        ),
                        const SizedBox(height: 40.0),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      )),
    );
    // );
  }

  _showFetchingModal() {
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
                        const SizedBox(
                          height: 80,
                          width: 80,
                          child: CircularProgressIndicator(
                            strokeWidth: 5.0,
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
                                  Assets.rider_vehicle,
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

  _showRiders(OrderModel orderModel, List<AvailableRiderDataRider> riders) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35))),
            padding: const EdgeInsets.only(
                left: kDefaultLayoutPadding,
                top: 34,
                right: kDefaultLayoutPadding,
                bottom: 24),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 3,
                        child: CachedNetworkImage(
                            imageUrl: riders.first.userId?.avatar ?? '',
                            height: 50,
                            width: MediaQuery.of(context).size.width / 3,
                            placeholder: (context, url) => SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                ),
                            errorWidget: (context, url, err) =>
                                CachedNetworkImage(
                                  imageUrl:
                                      '${(riders.first.vehicles?.length ?? 0) > 0 ? riders.first.vehicles?.first.image : '-'}',
                                  height: 50,
                                  width: MediaQuery.of(context).size.width / 3,
                                  placeholder: (context, url) => SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                  ),
                                  errorWidget: (context, url, err) =>
                                      Image.asset(
                                    Assets.ride,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                  ),
                                )),
                      ),
                      Text(
                          'Closest and suitable\nrider for item\n$naira${formatMoney(riders.first.cost ?? 0.0)}',
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Text(
                          'Name:',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(riders.first.userId?.firstName ?? '-',
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Text(
                          'Distance:',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                          '${((riders.first.distanceInKm ?? 0.0) ~/ kDistanceKMCoveredInAnHour).toInt()}mins away from\nitem’s location',
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Text(
                          'Vehicle:',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                          '${(riders.first.vehicles?.length ?? 0) > 0 ? riders.first.vehicles?.first.name : '-'}',
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width / 3,
                        child: const Text(
                          'Color:',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                          '${(riders.first.vehicles?.length ?? 0) > 0 ? riders.first.vehicles?.first.color : '-'}',
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Button(
                    text: 'Accept',
                    onPress: () => _pickRider(orderModel, riders.first),
                    color: appPrimaryColor,
                    textColor: whiteColor,
                    isLoading: false,
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),
                  const SizedBox(height: 20.0),
                  Button(
                    text: 'Pick a preferred rider',
                    onPress: () {
                      Navigator.pop(context);
                      _showAllRiders(orderModel, riders);
                    },
                    color: whiteColor,
                    textColor: appPrimaryColor,
                    isLoading: false,
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),
                  const SizedBox(height: 30.0),
                ]),
          );
        });
  }

  _showAllRiders(OrderModel orderModel, List<AvailableRiderDataRider> riders) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        constraints: BoxConstraints(maxHeight: safeAreaHeight(context, 50)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        builder: (context) {
          return Container(
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35))),
            padding: const EdgeInsets.only(top: 34, bottom: 24),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('PICK YOUR PREFERRED DISPATCH',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: appPrimaryColor,
                          fontWeight: FontWeight.w500)),
                  const Divider(
                    height: 44,
                    thickness: 2.5,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: riders.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            CachedNetworkImage(
                                imageUrl:
                                    riders.elementAt(index).userId?.avatar ??
                                        '',
                                height: 50.0,
                                width: 50,
                                placeholder: (context, url) => SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                    ),
                                errorWidget: (context, url, err) =>
                                    CachedNetworkImage(
                                      imageUrl:
                                          '${(riders.elementAt(index).vehicles?.length ?? 0) > 0 ? riders.elementAt(index).vehicles?.first.image : '-'}',
                                      height: 50.0,
                                      width: 50,
                                      placeholder: (context, url) =>
                                          const SizedBox(
                                        height: 50.0,
                                        width: 50,
                                      ),
                                      errorWidget: (context, url, err) =>
                                          Image.asset(
                                        Assets.ride,
                                        height: 50.0,
                                        width: 50,
                                      ),
                                    )),
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      riders
                                              .elementAt(index)
                                              .userId
                                              ?.firstName ??
                                          ((riders
                                                          .elementAt(index)
                                                          .vehicles
                                                          ?.length ??
                                                      0) >
                                                  0
                                              ? riders
                                                  .elementAt(index)
                                                  .vehicles
                                                  ?.first
                                                  .name
                                              : '') ??
                                          '',
                                      style: const TextStyle(
                                          fontSize: 15.0,
                                          color: appPrimaryColor,
                                          fontWeight: kSemiBoldWeight)),
                                  const SizedBox(height: 8.0),
                                  Text(
                                      '${((riders.elementAt(index).distanceInKm ?? 0.0) ~/ kDistanceKMCoveredInAnHour).toInt()}mins away',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: appPrimaryColor)),
                                  const SizedBox(height: 12.0),
                                  Text(
                                      '$naira${formatMoney(riders.elementAt(index).cost ?? 0.0)}',
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: appPrimaryColor,
                                          fontWeight: kMediumWeight)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 90),
                              child: Button(
                                text: 'Pick',
                                onPress: () => _pickRider(
                                    orderModel, riders.elementAt(index)),
                                color: deepGreen,
                                textColor: whiteColor,
                                height: 40,
                                fontSize: 12,
                                isLoading: false,
                                width: MediaQuery.of(context).size.width / 1.2,
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 44,
                          thickness: 2.5,
                        );
                      },
                    ),
                  ),
                ]),
          );
        });
  }

  _pickRider(OrderModel orderModel, AvailableRiderDataRider rider) {
    Navigator.pop(context);
    Navigator.pushNamed(context, DispatchSummary.id, arguments: {
      'orderModel': orderModel.toJson(),
      'riderModel': rider.toJson(),
    });
  }
}
