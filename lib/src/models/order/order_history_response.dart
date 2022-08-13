class OrderHistoryResponse {
  OrderHistoryResponse({
    this.status,
    this.data,
    this.meta,
  });

  final String? status;
  final OrderHistoryResponseData? data;
  final Meta? meta;

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) =>
      OrderHistoryResponse(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : json["data"] is List
                ? OrderHistoryResponseData(
                    attributes: OrderHistoryResponseDataDatum(
                        attributes: PurpleAttributes(
                            data: List<OrderHistoryDatum>.from(json["data"]
                                .map((x) => OrderHistoryDatum.fromJson(x))))))
                : OrderHistoryResponseData.fromJson(json["data"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data!.toJson(),
        "meta": meta == null ? null : meta!.toJson(),
      };
}

class OrderHistoryResponseData {
  OrderHistoryResponseData({
    this.attributes,
  });

  final OrderHistoryResponseDataDatum? attributes;

  factory OrderHistoryResponseData.fromJson(Map<String, dynamic> json) =>
      OrderHistoryResponseData(
        attributes: json["attributes"] == null
            ? null
            : OrderHistoryResponseDataDatum.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes == null ? null : attributes!.toJson(),
      };
}

class OrderHistoryResponseDataDatum {
  OrderHistoryResponseDataDatum({
    this.attributes,
  });

  final PurpleAttributes? attributes;

  factory OrderHistoryResponseDataDatum.fromJson(Map<String, dynamic> json) =>
      OrderHistoryResponseDataDatum(
        attributes: json["orders"] == null
            ? null
            : PurpleAttributes.fromJson(json["orders"]),
      );

  Map<String, dynamic> toJson() => {
        "orders": attributes == null ? null : attributes!.toJson(),
      };
}

class PurpleAttributes {
  PurpleAttributes({
    this.data,
  });

  final List<OrderHistoryDatum>? data;

  factory PurpleAttributes.fromJson(Map<String, dynamic> json) =>
      PurpleAttributes(
        data: json["data"] == null
            ? null
            : List<OrderHistoryDatum>.from(
                json["data"].map((x) => OrderHistoryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OrderHistoryDatum {
  OrderHistoryDatum({
    this.id,
    this.attributes,
  });

  final int? id;
  final OrderHistoryDatumAttributes? attributes;

  factory OrderHistoryDatum.fromJson(Map<String, dynamic> json) =>
      OrderHistoryDatum(
        id: json["id"] == null ? null : json["id"],
        attributes: json["attributes"] == null
            ? null
            : OrderHistoryDatumAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "attributes": attributes == null ? null : attributes!.toJson(),
      };
}

class OrderHistoryDatumAttributes {
  OrderHistoryDatumAttributes({
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
    this.riderId,
    this.userId,
  });

  final String? deliveryCode;
  final String? pickup;
  final String? pickupLongitude;
  final String? pickupLatitude;
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
  final String? destinationLatitude;
  final String? destinationLongitude;
  final String? distance;
  final String? deliveryDate;
  final String? otp;
  final bool? referred;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final String? status;
  final String? orderRef;
  final String? quantity;
  final OrderHistoryDatumAttributesRiderId? riderId;
  final OrderHistoryDatumAttributesUserId? userId;

  factory OrderHistoryDatumAttributes.fromJson(Map<String, dynamic> json) =>
      OrderHistoryDatumAttributes(
        deliveryCode: json["deliveryCode"] == null
            ? null
            : json["deliveryCode"].toString(),
        pickup: json["pickup"] == null ? null : json["pickup"],
        pickupLongitude:
            json["pickupLongitude"] == null ? null : json["pickupLongitude"],
        pickupLatitude:
            json["pickupLatitude"] == null ? null : json["pickupLatitude"],
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
            : json["destinationLatitude"],
        destinationLongitude: json["destinationLongitude"] == null
            ? null
            : json["destinationLongitude"],
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
        quantity: json["quantity"] == null ? null : json["quantity"].toString(),
        riderId: json["riderId"] == null
            ? null
            : OrderHistoryDatumAttributesRiderId.fromJson(json["riderId"]),
        userId: json["userId"] == null
            ? null
            : OrderHistoryDatumAttributesUserId.fromJson(json["userId"]),
      );

  Map<String, dynamic> toJson() => {
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
        "quantity": quantity == null ? null : quantity,
        "riderId": riderId == null ? null : riderId!.toJson(),
        "userId": userId == null ? null : userId!.toJson(),
      };
}

class OrderHistoryDatumAttributesRiderId {
  OrderHistoryDatumAttributesRiderId({
    this.data,
  });

  final OrderHistoryDatumAttributesRiderIdData? data;

  factory OrderHistoryDatumAttributesRiderId.fromJson(
          Map<String, dynamic> json) =>
      OrderHistoryDatumAttributesRiderId(
        data: json["data"] == null
            ? null
            : OrderHistoryDatumAttributesRiderIdData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class OrderHistoryDatumAttributesRiderIdData {
  OrderHistoryDatumAttributesRiderIdData({
    this.id,
    this.attributes,
  });

  final int? id;
  final OrderHistoryDatumAttributesRiderIdDataPurpleAttributes? attributes;

  factory OrderHistoryDatumAttributesRiderIdData.fromJson(
          Map<String, dynamic> json) =>
      OrderHistoryDatumAttributesRiderIdData(
        id: json["id"] == null ? null : json["id"],
        attributes: json["attributes"] == null
            ? null
            : OrderHistoryDatumAttributesRiderIdDataPurpleAttributes.fromJson(
                json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "attributes": attributes == null ? null : attributes!.toJson(),
      };
}

class OrderHistoryDatumAttributesRiderIdDataPurpleAttributes {
  OrderHistoryDatumAttributesRiderIdDataPurpleAttributes(
      {this.avatar,
      this.dateOfBirth,
      this.currentLocation,
      this.currentLongitude,
      this.currentLatitude,
      this.stateOfOrigin,
      this.stateOfResidence,
      this.residentialAddress,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.status,
      this.cost,
      this.userID});

  final String? avatar;
  final String? dateOfBirth;
  final String? currentLocation;
  final double? currentLongitude;
  final double? currentLatitude;
  final String? stateOfOrigin;
  final String? stateOfResidence;
  final String? residentialAddress;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final String? status;
  final String? cost;
  final OrderHistoryDatumAttributesUserId? userID;

  factory OrderHistoryDatumAttributesRiderIdDataPurpleAttributes.fromJson(
          Map<String, dynamic> json) =>
      OrderHistoryDatumAttributesRiderIdDataPurpleAttributes(
        avatar: json["avatar"] == null ? null : json["avatar"],
        dateOfBirth: json["dateOfBirth"] == null ? null : json["dateOfBirth"],
        currentLocation:
            json["currentLocation"] == null ? null : json["currentLocation"],
        currentLongitude: json["currentLongitude"] == null
            ? null
            : json["currentLongitude"].toDouble(),
        currentLatitude: json["currentLatitude"] == null
            ? null
            : json["currentLatitude"].toDouble(),
        stateOfOrigin:
            json["stateOfOrigin"] == null ? null : json["stateOfOrigin"],
        stateOfResidence:
            json["stateOfResidence"] == null ? null : json["stateOfResidence"],
        residentialAddress: json["residentialAddress"] == null
            ? null
            : json["residentialAddress"],
        phone: json["phone"] == null ? null : json["phone"],
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
        cost: json["cost"] == null ? null : json["avatar"].toString(),
        userID: json["userId"] == null
            ? null
            : OrderHistoryDatumAttributesUserId.fromJson(json["userId"]),
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar == null ? null : avatar,
        "dateOfBirth": dateOfBirth == null ? null : dateOfBirth,
        "currentLocation": currentLocation == null ? null : currentLocation,
        "currentLongitude": currentLongitude == null ? null : currentLongitude,
        "currentLatitude": currentLatitude == null ? null : currentLatitude,
        "stateOfOrigin": stateOfOrigin == null ? null : stateOfOrigin,
        "stateOfResidence": stateOfResidence == null ? null : stateOfResidence,
        "residentialAddress":
            residentialAddress == null ? null : residentialAddress,
        "phone": phone == null ? null : phone,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "publishedAt":
            publishedAt == null ? null : publishedAt!.toIso8601String(),
        "status": status == null ? null : status,
        "cost": cost == null ? null : cost,
        "userId": userID == null ? null : userID!.toJson(),
      };
}

class OrderHistoryDatumAttributesUserId {
  OrderHistoryDatumAttributesUserId({
    this.data,
  });

  final UserIdData? data;

  factory OrderHistoryDatumAttributesUserId.fromJson(
          Map<String, dynamic> json) =>
      OrderHistoryDatumAttributesUserId(
        data: json["data"] == null ? null : UserIdData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class UserIdData {
  UserIdData({
    this.id,
    this.attributes,
  });

  final int? id;
  final FluffyAttributes? attributes;

  factory UserIdData.fromJson(Map<String, dynamic> json) => UserIdData(
        id: json["id"] == null ? null : json["id"],
        attributes: json["attributes"] == null
            ? null
            : FluffyAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "attributes": attributes == null ? null : attributes!.toJson(),
      };
}

class FluffyAttributes {
  FluffyAttributes({
    this.username,
    this.email,
    this.provider,
    this.confirmed,
    this.blocked,
    this.zebrraId,
    this.middleName,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.userType,
    this.isAdmin,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.ssoToken,
    this.zebrraUserId,
    this.dateOfBirth,
    this.about,
    this.onBoardingSteps,
    this.status,
    this.expiryTime,
    this.state,
    this.reasonForSuspension,
    this.suspensionStartDate,
    this.suspensionEndDate,
  });

  final String? username;
  final String? email;
  final String? provider;
  final bool? confirmed;
  final bool? blocked;
  final String? zebrraId;
  final String? middleName;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? address;
  final String? userType;
  final bool? isAdmin;
  final dynamic avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? ssoToken;
  final dynamic zebrraUserId;
  final dynamic dateOfBirth;
  final String? about;
  final dynamic onBoardingSteps;
  final dynamic status;
  final dynamic expiryTime;
  final String? state;
  final dynamic reasonForSuspension;
  final dynamic suspensionStartDate;
  final dynamic suspensionEndDate;

  factory FluffyAttributes.fromJson(Map<String, dynamic> json) =>
      FluffyAttributes(
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        provider: json["provider"] == null ? null : json["provider"],
        confirmed: json["confirmed"] == null ? null : json["confirmed"],
        blocked: json["blocked"] == null ? null : json["blocked"],
        zebrraId: json["zebrraId"] == null ? null : json["zebrraId"],
        middleName: json["middleName"] == null ? null : json["middleName"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        address: json["address"] == null ? null : json["address"],
        userType: json["userType"] == null ? null : json["userType"],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        ssoToken: json["ssoToken"] == null ? null : json["ssoToken"],
        zebrraUserId: json["zebrraUserId"],
        dateOfBirth: json["dateOfBirth"],
        about: json["about"] == null ? null : json["about"],
        onBoardingSteps: json["onBoardingSteps"],
        status: json["status"],
        expiryTime: json["expiryTime"],
        state: json["state"] == null ? null : json["state"],
        reasonForSuspension: json["reasonForSuspension"],
        suspensionStartDate: json["suspensionStartDate"],
        suspensionEndDate: json["suspensionEndDate"],
      );

  Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "provider": provider == null ? null : provider,
        "confirmed": confirmed == null ? null : confirmed,
        "blocked": blocked == null ? null : blocked,
        "zebrraId": zebrraId == null ? null : zebrraId,
        "middleName": middleName == null ? null : middleName,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "address": address == null ? null : address,
        "userType": userType == null ? null : userType,
        "isAdmin": isAdmin == null ? null : isAdmin,
        "avatar": avatar,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "ssoToken": ssoToken == null ? null : ssoToken,
        "zebrraUserId": zebrraUserId,
        "dateOfBirth": dateOfBirth,
        "about": about == null ? null : about,
        "onBoardingSteps": onBoardingSteps,
        "status": status,
        "expiryTime": expiryTime,
        "state": state == null ? null : state,
        "reasonForSuspension": reasonForSuspension,
        "suspensionStartDate": suspensionStartDate,
        "suspensionEndDate": suspensionEndDate,
      };
}

class Meta {
  Meta({
    this.pagination,
  });

  final Pagination? pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination == null ? null : pagination!.toJson(),
      };
}

class Pagination {
  Pagination({
    this.page,
    this.pageSize,
    this.pageCount,
    this.total,
  });

  final int? page;
  final int? pageSize;
  final int? pageCount;
  final int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"] == null ? null : json["page"],
        pageSize: json["pageSize"] == null ? null : json["pageSize"],
        pageCount: json["pageCount"] == null ? null : json["pageCount"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "page": page == null ? null : page,
        "pageSize": pageSize == null ? null : pageSize,
        "pageCount": pageCount == null ? null : pageCount,
        "total": total == null ? null : total,
      };
}
