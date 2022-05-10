class Order {
  final int id;
  final String pickup;
  final String dropoff;
  final String itemCategory;
  final String itemDescription;
  final String image;
  final String receiverName;
  final String receiverPhoneNumber;
  // final String receiverEmail;
  final String cost;

  Order({
    required this.id,
    required this.pickup,
    required this.dropoff,
    required this.itemCategory, 
    required this.itemDescription,
    required this.image,
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.cost
  });

  // @override
  // int get hashCode => id;

  //  @override
  // bool operator ==(Object other) => other is Order && other.id == id;
}