class OrderModel {
  OrderModel({
    this.data,
  });

  final OrderModelData? data;

  OrderModel copyWith({
    OrderModelData? data,
  }) =>
      OrderModel(
        data: data ?? this.data,
      );

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        data:
            json["data"] == null ? null : OrderModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? {} : data!.toJson(),
      };
}

class OrderModelData {
  OrderModelData({
    this.riderId,
    this.userId,
    this.deliveryCode,
    this.pickup,
    this.pickupLongitude,
    this.pickupLatitude,
    this.pickupDate,
    this.totalAmount,
    this.receiverName,
    this.receiverPhone,
    this.receiverEmail,
    this.senderName,
    this.senderEmail,
    this.senderPhone,
    this.itemName,
    this.itemDescription,
    this.itemImage,
    this.weight,
    this.amount,
    this.destination,
    this.destinationLatitude,
    this.destinationLongitude,
    this.distance,
    this.deliveryDate,
    this.otp,
    this.status,
    this.referred,
  });

  final int? riderId;
  final int? userId;
  final int? deliveryCode;
  final String? pickup;
  final String? pickupLongitude;
  final String? pickupLatitude;
  final String? pickupDate;
  final double? totalAmount;
  final String? receiverName;
  final String? receiverPhone;
  final String? receiverEmail;
  final String? senderName;
  final String? senderEmail;
  final String? senderPhone;
  final String? itemName;
  final String? itemDescription;
  String? itemImage;
  final String? weight;
  final double? amount;
  final String? destination;
  final String? destinationLatitude;
  final String? destinationLongitude;
  final String? distance;
  final String? deliveryDate;
  final String? otp;
  final String? status;
  final bool? referred;

  OrderModelData copyWith({
    int? riderId,
    int? userId,
    int? deliveryCode,
    String? pickup,
    String? pickupLongitude,
    String? pickupLatitude,
    String? pickupDate,
    double? totalAmount,
    String? receiverName,
    String? receiverPhone,
    String? receiverEmail,
    String? senderName,
    String? senderEmail,
    String? senderPhone,
    String? itemName,
    String? itemDescription,
    String? itemImage,
    String? weight,
    double? amount,
    String? destination,
    String? destinationLatitude,
    String? destinationLongitude,
    String? distance,
    String? deliveryDate,
    String? otp,
    String? status,
    bool? referred,
  }) =>
      OrderModelData(
        riderId: riderId ?? this.riderId,
        userId: userId ?? this.userId,
        deliveryCode: deliveryCode ?? this.deliveryCode,
        pickup: pickup ?? this.pickup,
        pickupLongitude: pickupLongitude ?? this.pickupLongitude,
        pickupLatitude: pickupLatitude ?? this.pickupLatitude,
        pickupDate: pickupDate ?? this.pickupDate,
        totalAmount: totalAmount ?? this.totalAmount,
        receiverName: receiverName ?? this.receiverName,
        receiverPhone: receiverPhone ?? this.receiverPhone,
        receiverEmail: receiverEmail ?? this.receiverEmail,
        senderName: senderName ?? this.senderName,
        senderEmail: senderEmail ?? this.senderEmail,
        senderPhone: senderPhone ?? this.senderPhone,
        itemName: itemName ?? this.itemName,
        itemDescription: itemDescription ?? this.itemDescription,
        itemImage: itemImage ?? this.itemImage,
        weight: weight ?? this.weight,
        amount: amount ?? this.amount,
        destination: destination ?? this.destination,
        destinationLatitude: destinationLatitude ?? this.destinationLatitude,
        destinationLongitude: destinationLongitude ?? this.destinationLongitude,
        distance: distance ?? this.distance,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        otp: otp ?? this.otp,
        status: status ?? this.status,
        referred: referred ?? this.referred,
      );

  factory OrderModelData.fromJson(Map<String, dynamic> json) => OrderModelData(
        riderId: json["riderId"] == null ? null : json["riderId"],
        userId: json["userId"] == null ? null : json["userId"],
        deliveryCode:
            json["deliveryCode"] == null ? null : json["deliveryCode"],
        pickup: json["pickup"] == null ? null : json["pickup"],
        pickupLongitude:
            json["pickupLongitude"] == null ? null : json["pickupLongitude"],
        pickupLatitude:
            json["pickupLatitude"] == null ? null : json["pickupLatitude"],
        pickupDate: json["pickupDate"] == null ? null : json["pickupDate"],
        totalAmount:
            json["totalAmount"] == null ? null : json["totalAmount"].toDouble(),
        receiverName:
            json["receiverName"] == null ? null : json["receiverName"],
        receiverPhone:
            json["receiverPhone"] == null ? null : json["receiverPhone"],
        receiverEmail:
            json["receiverEmail"] == null ? null : json["receiverEmail"],
        senderName: json["senderName"] == null ? null : json["senderName"],
        senderEmail: json["senderEmail"] == null ? null : json["senderEmail"],
        senderPhone: json["senderPhone"] == null ? null : json["senderPhone"],
        itemName: json["itemName"] == null ? null : json["itemName"],
        itemDescription:
            json["itemDescription"] == null ? null : json["itemDescription"],
        itemImage: json["itemImage"] == null ? null : json["itemImage"],
        weight: json["weight"] == null ? null : json["weight"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        destination: json["destination"] == null ? null : json["destination"],
        destinationLatitude: json["destinationLatitude"] == null
            ? null
            : json["destinationLatitude"],
        destinationLongitude: json["destinationLongitude"] == null
            ? null
            : json["destinationLongitude"],
        distance: json["distance"] == null ? null : json["distance"],
        deliveryDate:
            json["deliveryDate"] == null ? null : json["deliveryDate"],
        otp: json["otp"] == null ? null : json["otp"],
        status: json["status"] == null ? null : json["status"],
        referred: json["referred"] == null ? null : json["referred"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> _map = {
      "riderId": riderId == null ? null : riderId,
      "userId": userId == null ? null : userId,
      "deliveryCode": deliveryCode == null ? null : deliveryCode,
      "pickup": pickup == null ? null : pickup,
      "pickupLongitude": pickupLongitude == null ? null : pickupLongitude,
      "pickupLatitude": pickupLatitude == null ? null : pickupLatitude,
      "pickupDate": pickupDate == null ? null : pickupDate,
      "totalAmount": totalAmount == null ? null : totalAmount,
      "receiverName": receiverName == null ? null : receiverName,
      "receiverPhone": receiverPhone == null ? null : receiverPhone,
      "receiverEmail": receiverEmail == null ? null : receiverEmail,
      "senderName": senderName == null ? null : senderName,
      "senderEmail": senderEmail == null ? null : senderEmail,
      "senderPhone": senderPhone == null ? null : senderPhone,
      "itemName": itemName == null ? null : itemName,
      "itemDescription": itemDescription == null ? null : itemDescription,
      "itemImage": itemImage == null ? null : itemImage,
      "weight": weight == null ? null : weight,
      "amount": amount == null ? null : amount,
      "destination": destination == null ? null : destination,
      "destinationLatitude":
          destinationLatitude == null ? null : destinationLatitude,
      "destinationLongitude":
          destinationLongitude == null ? null : destinationLongitude,
      "distance": distance == null ? null : distance,
      "deliveryDate": deliveryDate == null ? null : deliveryDate,
      "otp": otp == null ? null : otp,
      "status": status == null ? 'pending' : status,
      "referred": referred == null ? false : referred,
    };

    _map.removeWhere((key, value) => value == null);
    return _map;
  }
}

class OrderLocation {
  OrderLocation({
    this.address,
    this.latitude,
    this.longitude,
    this.isPickUp,
    this.isDelivery,
  });

  String? address;
  double? latitude;
  double? longitude;
  bool? isPickUp;
  bool? isDelivery;

  factory OrderLocation.fromJson(Map<String, dynamic> json) => OrderLocation(
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isPickUp: json["isPickUp"],
        isDelivery: json["isDelivery"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "isPickUp": isPickUp ?? false,
        "isDelivery": isDelivery ?? false,
      };
}
