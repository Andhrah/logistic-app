import 'dart:io';

class AddVehicleToMerchantModel {
  AddVehicleToMerchantModel({
    this.data,
  });

  final AddRiderToMerchantData? data;

  AddVehicleToMerchantModel copyWith({
    AddRiderToMerchantData? data,
  }) =>
      AddVehicleToMerchantModel(
        data: data ?? this.data,
      );

  factory AddVehicleToMerchantModel.fromJson(Map<String, dynamic> json) =>
      AddVehicleToMerchantModel(
        data: json["data"] == null
            ? null
            : AddRiderToMerchantData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data!.toJson(),
      };
  Map<String, dynamic> toAddDocJson() => {
        "data": data == null ? null : data!.toJson(),
      };
}

class AddRiderToMerchantData {
  AddRiderToMerchantData(
      {this.riderId,
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
          {String? riderId,
          String? name,
          String? color,
          String? number,
          String? capacity,
          String? image,
          String? model,
          bool? deliveryBox,
          String? vehicleId,
          String? documentName,
          String? documentUrl}) =>
      AddRiderToMerchantData(
        riderId: riderId ?? this.riderId,
        name: name ?? this.name,
        color: color ?? this.color,
        number: number ?? this.number,
        capacity: capacity ?? this.capacity,
        image: image ?? this.image,
        model: model ?? this.model,
      );

  factory AddRiderToMerchantData.fromJson(Map<String, dynamic> json) =>
      AddRiderToMerchantData(
        riderId: json["riderId"] == null ? null : json["riderId"],
        name: json["name"] == null ? null : json["name"],
        color: json["color"] == null ? null : json["color"],
        number: json["number"] == null ? null : json["number"],
        capacity: json["capacity"] == null ? null : json["capacity"],
        image: json["image"] == null ? null : json["image"],
        model: json["model"] == null ? null : json["model"],
        deliveryBox: json["deliveryBox"] == null ? null : json["deliveryBox"],
      );

  Map<String, dynamic> toJson() => {
        "riderId": riderId == null ? null : riderId,
        "name": name == null ? null : name,
        "color": color == null ? null : color,
        "number": number == null ? null : number,
        "capacity": capacity == null ? null : capacity,
        "image": image == null ? null : image,
        "model": model == null ? null : model,
        "deliveryBox": deliveryBox == null ? null : deliveryBox,
      };
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
