class CustomerOrderListenerResponse {
  CustomerOrderListenerResponse({
    this.info,
  });

  final CustomerOrderListenerInfo? info;

  CustomerOrderListenerResponse copyWith({
    CustomerOrderListenerInfo? info,
  }) =>
      CustomerOrderListenerResponse(
        info: info ?? this.info,
      );

  factory CustomerOrderListenerResponse.fromJson(Map<String, dynamic> json) =>
      CustomerOrderListenerResponse(
        info: json["info"] == null
            ? null
            : CustomerOrderListenerInfo.fromJson(json["info"]),
      );

  Map<String, dynamic> toJson() => {
        "info": info == null ? null : info!.toJson(),
      };
}

class CustomerOrderListenerInfo {
  CustomerOrderListenerInfo({
    this.riderId,
    this.orderId,
    this.currentLatitude,
    this.currentLongitude,
    this.currentLocation,
  });

  final String? riderId;
  final String? orderId;
  final String? currentLatitude;
  final String? currentLongitude;
  final String? currentLocation;

  CustomerOrderListenerInfo copyWith({
    String? riderId,
    String? orderId,
    String? currentLatitude,
    String? currentLongitude,
    String? currentLocation,
  }) =>
      CustomerOrderListenerInfo(
        riderId: riderId ?? this.riderId,
        orderId: orderId ?? this.orderId,
        currentLatitude: currentLatitude ?? this.currentLatitude,
        currentLongitude: currentLongitude ?? this.currentLongitude,
        currentLocation: currentLocation ?? this.currentLocation,
      );

  factory CustomerOrderListenerInfo.fromJson(Map<String, dynamic> json) =>
      CustomerOrderListenerInfo(
        riderId: json["riderId"] == null ? null : json["riderId"].toString(),
        orderId: json["orderId"] == null ? null : json["orderId"].toString(),
        currentLatitude: json["currentLatitude"] == null
            ? null
            : json["currentLatitude"].toString(),
        currentLongitude: json["currentLongitude"] == null
            ? null
            : json["currentLongitude"].toString(),
        currentLocation: json["currentLocation"] == null
            ? null
            : json["currentLocation"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "riderId": riderId == null ? null : riderId,
        "orderId": orderId == null ? null : orderId,
        "currentLatitude": currentLatitude == null ? null : currentLatitude,
        "currentLongitude": currentLongitude == null ? null : currentLongitude,
        "currentLocation": currentLocation == null ? null : currentLocation,
      };
}
