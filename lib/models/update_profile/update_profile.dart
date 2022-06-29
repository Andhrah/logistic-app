// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
    UpdateProfileModel({
        required this.firstName,
        required this.lastName,
        required this.phoneNumber,
        required this.address,
    });

    final String firstName;
    final String lastName;
    final String phoneNumber;
    final String address;

    factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "address": address,
    };
}



// // To parse this JSON data, do
// //
// //     final updateProfile = updateProfileFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// UpdateProfile updateProfileFromJson(String str) => UpdateProfile.fromJson(json.decode(str));

// String updateProfileToJson(UpdateProfile data) => json.encode(data.toJson());

// class UpdateProfile {
//     UpdateProfile({
//         required this.data,
//     });

//     final Data data;

//     factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data.toJson(),
//     };
// }

// class Data {
//     Data({
//         required this.firstName,
//         required this.lastName,
//         required this.phoneNumber,
//         required this.email,
//         required this.address,
//     });

//     final String firstName;
//     final String lastName;
//     final String phoneNumber;
//     final String email;
//     final String address;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         phoneNumber: json["phoneNumber"],
//         email: json["email"],
//         address: json["address"],
//     );

//     Map<String, dynamic> toJson() => {
//         "firstName": firstName,
//         "lastName": lastName,
//         "phoneNumber": phoneNumber,
//         "email": email,
//         "address": address,
//     };
// }
