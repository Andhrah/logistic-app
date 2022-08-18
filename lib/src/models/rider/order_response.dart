import 'package:trakk/src/models/auth_response.dart';

class OrderResponse {
  OrderResponse({
    this.order,
  });

  final Order? order;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "order": order == null ? null : order!.toJson(),
      };
}

class Order {
  Order({
    this.id,
    this.deliveryCode,
    this.pickup,
    this.pickupLongitude,
    this.pickupLatitude,
    this.totalAmount,
    this.pickupDate,
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
    this.referred,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.status,
    this.orderRef,
    this.quantity,
    this.rider,
    this.user,
    this.createdBy,
    this.updatedBy,
  });

  final int? id;
  final String? deliveryCode;
  final String? pickup;
  final double? pickupLongitude;
  final double? pickupLatitude;
  final double? totalAmount;
  final String? pickupDate;
  final String? receiverName;
  final String? receiverPhone;
  final String? receiverEmail;
  final String? senderName;
  final String? senderEmail;
  final String? senderPhone;
  final String? itemName;
  final String? itemDescription;
  final String? itemImage;
  final String? weight;
  final double? amount;
  final String? destination;
  final double? destinationLatitude;
  final double? destinationLongitude;
  final String? distance;
  final String? deliveryDate;
  final String? otp;
  final bool? referred;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  String? status;
  final String? orderRef;
  final dynamic quantity;
  final Rider? rider;
  final User? user;
  final dynamic createdBy;
  final dynamic updatedBy;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] == null ? null : json["id"],
        deliveryCode: json["deliveryCode"] == null
            ? null
            : json["deliveryCode"].toString(),
        pickup: json["pickup"] == null ? null : json["pickup"],
        pickupLongitude: json["pickupLongitude"] == null
            ? null
            : double.tryParse(
                    json["pickupLongitude"].toString().replaceAll(',', '')) ??
                0.0,
        pickupLatitude: json["pickupLatitude"] == null
            ? null
            : double.tryParse(
                    json["pickupLatitude"].toString().replaceAll(',', '')) ??
                0.0,
        totalAmount:
            json["totalAmount"] == null ? null : json["totalAmount"].toDouble(),
        pickupDate: json["pickupDate"] == null ? null : json["pickupDate"],
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
            : double.tryParse(json["destinationLatitude"]
                    .toString()
                    .replaceAll(',', '')) ??
                0.0,
        destinationLongitude: json["destinationLongitude"] == null
            ? null
            : double.tryParse(json["destinationLongitude"]
                    .toString()
                    .replaceAll(',', '')) ??
                0.0,
        distance: json["distance"] == null ? null : json["distance"],
        deliveryDate:
            json["deliveryDate"] == null ? null : json["deliveryDate"],
        otp: json["otp"] == null ? null : json["otp"],
        referred: json["referred"] == null ? null : json["referred"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        status: json["status"] == null ? null : json["status"],
        orderRef: json["orderRef"] == null ? null : json["orderRef"],
        quantity: json["quantity"],
        rider: json["riderId"] == null ? null : Rider.fromJson(json["riderId"]),
        user: json["userId"] == null ? null : User.fromJson(json["userId"]),
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "deliveryCode": deliveryCode == null ? null : deliveryCode,
        "pickup": pickup == null ? null : pickup,
        "pickupLongitude": pickupLongitude == null ? null : pickupLongitude,
        "pickupLatitude": pickupLatitude == null ? null : pickupLatitude,
        "totalAmount": totalAmount == null ? null : totalAmount,
        "pickupDate": pickupDate == null ? null : pickupDate,
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
        "referred": referred == null ? null : referred,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "publishedAt":
            publishedAt == null ? null : publishedAt!.toIso8601String(),
        "status": status == null ? null : status,
        "orderRef": orderRef == null ? null : orderRef,
        "quantity": quantity,
        "riderId": rider == null ? null : rider!.toJson(),
        "userId": user == null ? null : user!.toJson(),
        "createdBy": createdBy,
        "updatedBy": updatedBy,
      };
}
