// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;

  // List<Map> paymentMethod = [
  //   {
  //     'method': 'Debit Cards',
  //     'cards': [
  //       {
  //         'bankName': 'Access Bank',
  //         'bankType': 'masterCard',
  //         'cardLastDigits': 3240,
  //       }
  //     ],
  //   },
  //   {...},
  // ];

  List paymentMethods = [
    'Debit Cards',
    'bank transfer',
    'wallet',
    'Zebrra',
    'Pay on delivery',
  ];

  // List<Map> cards = [
  //   {
  //     'cardType': 'masterCard',
  //     'bankName': 'Access Bank',
  //     'cardLastDigits': 3240,
      
  //   },
  //   {...},
  // ];
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}
