import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:trakk/Exceptions/api_failure_exception.dart';
import 'package:trakk/services/merchant/company_data_service.dart';

class AddCompanyDataProvider extends ChangeNotifier {
  final AddCompanyDataService _api = AddCompanyDataService();

  static AddCompanyDataProvider authProvider(BuildContext context, {bool listen = false}) {
    return Provider.of<AddCompanyDataProvider>(context, listen: listen);
  }

  Future addCompanyData(String name, String email, String phoneNumber, String rcNumber, String cacDocument
   ) async {
    var box = await Hive.openBox('appState');
    var token = await box.get("token");
    try {
      var response = await _api.addCompanyData(
        token,
        name,
        email,
        phoneNumber,
        rcNumber,
        cacDocument
      );
      return response;
    } catch(err) {
      throw ApiFailureException(err);
    }
  }
}
