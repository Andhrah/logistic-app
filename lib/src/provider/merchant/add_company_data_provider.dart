// import 'package:flutter/material.dart';
//
// import 'package:provider/provider.dart';
// import 'package:trakk/src/Exceptions/api_failure_exception.dart';
// import 'package:trakk/src/bloc/app_settings_bloc.dart';
// import 'package:trakk/src/models/app_settings.dart';
// import 'package:trakk/src/services/merchant/company_data_service.dart';
//
// class AddCompanyDataProvider extends ChangeNotifier {
//   final AddCompanyDataService _api = AddCompanyDataService();
//
//   static AddCompanyDataProvider authProvider(BuildContext context,
//       {bool listen = false}) {
//     return Provider.of<AddCompanyDataProvider>(context, listen: listen);
//   }
//
//   Future addCompanyData(String name, String email, String phoneNumber,
//       String rcNumber, String cacDocument) async {
//     var token = await appSettingsBloc.getToken;
//     try {
//       var response = await _api.addCompanyData(
//           token, name, email, phoneNumber, rcNumber, cacDocument);
//       return response;
//     } catch (err) {
//       throw ApiFailureException(err);
//     }
//   }
// }
