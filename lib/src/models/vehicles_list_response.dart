// class VehiclesListResponse {
//   VehiclesListResponse({
//     this.data,
//   });
//
//   final List<VehiclesList>? data;
//
//   factory VehiclesListResponse.fromJson(Map<String, dynamic> json) =>
//       VehiclesListResponse(
//         data: json["data"] == null
//             ? null
//             : List<VehiclesList>.from(
//                 json["data"].map((x) => VehiclesList.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": data == null
//             ? null
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }
//
// class VehiclesList {
//   VehiclesList({
//     this.name,
//     this.number,
//   });
//
//   String? name;
//   String? number;
//
//   factory VehiclesList.fromJson(Map<String, dynamic> json) => VehiclesList(
//         name: json["name"],
//         number: json["number"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "number": number,
//       };
// }
