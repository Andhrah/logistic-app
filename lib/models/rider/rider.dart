class RiderModel {
  RiderModel({
    this.user,
    this.vehicle,
  });

  User? user;
  Vehicle? vehicle;

  factory RiderModel.fromJson(Map<String, dynamic> json) => RiderModel(
        user: User.fromJson(json["user"]),
        vehicle: Vehicle.fromJson(json["vehicle"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "vehicle": vehicle!.toJson(),
      };
}

class User {
  User({
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    // this.middleName,
    this.phoneNumber,
    this.nextOfKin,
    this.residentialAddress,
    this.stateOfOrigin,
    this.stateOfResidence,
    // this.address,
    // this.dateOfBirth,
  });

  String? email;
  String? password;
  String? firstName;
  String? lastName;
  // String? middleName;
  String? phoneNumber;
  NextOfKin? nextOfKin;
  String? residentialAddress;
  String? stateOfOrigin;
  String? stateOfResidence;
  // String? address;
  // DateTime? dateOfBirth;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        password: json["password"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        // middleName: json["middleName"],
        phoneNumber: json["phoneNumber"],
        nextOfKin: NextOfKin.fromJson(json["nextOfKin"]),
        residentialAddress: json["residentialAddress"],
        stateOfOrigin: json["stateOfOrigin"],
        stateOfResidence: json["stateOfResidence"],
        // address: json["address"],
        // dateOfBirth: DateTime.parse(json["dateOfBirth"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        // "middleName": middleName,
        "phoneNumber": phoneNumber,
        "nextOfKin": nextOfKin!.toJson(),
        "residentialAddress": residentialAddress,
        "stateOfOrigin": stateOfOrigin,
        "stateOfResidence": stateOfResidence,
        // "address": address,
        // "dateOfBirth": dateOfBirth!.toIso8601String(),
      };
}

class NextOfKin {
  NextOfKin({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.address,
    this.relationship,
  });

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? address;
  String? relationship;

  factory NextOfKin.fromJson(Map<String, dynamic> json) => NextOfKin(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        address: json["address"],
        relationship: json["relationship"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "relationship": relationship,
      };
}

class Vehicle {
  Vehicle({
    this.color,
    this.name,
    this.number,
    this.model,
    this.vehicleTypeId,
    this.capacity,
    this.documents,
  });

  String? color;
  String? name;
  String? number;
  String? model;
  int? vehicleTypeId;
  String? capacity;
  List<Document>? documents;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        color: json["color"],
        name: json["name"],
        number: json["number"],
        model: json["model"],
        vehicleTypeId: json["vehicleTypeId"],
        capacity: json["capacity"],
        documents: List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "name": name,
        "number": number,
        "model": model,
        "vehicleTypeId": vehicleTypeId,
        "capacity": capacity,
        "documents": List<dynamic>.from(documents!.map((x) => x.toJson())),
      };
}

class Document {
  Document({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
