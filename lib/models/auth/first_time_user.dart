import 'dart:convert';
import 'package:hive/hive.dart';

part 'first_time_user.g.dart';


FirstTimeUser firstTimeFromJson(String str) => FirstTimeUser.fromJson(json.decode(str));

String firstTimeToJson(FirstTimeUser data) => json.encode(data.toJson());

@HiveType(typeId: 1)

class FirstTimeUser {
  FirstTimeUser({
    this.firstTimeUserBool,
  });

  @HiveField(0)
  bool? firstTimeUserBool;

  factory FirstTimeUser.fromJson(Map<String, dynamic> json) => FirstTimeUser(
    firstTimeUserBool: json["bool"],
  );

  Map<String, dynamic> toJson() => {
    "bool": firstTimeUserBool,
  };
}


