class SignupModel {
  SignupModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
    this.userType,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? userType;

  Map<String, dynamic> toJson() => {
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "password": password == null ? null : password,
        "userType": userType == null ? null : userType
      };
}
