import 'dart:ui';

import 'package:trakk/src/utils/helper_utils.dart';
import 'package:trakk/src/values/enums.dart';

class AuthResponse {
  AuthResponse({this.data, this.message});

  final AuthData? data;
  final String? message;

  AuthResponse copyWith({AuthData? data, String? message}) {
    return AuthResponse(
        data: data ?? this.data, message: message ?? this.message);
  }

  @override
  String toString() {
    return '$runtimeType';
  }

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
      data: json["data"] == null ? null : AuthData.fromJson(json["data"]),
      message: json["message"] == null ? null : json["message"]);

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
        'message': message == null ? null : message
      };
}

class AuthData {
  AuthData({
    this.token,
    this.refreshToken,
    this.user,
    this.ssoToken,
  });

  String? token;
  String? refreshToken;
  User? user;
  final String? ssoToken;

  AuthData copyWith(
      {String? token, String? refreshToken, User? user, String? ssoToken}) {
    return AuthData(
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
      ssoToken: ssoToken ?? this.ssoToken,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final AuthData typedOther = other;
    return token == typedOther.token &&
        refreshToken == typedOther.refreshToken &&
        user == typedOther.user &&
        ssoToken == typedOther.ssoToken;
  }

  @override
  int get hashCode => hashValues(token, refreshToken, user, ssoToken);

  @override
  String toString() {
    return '$runtimeType';
  }

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
        token: json["jwt"],
        refreshToken: json["refreshToken"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        ssoToken: json["ssoToken"],
      );

  factory AuthData.fromJsonWithData(Map<String, dynamic> json) => AuthData(
        user: json["data"] == null ? null : User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "jwt": token,
        "refreshToken": refreshToken,
        "user": user == null ? null : user!.toJson(),
        "ssoToken": ssoToken,
      };
}

class User {
  User({
    this.id,
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
    this.beneficiaries,
    this.rider,
    this.orders,
    this.merchant,
  });

  final int? id;
  final String? username;
  String? email;
  final String? provider;
  final bool? confirmed;
  final bool? blocked;
  final String? zebrraId;
  final String? middleName;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  final String? userType;
  final bool? isAdmin;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? ssoToken;
  final String? zebrraUserId;
  final String? dateOfBirth;
  final String? about;
  final OnBoardingSteps? onBoardingSteps;
  final String? status;
  final String? expiryTime;
  final String? state;
  final String? reasonForSuspension;
  final String? suspensionStartDate;
  final String? suspensionEndDate;
  final List<dynamic>? beneficiaries;
  Rider? rider;
  final List<dynamic>? orders;
  Merchant? merchant;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        zebrraId: json["zebrraId"],
        middleName: json["middleName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        userType: json["userType"],
        isAdmin: json["isAdmin"],
        avatar: json["avatar"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        ssoToken: json["ssoToken"],
        zebrraUserId: json["zebrraUserId"] == null
            ? null
            : json["zebrraUserId"].toString(),
        dateOfBirth: json["dateOfBirth"],
        about: json["about"],
        onBoardingSteps: json["onBoardingSteps"] == null
            ? null
            : OnBoardingSteps.fromJson(json["onBoardingSteps"]),
        status: json["status"],
        expiryTime: json["expiryTime"],
        state: json["state"],
        reasonForSuspension: json["reasonForSuspension"],
        suspensionStartDate: json["suspensionStartDate"],
        suspensionEndDate: json["suspensionEndDate"],
        beneficiaries: json["beneficiaries"] == null
            ? null
            : List<dynamic>.from(json["beneficiaries"].map((x) => x)),
        rider: json["rider"] == null ? null : Rider.fromJson(json["rider"]),
        orders: json["orders"] == null
            ? null
            : List<dynamic>.from(json["orders"].map((x) => x)),
        merchant: json["merchant"] == null
            ? null
            : Merchant.fromJson(json["merchant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        "zebrraId": zebrraId,
        "middleName": middleName,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "address": address,
        "userType": userType,
        "isAdmin": isAdmin,
        "avatar": avatar,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "ssoToken": ssoToken,
        "zebrraUserId": zebrraUserId,
        "dateOfBirth": dateOfBirth,
        "about": about,
        "onBoardingSteps":
            onBoardingSteps == null ? null : onBoardingSteps!.toJson(),
        "status": status,
        "expiryTime": expiryTime,
        "state": state,
        "reasonForSuspension": reasonForSuspension,
        "suspensionStartDate": suspensionStartDate,
        "suspensionEndDate": suspensionEndDate,
        "beneficiaries": beneficiaries == null
            ? null
            : List<dynamic>.from(beneficiaries!.map((x) => x)),
        "rider": rider == null ? null : rider!.toJson(),
        "orders":
            orders == null ? null : List<dynamic>.from(orders!.map((x) => x)),
        "merchant": merchant == null ? null : merchant!.toJson(),
      };

  UserType getUserType() {
    return userTypeDeterminant(userType ?? '');
  }
}

class OnBoardingSteps {
  final bool? riderContactCompleted;

  final bool? riderNOKCompleted;

  final bool? riderVehicleCompleted;

  OnBoardingSteps({
    this.riderContactCompleted,
    this.riderNOKCompleted,
    this.riderVehicleCompleted,
  });

  factory OnBoardingSteps.fromJson(Map<String, dynamic> json) =>
      OnBoardingSteps(
          riderContactCompleted: json['riderContactCompleted'] == null
              ? null
              : json['riderContactCompleted'],
          riderNOKCompleted: json['riderNOKCompleted'] == null
              ? null
              : json['riderNOKCompleted'],
          riderVehicleCompleted: json['riderVehicleCompleted'] == null
              ? null
              : json['riderVehicleCompleted']);

  Map<String, dynamic> toJson() => {
        'riderContactCompleted':
            riderContactCompleted == null ? null : riderContactCompleted,
        'riderNOKCompleted':
            riderNOKCompleted == null ? null : riderNOKCompleted,
        'riderVehicleCompleted':
            riderVehicleCompleted == null ? null : riderVehicleCompleted
      };
}

class Rider {
  Rider(
      {this.id,
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
      this.vehicles});

  final int? id;
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
  Vehicles? vehicles;

  factory Rider.fromJson(Map<String, dynamic> json) => Rider(
      id: json["id"],
      avatar: json["avatar"],
      dateOfBirth: json["dateOfBirth"],
      currentLocation: json["currentLocation"],
      currentLongitude: json["currentLongitude"] == null
          ? null
          : json["currentLongitude"].toDouble(),
      currentLatitude: json["currentLatitude"] == null
          ? null
          : json["currentLatitude"].toDouble(),
      stateOfOrigin: json["stateOfOrigin"],
      stateOfResidence: json["stateOfResidence"],
      residentialAddress: json["residentialAddress"],
      phone: json["phone"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      publishedAt: json["publishedAt"] == null
          ? null
          : DateTime.parse(json["publishedAt"]),
      status: json["status"],
      cost: json["cost"] == null ? null : json["cost"].toDouble(),
      vehicles: json['vehicles'] == null
          ? null
          : Vehicles.fromJson(json['vehicles']));

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "dateOfBirth": dateOfBirth,
        "currentLocation": currentLocation,
        "currentLongitude": currentLongitude,
        "currentLatitude": currentLatitude,
        "stateOfOrigin": stateOfOrigin,
        "stateOfResidence": stateOfResidence,
        "residentialAddress": residentialAddress,
        "phone": phone,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "publishedAt":
            publishedAt == null ? null : publishedAt!.toIso8601String(),
        "status": status,
        "cost": cost,
        "vehicles": vehicles == null ? null : vehicles!.toJson(),
      };
}

class Vehicles {
  Vehicles({
    this.name,
    this.number,
  });

  String? name;
  String? number;

  factory Vehicles.fromJson(Map<String, dynamic> json) => Vehicles(
        name: json["name"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
      };
}

class Merchant {
  Merchant({
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
  final dynamic amountPerKm;
  final dynamic baseFare;
  final dynamic priceCap;

  Merchant copyWith({
    int? id,
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
      Merchant(
        id: id ?? this.id,
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

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
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
        amountPerKm: json["amountPerKm"],
        baseFare: json["baseFare"],
        priceCap: json["priceCap"],
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
        "amountPerKm": amountPerKm,
        "baseFare": baseFare,
        "priceCap": priceCap,
      };
}
