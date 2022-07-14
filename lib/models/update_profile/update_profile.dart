class UpdateProfile {
  UpdateProfile({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.address,
  });

  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? address;

  factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
      };
}
