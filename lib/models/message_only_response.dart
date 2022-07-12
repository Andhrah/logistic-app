import 'package:trakk/services/base_network_call_handler.dart';

class MessageOnlyResponse {
  String? message;

  final Err? err;

  MessageOnlyResponse({this.message, this.err}) {
    if (message == null && (err != null && err!.message != null)) {
      message = err!.message;
    }
  }

  factory MessageOnlyResponse.fromJson(Map<String, dynamic> json) =>
      MessageOnlyResponse(
        message: json["message"] ?? kNetworkGeneralText,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}

class Err {
  Err({
    this.message,
  });

  final String? message;

  factory Err.fromJson(Map<String, dynamic> json) => Err(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
