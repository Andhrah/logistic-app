class UpdateProfile {
  UpdateProfile({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.address,
  });

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? address;

  UpdateProfile.riderNOK({
    this.riderId,
    this.nOKfullName,
    this.nOKaddress,
    this.nOKphoneNumber,
    this.nOKemail,
  });

  String? riderId;
  String? nOKfullName;
  String? nOKaddress;
  String? nOKphoneNumber;
  String? nOKemail;

  UpdateProfile.riderContact({
    this.stateOfOrigin,
    this.stateOfResidence,
    this.residentialAddress,
  });

  String? stateOfOrigin;
  String? stateOfResidence;
  String? residentialAddress;

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

  Map<String, dynamic> toUpdateRiderContactJson() {
    Map<String, dynamic> _map = {
      'data': {
        "stateOfOrigin": stateOfOrigin == null ? null : stateOfOrigin,
        "stateOfResidence": stateOfResidence == null ? null : stateOfResidence,
        "residentialAddress":
            residentialAddress == null ? null : residentialAddress,
      }
    };

    _map.removeWhere((key, value) => value == null);
    return _map;
  }

  Map<String, dynamic> toRiderNOKJson() {
    Map<String, dynamic> _map = {
      'data': {
        "riderId": riderId,
        "NOKfullName": nOKfullName,
        "NOKaddress": nOKaddress,
        "NOKphoneNumber": nOKphoneNumber,
        "NOKemail": nOKemail,
      }
    };

    _map.removeWhere((key, value) => value == null);
    return _map;
  }
}
