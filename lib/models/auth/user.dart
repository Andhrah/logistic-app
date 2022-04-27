// To parse this JSON data, do
//
//     final authUser = authUserFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'user.g.dart';

User authUserFromJson(String str) => User.fromJson(json.decode(str));

String authUserToJson(User data) => json.encode(data.toJson());

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  int id;
  @HiveField(1)
  bool status;
  @HiveField(2)
  String zebrraId;
  @HiveField(3)
  String firstName;
  @HiveField(4)
  String lastName;
  @HiveField(5)
  String email;
  @HiveField(6)
  String phoneNumber;
  @HiveField(7)
  String message;
  @HiveField(8)
  int code;
  @HiveField(9)
  String fullName;

  User({
    required this.id,
    required this.status,
    required this.zebrraId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.message,
    required this.code,
    required this.fullName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    status: json["status"],
    zebrraId: json["zebrraId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    message: json["message"],
    code: json["code"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "zebrraId": zebrraId,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phoneNumer": phoneNumber,
    "message": message,
    "code": code,
    "fullName": fullName,
  };
}

// class Merchant {
//   Merchant({
//     this.businessidid,
//     this.shortid,
//     this.businessname,
//     this.contactfirstname,
//     this.contactlastname,
//     this.publickey,
//   });

//   String businessidid;
//   String shortid;
//   String businessname;
//   String contactfirstname;
//   String contactlastname;
//   String publickey;

//   factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
//         businessidid: json["businessidid"],
//         shortid: json["shortid"],
//         businessname: json["businessname"],
//         contactfirstname: json["contactfirstname"],
//         contactlastname: json["contactlastname"],
//         publickey: json["publickey"],
//       );

//   Map<String, dynamic> toJson() => {
//         "businessidid": businessidid,
//         "shortid": shortid,
//         "businessname": businessname,
//         "contactfirstname": contactfirstname,
//         "contactlastname": contactlastname,
//         "publickey": publickey,
//       };
// }
