class GetRidersForMerchantResponse {
  GetRidersForMerchantResponse({
    this.status,
    this.data,
    this.meta,
  });

  final String? status;
  final List<GetRidersForMerchantResponseDatum>? data;
  final Meta? meta;

  GetRidersForMerchantResponse copyWith({
    String? status,
    List<GetRidersForMerchantResponseDatum>? data,
    Meta? meta,
  }) =>
      GetRidersForMerchantResponse(
        status: status ?? this.status,
        data: data ?? this.data,
        meta: meta ?? this.meta,
      );

  factory GetRidersForMerchantResponse.fromJson(Map<String, dynamic> json) =>
      GetRidersForMerchantResponse(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<GetRidersForMerchantResponseDatum>.from(json["data"]
                .map((x) => GetRidersForMerchantResponseDatum.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta == null ? null : meta!.toJson(),
      };
}

class GetRidersForMerchantResponseDatum {
  GetRidersForMerchantResponseDatum({
    this.id,
    this.attributes,
  });

  final int? id;
  final GetRidersForMerchantPurpleAttributes? attributes;

  GetRidersForMerchantResponseDatum copyWith({
    int? id,
    GetRidersForMerchantPurpleAttributes? attributes,
  }) =>
      GetRidersForMerchantResponseDatum(
        id: id ?? this.id,
        attributes: attributes ?? this.attributes,
      );

  factory GetRidersForMerchantResponseDatum.fromJson(
          Map<String, dynamic> json) =>
      GetRidersForMerchantResponseDatum(
        id: json["id"] == null ? null : json["id"],
        attributes: json["attributes"] == null
            ? null
            : GetRidersForMerchantPurpleAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "attributes": attributes == null ? null : attributes!.toJson(),
      };
}

class GetRidersForMerchantPurpleAttributes {
  GetRidersForMerchantPurpleAttributes({
    this.avatar,
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
    this.userId,
    this.vehicles,
    this.ratings,
    this.nextOfKins,
    this.orders,
    this.merchantId,
  });

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
  final double? cost;
  final UserId? userId;
  final NextOfKins? vehicles;
  final NextOfKins? ratings;
  final NextOfKins? nextOfKins;
  final NextOfKins? orders;
  final MerchantId? merchantId;

  GetRidersForMerchantPurpleAttributes? copyWith({
    String? avatar,
    String? dateOfBirth,
    String? currentLocation,
    double? currentLongitude,
    double? currentLatitude,
    String? stateOfOrigin,
    String? stateOfResidence,
    String? residentialAddress,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
    String? status,
    double? cost,
    UserId? userId,
    NextOfKins? vehicles,
    NextOfKins? ratings,
    NextOfKins? nextOfKins,
    NextOfKins? orders,
    MerchantId? merchantId,
  }) =>
      GetRidersForMerchantPurpleAttributes(
        avatar: avatar ?? this.avatar,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        currentLocation: currentLocation ?? this.currentLocation,
        currentLongitude: currentLongitude ?? this.currentLongitude,
        currentLatitude: currentLatitude ?? this.currentLatitude,
        stateOfOrigin: stateOfOrigin ?? this.stateOfOrigin,
        stateOfResidence: stateOfResidence ?? this.stateOfResidence,
        residentialAddress: residentialAddress ?? this.residentialAddress,
        phone: phone ?? this.phone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        publishedAt: publishedAt ?? this.publishedAt,
        status: status ?? this.status,
        cost: cost ?? this.cost,
        userId: userId ?? this.userId,
        vehicles: vehicles ?? this.vehicles,
        ratings: ratings ?? this.ratings,
        nextOfKins: nextOfKins ?? this.nextOfKins,
        orders: orders ?? this.orders,
        merchantId: merchantId ?? this.merchantId,
      );

  factory GetRidersForMerchantPurpleAttributes.fromJson(
          Map<String, dynamic> json) =>
      GetRidersForMerchantPurpleAttributes(
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
        cost: json["cost"] == null ? null : json["cost"].toDouble(),
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
        vehicles: json["vehicles"] == null
            ? null
            : NextOfKins.fromJson(json["vehicles"]),
        ratings: json["ratings"] == null
            ? null
            : NextOfKins.fromJson(json["ratings"]),
        nextOfKins: json["nextOfKins"] == null
            ? null
            : NextOfKins.fromJson(json["nextOfKins"]),
        orders:
            json["orders"] == null ? null : NextOfKins.fromJson(json["orders"]),
        merchantId: json["merchantId"] == null
            ? null
            : MerchantId.fromJson(json["merchantId"]),
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
        "userId": userId == null ? null : userId!.toJson(),
        "vehicles": vehicles == null ? null : vehicles!.toJson(),
        "ratings": ratings == null ? null : ratings!.toJson(),
        "nextOfKins": nextOfKins == null ? null : nextOfKins!.toJson(),
        "orders": orders == null ? null : orders!.toJson(),
        "merchantId": merchantId == null ? null : merchantId!.toJson(),
      };
}

class MerchantId {
  MerchantId({
    this.data,
  });

  final MerchantIdData? data;

  MerchantId? copyWith({
    MerchantIdData? data,
  }) =>
      MerchantId(
        data: data ?? this.data,
      );

  factory MerchantId.fromJson(Map<String, dynamic> json) => MerchantId(
        data:
            json["data"] == null ? null : MerchantIdData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class MerchantIdData {
  MerchantIdData({
    this.id,
    this.attributes,
  });

  final int? id;
  final FluffyAttributes? attributes;

  MerchantIdData copyWith({
    int? id,
    FluffyAttributes? attributes,
  }) =>
      MerchantIdData(
        id: id ?? this.id,
        attributes: attributes ?? this.attributes,
      );

  factory MerchantIdData.fromJson(Map<String, dynamic> json) => MerchantIdData(
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
    this.name,
    this.email,
    this.phoneNumber,
    this.rcNumber,
    this.cacDocument,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.amountPerKm,
    this.baseFare,
    this.priceCap,
  });

  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? rcNumber;
  final String? cacDocument;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final dynamic amountPerKm;
  final dynamic baseFare;
  final dynamic priceCap;

  FluffyAttributes copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? rcNumber,
    String? cacDocument,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
    dynamic amountPerKm,
    dynamic baseFare,
    dynamic priceCap,
  }) =>
      FluffyAttributes(
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        rcNumber: rcNumber ?? this.rcNumber,
        cacDocument: cacDocument ?? this.cacDocument,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        publishedAt: publishedAt ?? this.publishedAt,
        amountPerKm: amountPerKm ?? this.amountPerKm,
        baseFare: baseFare ?? this.baseFare,
        priceCap: priceCap ?? this.priceCap,
      );

  factory FluffyAttributes.fromJson(Map<String, dynamic> json) =>
      FluffyAttributes(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        rcNumber: json["rcNumber"] == null ? null : json["rcNumber"],
        cacDocument: json["cacDocument"] == null ? null : json["cacDocument"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        amountPerKm: json["amountPerKm"],
        baseFare: json["baseFare"],
        priceCap: json["priceCap"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "rcNumber": rcNumber == null ? null : rcNumber,
        "cacDocument": cacDocument == null ? null : cacDocument,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "publishedAt":
            publishedAt == null ? null : publishedAt!.toIso8601String(),
        "amountPerKm": amountPerKm,
        "baseFare": baseFare,
        "priceCap": priceCap,
      };
}

class NextOfKins {
  NextOfKins({
    this.data,
  });

  final List<NextOfKinsDatum>? data;

  NextOfKins? copyWith({
    List<NextOfKinsDatum>? data,
  }) =>
      NextOfKins(
        data: data ?? this.data,
      );

  factory NextOfKins.fromJson(Map<String, dynamic> json) => NextOfKins(
        data: json["data"] == null
            ? null
            : List<NextOfKinsDatum>.from(
                json["data"].map((x) => NextOfKinsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NextOfKinsDatum {
  NextOfKinsDatum({
    this.id,
    this.attributes,
  });

  final int? id;
  final TentacledAttributes? attributes;

  NextOfKinsDatum copyWith({
    int? id,
    TentacledAttributes? attributes,
  }) =>
      NextOfKinsDatum(
        id: id ?? this.id,
        attributes: attributes ?? this.attributes,
      );

  factory NextOfKinsDatum.fromJson(Map<String, dynamic> json) =>
      NextOfKinsDatum(
        id: json["id"] == null ? null : json["id"],
        attributes: json["attributes"] == null
            ? null
            : TentacledAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "attributes": attributes == null ? null : attributes!.toJson(),
      };
}

class TentacledAttributes {
  TentacledAttributes({
    this.name,
    this.color,
    this.number,
    this.capacity,
    this.image,
    this.model,
    this.deliveryBox,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
  });

  final String? name;
  final String? color;
  final String? number;
  final String? capacity;
  final String? image;
  final String? model;
  final bool? deliveryBox;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;

  TentacledAttributes copyWith({
    String? name,
    String? color,
    String? number,
    String? capacity,
    String? image,
    String? model,
    bool? deliveryBox,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
  }) =>
      TentacledAttributes(
        name: name ?? this.name,
        color: color ?? this.color,
        number: number ?? this.number,
        capacity: capacity ?? this.capacity,
        image: image ?? this.image,
        model: model ?? this.model,
        deliveryBox: deliveryBox ?? this.deliveryBox,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        publishedAt: publishedAt ?? this.publishedAt,
      );

  factory TentacledAttributes.fromJson(Map<String, dynamic> json) =>
      TentacledAttributes(
        name: json["name"] == null ? null : json["name"],
        color: json["color"] == null ? null : json["color"],
        number: json["number"] == null ? null : json["number"],
        capacity: json["capacity"] == null ? null : json["capacity"],
        image: json["image"] == null ? null : json["image"],
        model: json["model"] == null ? null : json["model"],
        deliveryBox: json["deliveryBox"] == null ? null : json["deliveryBox"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "color": color == null ? null : color,
        "number": number == null ? null : number,
        "capacity": capacity == null ? null : capacity,
        "image": image == null ? null : image,
        "model": model == null ? null : model,
        "deliveryBox": deliveryBox == null ? null : deliveryBox,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "publishedAt":
            publishedAt == null ? null : publishedAt!.toIso8601String(),
      };
}

class UserId {
  UserId({
    this.data,
  });

  final UserIdData? data;

  UserId? copyWith({
    UserIdData? data,
  }) =>
      UserId(
        data: data ?? this.data,
      );

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
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
  final StickyAttributes? attributes;

  UserIdData copyWith({
    int? id,
    StickyAttributes? attributes,
  }) =>
      UserIdData(
        id: id ?? this.id,
        attributes: attributes ?? this.attributes,
      );

  factory UserIdData.fromJson(Map<String, dynamic> json) => UserIdData(
        id: json["id"] == null ? null : json["id"],
        attributes: json["attributes"] == null
            ? null
            : StickyAttributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "attributes": attributes == null ? null : attributes!.toJson(),
      };
}

class StickyAttributes {
  StickyAttributes({
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
  final dynamic about;
  final OnBoardingSteps? onBoardingSteps;
  final String? status;
  final String? expiryTime;
  final dynamic state;
  final String? reasonForSuspension;
  final String? suspensionStartDate;
  final String? suspensionEndDate;

  StickyAttributes copyWith({
    String? username,
    String? email,
    String? provider,
    bool? confirmed,
    bool? blocked,
    String? zebrraId,
    String? middleName,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? address,
    String? userType,
    bool? isAdmin,
    dynamic avatar,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? ssoToken,
    dynamic zebrraUserId,
    dynamic dateOfBirth,
    dynamic about,
    OnBoardingSteps? onBoardingSteps,
    String? status,
    String? expiryTime,
    dynamic state,
    String? reasonForSuspension,
    String? suspensionStartDate,
    String? suspensionEndDate,
  }) =>
      StickyAttributes(
        username: username ?? this.username,
        email: email ?? this.email,
        provider: provider ?? this.provider,
        confirmed: confirmed ?? this.confirmed,
        blocked: blocked ?? this.blocked,
        zebrraId: zebrraId ?? this.zebrraId,
        middleName: middleName ?? this.middleName,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        userType: userType ?? this.userType,
        isAdmin: isAdmin ?? this.isAdmin,
        avatar: avatar ?? this.avatar,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        ssoToken: ssoToken ?? this.ssoToken,
        zebrraUserId: zebrraUserId ?? this.zebrraUserId,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        about: about ?? this.about,
        onBoardingSteps: onBoardingSteps ?? this.onBoardingSteps,
        status: status ?? this.status,
        expiryTime: expiryTime ?? this.expiryTime,
        state: state ?? this.state,
        reasonForSuspension: reasonForSuspension ?? this.reasonForSuspension,
        suspensionStartDate: suspensionStartDate ?? this.suspensionStartDate,
        suspensionEndDate: suspensionEndDate ?? this.suspensionEndDate,
      );

  factory StickyAttributes.fromJson(Map<String, dynamic> json) =>
      StickyAttributes(
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
        avatar: json["avatar"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        ssoToken: json["ssoToken"] == null ? null : json["ssoToken"],
        zebrraUserId: json["zebrraUserId"],
        dateOfBirth: json["dateOfBirth"],
        about: json["about"],
        onBoardingSteps: json["onBoardingSteps"] == null
            ? null
            : OnBoardingSteps.fromJson(json["onBoardingSteps"]),
        status: json["status"] == null ? null : json["status"],
        expiryTime: json["expiryTime"] == null ? null : json["expiryTime"],
        state: json["state"],
        reasonForSuspension: json["reasonForSuspension"] == null
            ? null
            : json["reasonForSuspension"],
        suspensionStartDate: json["suspensionStartDate"] == null
            ? null
            : json["suspensionStartDate"],
        suspensionEndDate: json["suspensionEndDate"] == null
            ? null
            : json["suspensionEndDate"],
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
        "about": about,
        "onBoardingSteps":
            onBoardingSteps == null ? null : onBoardingSteps!.toJson(),
        "status": status == null ? null : status,
        "expiryTime": expiryTime == null ? null : expiryTime,
        "state": state,
        "reasonForSuspension":
            reasonForSuspension == null ? null : reasonForSuspension,
        "suspensionStartDate":
            suspensionStartDate == null ? null : suspensionStartDate,
        "suspensionEndDate":
            suspensionEndDate == null ? null : suspensionEndDate,
      };
}

class OnBoardingSteps {
  OnBoardingSteps();

  factory OnBoardingSteps.fromJson(Map<String, dynamic> json) =>
      OnBoardingSteps();

  Map<String, dynamic> toJson() => {};
}

class Meta {
  Meta({
    this.pagination,
  });

  final Pagination? pagination;

  Meta? copyWith({
    Pagination? pagination,
  }) =>
      Meta(
        pagination: pagination ?? this.pagination,
      );

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

  Pagination copyWith({
    int? page,
    int? pageSize,
    int? pageCount,
    int? total,
  }) =>
      Pagination(
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        pageCount: pageCount ?? this.pageCount,
        total: total ?? this.total,
      );

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
