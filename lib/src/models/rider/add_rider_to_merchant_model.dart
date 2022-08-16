import 'dart:io';

class AddRiderToMerchantModel {
  AddRiderToMerchantModel({
    this.data,
  });

  final AddRiderToMerchantModelData? data;

  AddRiderToMerchantModel copyWith({
    AddRiderToMerchantModelData? data,
  }) =>
      AddRiderToMerchantModel(
        data: data ?? this.data,
      );

  factory AddRiderToMerchantModel.fromJson(Map<String, dynamic> json) =>
      AddRiderToMerchantModel(
        data: json["data"] == null
            ? null
            : AddRiderToMerchantModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson({bool isToServer = false}) => {
        "data": data == null ? null : data!.toJson(isToServer: isToServer),
      };

  Map<String, dynamic> toAddRiderToServerJson() => {
        "data": data == null ? null : data!.toAddRiderToServerJson(),
      };
}

class AddRiderToMerchantModelData {
  AddRiderToMerchantModelData({
    this.profilePicFile,
    this.firstName,
    this.lastName,
    this.email,
    this.userId,
    this.riderId,
    this.riderRootId,
    this.merchantId,
    this.avatar,
    this.dateOfBirth,
    this.currentLocation,
    this.stateOfOrigin,
    this.stateOfResidence,
    this.residentialAddress,
    this.phone,
    this.password,
    this.status,
    this.currentLatitude,
    this.currentLongitude,
  });

  final File? profilePicFile;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? userId;
  final String? riderId;
  final String? riderRootId;
  final String? merchantId;
  final String? avatar;
  final String? dateOfBirth;
  final String? currentLocation;
  final String? stateOfOrigin;
  final String? stateOfResidence;
  final String? residentialAddress;
  final String? phone;
  final String? password;
  final String? status;
  final double? currentLatitude;
  final double? currentLongitude;

  AddRiderToMerchantModelData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? userId,
    String? riderId,
    String? riderRootId,
    String? merchantId,
    String? avatar,
    String? dateOfBirth,
    String? currentLocation,
    String? stateOfOrigin,
    String? stateOfResidence,
    String? residentialAddress,
    String? phone,
    String? password,
    String? status,
    double? currentLatitude,
    double? currentLongitude,
  }) =>
      AddRiderToMerchantModelData(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        userId: userId ?? this.userId,
        riderId: riderId ?? this.riderId,
        riderRootId: riderRootId ?? this.riderRootId,
        merchantId: merchantId ?? this.merchantId,
        avatar: avatar ?? this.avatar,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        currentLocation: currentLocation ?? this.currentLocation,
        stateOfOrigin: stateOfOrigin ?? this.stateOfOrigin,
        stateOfResidence: stateOfResidence ?? this.stateOfResidence,
        residentialAddress: residentialAddress ?? this.residentialAddress,
        phone: phone ?? this.phone,
        status: status ?? this.status,
        password: password ?? this.password,
        currentLatitude: currentLatitude ?? this.currentLatitude,
        currentLongitude: currentLongitude ?? this.currentLongitude,
      );

  factory AddRiderToMerchantModelData.fromJson(Map<String, dynamic> json) =>
      AddRiderToMerchantModelData(
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        email: json["email"] == null ? null : json["email"],
        userId: json["userId"] == null ? null : json["userId"],
        merchantId: json["merchantId"] == null ? null : json["merchantId"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        dateOfBirth: json["dateOfBirth"] == null ? null : json["dateOfBirth"],
        currentLocation:
            json["currentLocation"] == null ? null : json["currentLocation"],
        stateOfOrigin:
            json["stateOfOrigin"] == null ? null : json["stateOfOrigin"],
        stateOfResidence:
            json["stateOfResidence"] == null ? null : json["stateOfResidence"],
        residentialAddress: json["residentialAddress"] == null
            ? null
            : json["residentialAddress"],
        phone: json["phone"] == null ? null : json["phone"],
        password: json["password"] == null ? null : json["password"],
        status: json["status"] == null ? null : json["status"],
        currentLatitude: json["currentLatitude"] == null
            ? null
            : json["currentLatitude"].toDouble(),
        currentLongitude: json["currentLongitude"] == null
            ? null
            : json["currentLongitude"].toDouble(),
      );

  Map<String, dynamic> toJson({bool isToServer = false}) {
    Map<String, dynamic> map = {
      "firstName": firstName == null ? null : firstName,
      "lastName": lastName == null ? null : lastName,
      "email": email == null ? null : email,
      "userId": userId == null ? null : userId,
      "merchantId": merchantId == null ? null : merchantId,
      "avatar": avatar == null ? null : avatar,
      "dateOfBirth": dateOfBirth == null ? null : dateOfBirth,
      "currentLocation": currentLocation == null ? null : currentLocation,
      "stateOfOrigin": stateOfOrigin == null ? null : stateOfOrigin,
      "stateOfResidence": stateOfResidence == null ? null : stateOfResidence,
      if (isToServer)
        "address": residentialAddress == null ? null : residentialAddress
      else
        "residentialAddress":
            residentialAddress == null ? null : residentialAddress,
      "phone": phone == null ? null : phone,
      "password": password == null ? null : password,
      "status": status == null ? null : status,
      "currentLatitude": currentLatitude == null ? null : currentLatitude,
      "currentLongitude": currentLongitude == null ? null : currentLongitude,
    };
    map.removeWhere((key, value) =>
        (value == null || (value != null && value.toString().isEmpty)));
    return map;
  }

  Map<String, dynamic> toAddRiderToServerJson() {
    Map<String, dynamic> map = {
      "userId": userId == null ? null : userId,
      "merchantId": merchantId == null ? null : merchantId,
      "avatar": avatar == null ? null : avatar,
      "dateOfBirth": dateOfBirth == null ? null : dateOfBirth,
      "currentLocation": currentLocation == null ? null : currentLocation,
      "stateOfOrigin": stateOfOrigin == null ? null : stateOfOrigin,
      "stateOfResidence": stateOfResidence == null ? null : stateOfResidence,
      "residentialAddress":
          residentialAddress == null ? null : residentialAddress,
      "phone": phone == null ? null : phone,
      "status": status == null ? null : status,
      "currentLatitude": currentLatitude == null ? null : currentLatitude,
      "currentLongitude": currentLongitude == null ? null : currentLongitude,
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
