class VehicleRequest {
  VehicleRequest({
    this.data,
  });

  final AddRiderToMerchantData? data;

  VehicleRequest copyWith({
    AddRiderToMerchantData? data,
  }) =>
      VehicleRequest(
        data: data ?? this.data,
      );

  factory VehicleRequest.fromJson(Map<String, dynamic> json) => VehicleRequest(
        data: json["data"] == null
            ? null
            : AddRiderToMerchantData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class AddRiderToMerchantData {
  AddRiderToMerchantData(
      {this.merchantId,
      this.riderId,
      this.name,
      this.color,
      this.number,
      this.capacity,
      this.image,
      this.model,
      this.deliveryBox,
      this.files,

      //  doc
      this.docs});

  final String? merchantId;
  final String? riderId;
  final String? name;
  final String? color;
  final String? number;
  final String? capacity;
  final String? image;
  final String? model;
  final bool? deliveryBox;
  final Map<String, String>? files;

  //add doc
  List<AddVehicleDocToMerchantModel>? docs;

  AddRiderToMerchantData copyWith(
          {String? merchantId,
          String? riderId,
          String? name,
          String? color,
          String? number,
          String? capacity,
          String? image,
          String? model,
          bool? deliveryBox,
          String? vehicleId,
          String? documentName,
          String? documentUrl,
          Map<String, String>? files}) =>
      AddRiderToMerchantData(
          merchantId: merchantId ?? this.merchantId,
          riderId: riderId ?? this.riderId,
          name: name ?? this.name,
          color: color ?? this.color,
          number: number ?? this.number,
          capacity: capacity ?? this.capacity,
          image: image ?? this.image,
          model: model ?? this.model,
          deliveryBox: deliveryBox ?? this.deliveryBox,
          files: files ?? this.files);

  factory AddRiderToMerchantData.fromJson(Map<String, dynamic> json) =>
      AddRiderToMerchantData(
        merchantId: json["merchantId"] == null ? null : json["merchantId"],
        riderId: json["riderId"] == null ? null : json["riderId"],
        name: json["name"] == null ? null : json["name"],
        color: json["color"] == null ? null : json["color"],
        number: json["number"] == null ? null : json["number"],
        capacity: json["capacity"] == null ? null : json["capacity"],
        image: json["image"] == null ? null : json["image"],
        model: json["model"] == null ? null : json["model"],
        deliveryBox: json["deliveryBox"] == null ? null : json["deliveryBox"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "merchantId": merchantId == null ? null : merchantId,
      "riderId": riderId == null ? null : riderId,
      "name": name == null ? null : name,
      "color": color == null ? null : color,
      "number": number == null ? null : number,
      "capacity": capacity == null ? null : capacity,
      "image": image == null ? null : image,
      "model": model == null ? null : model,
      "deliveryBox": deliveryBox == null ? null : deliveryBox,
    };

    map.removeWhere((key, value) => value == null);
    return map;
  }
}

class AddVehicleDocToMerchantModel {
  AddVehicleDocToMerchantModel({
    this.vehicleId,
    this.documentName,
    this.documentUrl,
  });

  final String? vehicleId;
  final String? documentName;
  final String? documentUrl;

  Map<String, dynamic> toAddDocJson() => {
        "vehicleId": vehicleId == null ? null : vehicleId,
        "documentName": documentName == null ? null : documentName,
        "documentUrl": documentUrl == null ? null : documentUrl,
      };
}
