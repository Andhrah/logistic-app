import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/auth/signup.dart';
import 'package:trakk/screens/wallet/all_cards.dart';
import 'package:trakk/screens/wallet/buy_airtime.dart';
import 'package:trakk/screens/wallet/fund_wallet.dart';
import 'package:trakk/screens/wallet/payments.dart';
import 'package:trakk/screens/wallet/qr_code_payment.dart';
import 'package:trakk/screens/wallet/transfers.dart';

import 'dart:math' as math;
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/back_icon.dart';
import 'package:trakk/widgets/icon_container.dart';
import 'package:trakk/widgets/input_field.dart';
import 'package:trakk/widgets/qr_code_line.dart';

class QrPayment extends StatefulWidget {
  static const String id = "qrPayment";

  const QrPayment({Key? key}) : super(key: key);

  @override
  _QrPaymentState createState() => _QrPaymentState();
}

class _QrPaymentState extends State<QrPayment> {
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  String? _pickUpDate;
  String? _dropOffDate;
  

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
 
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  void initState() {
    super.initState();
    String apiKey = "AIzaSyBvxkb0Gv6kwpiplPtmeQZhG4_V-KvLZ1U";

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

    
  }

  _parseDate(value) {
    var date = DateTime.parse(value);
    var formattedDate = "${date.day}-${date.month}-${date.year}";
    return formattedDate;

    // print(formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
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
                    'QR PAYMENT',
                    style: TextStyle(
                        color: appPrimaryColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
             InkWell(onTap: (){
               Navigator.of(context).pushNamed(QrCodePayment.id);
             },
              child: const QrLineContainer(title: "Pay with QR Code",),),
            InkWell(onTap: () {
              //Navigator.of(context).pushNamed();
            },
              child: const QrLineContainer(title: "View your QR Code",),),
            InkWell(onTap: () {
              Navigator.of(context).pushNamed(Signup.id);
            },
              child: const QrLineContainer(title: "Onboard as a Merchant",)),
            
          ]),
        ),
      ),
    );
  }
}

