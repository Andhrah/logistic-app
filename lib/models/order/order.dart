import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    this.pickUpDate,
    this.deliveryDate,
    this.orderItem,
    this.pickUpLocation,
    this.deliveryLocation,
    this.notes,
  });

  DateTime? pickUpDate;
  DateTime? deliveryDate;
  OrderItem? orderItem;
  OrderLocation? pickUpLocation;
  OrderLocation? deliveryLocation;
  String? notes;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    pickUpDate: DateTime.parse(json["pickUpDate"]),
    deliveryDate: DateTime.parse(json["deliveryDate"]),
    orderItem: OrderItem.fromJson(json["orderItem"]),
    pickUpLocation: OrderLocation.fromJson(json["pickUpLocation"]),
    deliveryLocation: OrderLocation.fromJson(json["deliveryLocation"]),
    notes: json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "pickUpDate": pickUpDate!.toIso8601String(),
    "deliveryDate": deliveryDate!.toIso8601String(),
    "orderItem": orderItem!.toJson(),
    "pickUpLocation": pickUpLocation!.toJson(),
    "deliveryLocation": deliveryLocation!.toJson(),
    "notes": notes,
  };
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
  int? latitude;
  int? longitude;
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
    "isPickUp": isPickUp,
    "isDelivery": isDelivery,
  };
}

class OrderItem {
  OrderItem({
    this.orderItemTypeId,
    this.description,
    this.imageReference,
    this.weight,
  });

  int? orderItemTypeId;
  String? description;
  String? imageReference;
  String? weight;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    orderItemTypeId: json["orderItemTyoeId"],
    description: json["description"],
    imageReference: json["imageReference"],
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "orderItemTypeId": orderItemTypeId,
    "description": description,
    "imageReference": imageReference,
    "weight": weight,
  };
}
