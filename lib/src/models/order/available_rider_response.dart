import 'package:trakk/src/models/merchant/get_riders_for_merchant_response.dart';
import 'package:trakk/src/models/merchant/get_vehicles_for_merchant_response.dart';

class AvailableRiderResponse {
  AvailableRiderResponse({
    this.status,
    this.data,
  });

  final String? status;
  final AvailableRiderData? data;

  factory AvailableRiderResponse.fromJson(Map<String, dynamic> json) =>
      AvailableRiderResponse(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : AvailableRiderData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data!.toJson(),
      };
}

class AvailableRiderData {
  AvailableRiderData({this.riders, this.message});

  final List<AvailableRiderDataRider>? riders;
  final String? message;

  factory AvailableRiderData.fromJson(Map<String, dynamic> json) =>
      AvailableRiderData(
          riders: json["riders"] == null
              ? null
              : List<AvailableRiderDataRider>.from(json["riders"]
                  .map((x) => AvailableRiderDataRider.fromJson(x))),
          message: json['message'] == null ? null : json['message']);

  Map<String, dynamic> toJson() => {
        "riders": riders == null
            ? null
            : List<dynamic>.from(riders!.map((x) => x.toJson())),
        'message': message == null ? null : message,
      };
}

class AvailableRiderDataRider {
  AvailableRiderDataRider({
    this.id,
    this.avatar,
    this.firstName,
    this.lastName,
    this.email,
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
    this.merchantId,
    this.distanceInKm,
    this.distanceBtwPickupToDeliveryInKm,
  });

  final int? id;
  final String? avatar;
  final String? firstName;
  final String? lastName;
  final String? email;
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
  final dynamic userId;
  final List<GetVehiclesDatumAttributes>? vehicles;
  final List<dynamic>? ratings;
  final List<dynamic>? nextOfKins;
  final MerchantId? merchantId;
  final double? distanceInKm;
  final double? distanceBtwPickupToDeliveryInKm;

  factory AvailableRiderDataRider.fromJson(Map<String, dynamic> json) =>
      AvailableRiderDataRider(
        id: json["id"] == null ? null : json["id"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        email: json["email"] == null ? null : json["email"],
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
        userId: json["userId"],
        vehicles: json["vehicles"] == null
            ? null
            : List<GetVehiclesDatumAttributes>.from(json["vehicles"]
                .map((x) => GetVehiclesDatumAttributes.fromJson(x))),
        ratings: json["ratings"] == null
            ? null
            : List<dynamic>.from(json["ratings"].map((x) => x)),
        nextOfKins: json["nextOfKins"] == null
            ? null
            : List<dynamic>.from(json["nextOfKins"].map((x) => x)),
        merchantId: json["merchantId"] == null
            ? null
            : MerchantId.fromJson(json["merchantId"]),
        distanceInKm: json["distanceInKm"] == null
            ? null
            : json["distanceInKm"].toDouble(),
        distanceBtwPickupToDeliveryInKm:
            json["distanceBtwPickupToDeliveryInKm"] == null
                ? null
                : json["distanceBtwPickupToDeliveryInKm"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "avatar": avatar == null ? null : avatar,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "email": email == null ? null : email,
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
        "userId": userId,
        "vehicles": vehicles == null
            ? null
            : List<dynamic>.from(vehicles!.map((x) => x.toJson())),
        "ratings":
            ratings == null ? null : List<dynamic>.from(ratings!.map((x) => x)),
        "nextOfKins": nextOfKins == null
            ? null
            : List<dynamic>.from(nextOfKins!.map((x) => x)),
        "merchantId": merchantId == null ? null : merchantId!.toJson(),
        "distanceInKm": distanceInKm == null ? null : distanceInKm,
        "distanceBtwPickupToDeliveryInKm":
            distanceBtwPickupToDeliveryInKm == null
                ? null
                : distanceBtwPickupToDeliveryInKm,
      };
}

class MerchantId {
  MerchantId({
    this.id,
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

  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? rcNumber;
  final String? cacDocument;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final double? amountPerKm;
  final double? baseFare;
  final double? priceCap;

  factory MerchantId.fromJson(Map<String, dynamic> json) => MerchantId(
        id: json["id"] == null ? null : json["id"],
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
        amountPerKm:
            json["amountPerKm"] == null ? null : json["amountPerKm"].toDouble(),
        baseFare: json["baseFare"] == null ? null : json["baseFare"].toDouble(),
        priceCap: json["priceCap"] == null ? null : json["priceCap"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "rcNumber": rcNumber == null ? null : rcNumber,
        "cacDocument": cacDocument == null ? null : cacDocument,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "publishedAt":
            publishedAt == null ? null : publishedAt!.toIso8601String(),
        "amountPerKm": amountPerKm == null ? null : amountPerKm,
        "baseFare": baseFare == null ? null : baseFare,
        "priceCap": priceCap == null ? null : priceCap,
      };
}
