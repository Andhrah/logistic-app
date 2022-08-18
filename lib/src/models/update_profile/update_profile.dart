import 'dart:io';

class UpdateProfile {
  UpdateProfile(
      {this.avatar,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.address,
      this.profilePic});

  String? avatar;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? address;
  File? profilePic;

  UpdateProfile.riderNOK({
    this.riderId,
    this.nOKfullName,
    this.nOKaddress,
    this.nOKphoneNumber,
    this.nOKemail,
  });

  String? riderId;
  String? nOKfullName;
  String? nOKaddress;
  String? nOKphoneNumber;
  String? nOKemail;

  UpdateProfile.riderContact({
    this.stateOfOrigin,
    this.stateOfResidence,
    this.residentialAddress,
  });

  String? stateOfOrigin;
  String? stateOfResidence;
  String? residentialAddress;

  UpdateProfile.riderLocation({
    this.currentLocation,
    this.currentLatitude,
    this.currentLongitude,
  });

  String? currentLocation;
  double? currentLatitude;
  double? currentLongitude;

  factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "avatar": avatar,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "email": email,
      "address": address,
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }

  Map<String, dynamic> toUpdateRiderContactJson() {
    Map<String, dynamic> _map = {
      'data': {
        "stateOfOrigin": stateOfOrigin == null ? null : stateOfOrigin,
        "stateOfResidence": stateOfResidence == null ? null : stateOfResidence,
        "residentialAddress":
            residentialAddress == null ? null : residentialAddress,
      }
    };

    _map.removeWhere((key, value) => value == null);
    return _map;
  }

  Map<String, dynamic> toRiderNOKJson() {
    Map<String, dynamic> _map = {
      'data': {
        "riderId": riderId,
        "NOKfullName": nOKfullName,
        "NOKaddress": nOKaddress,
        "NOKphoneNumber": nOKphoneNumber,
        "NOKemail": nOKemail,
      }
    };

    _map.removeWhere((key, value) => value == null);
    return _map;
  }

  Map<String, dynamic> toRiderLocationJson() {
    Map<String, dynamic> _map = {
      'data': {
        "currentLocation": currentLocation,
        "currentLongitude": currentLongitude,
        "currentLatitude": currentLatitude,
      }
    };

    _map.removeWhere((key, value) => value == null);
    return _map;
  }
}
