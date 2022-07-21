import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/app_settings.dart';

class SignupModel {
  SignupModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
    this.userType,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;
  String? userType;

  //exclusive to merchant
  SignupModel.toCompanyData(
      {this.name,
      this.email,
      this.phoneNumber,
      this.rcNumber,
      this.cacDocument});

  String? name;
  String? rcNumber;
  String? cacDocument;

  Map<String, dynamic> toJson() => {
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "password": password == null ? null : password,
        "userType": userType == null ? null : userType
      };

  Future<Map<String, dynamic>> toAddCompanyInfoJson() async {
    AppSettings appSettings = await appSettingsBloc.fetchAppSettings();
    Map<String, dynamic> map = {
      "data": {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "rcNumber": rcNumber,
        "cacDocument": cacDocument,
        "userId": appSettings.loginResponse?.data?.user?.id ?? ''
        // "cacDocument": cacDocument,
      }
    };
    return map;
  }
}
