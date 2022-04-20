import 'package:flutter/material.dart';
import 'package:trakk/screens/dispatch/dispatch_summary.dart';
import 'package:trakk/utils/colors.dart';
import 'package:trakk/widgets/button.dart';
import 'package:trakk/widgets/expandable_item.dart';
import 'package:trakk/widgets/header.dart';
import 'package:trakk/widgets/input_field.dart';
import 'package:remixicon/remixicon.dart';

// This is the stateful widget that the main application instantiates.
class Payment extends StatefulWidget {
  static const String id = 'payment';

  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

// This is the private State class that goes with MyStatefulWidget.
class _PaymentState extends State<Payment> {

  final List<Item> _data = generateItems(8);

  final List paymentMethods = [
    'Debit Cards',
    'bank transfer',
    'wallet',
    'Zebrra',
    'Pay on delivery',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              const Header(
                text: 'PAYMENT',
              ),

              const SizedBox(height: 30.0),

              // Column(
              //   children: paymentMethods.map<RadioListTile>((method) => {
              //   return Card()
              // })
              // )

              

              Container(
                child: _buildPanel(),
              ),

              const SizedBox(height: 10.0),
              Button(
                text: 'Checkout', 
                onPress: () {
                  Navigator.of(context).pushNamed(DispatchSummary.id);
                }, 
                color: appPrimaryColor, 
                textColor: whiteColor, 
                isLoading: false,
                width: MediaQuery.of(context).size.width/1.2,
              )
            ],
          )
        ),
      )
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Card(
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('One-line with leading widget'),
              ),
            );
            // return ListTile(
            //   title: Text(item.headerValue),
            // );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

}
