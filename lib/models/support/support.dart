// To parse this JSON data, do
//
//     final support = supportFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SupportModel supportFromJson(String str) => SupportModel.fromJson(json.decode(str));

String supportToJson(SupportModel data) => json.encode(data.toJson());

class SupportModel {
    SupportModel({
        required this.name,
        required this.email,
        required this.message,
    });

    final String name;
    final String email;
    final String message;

    factory SupportModel.fromJson(Map<String, dynamic> json) => SupportModel(
        name: json["name"],
        email: json["email"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "message": message,
    };
}
