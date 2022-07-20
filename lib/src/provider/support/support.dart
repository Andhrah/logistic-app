import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trakk/src/Exceptions/api_failure_exception.dart';
import 'package:trakk/src/services/auth_service.dart';
import 'package:trakk/src/services/rider/rider_auth.dart';
import 'package:trakk/src/services/support_service.dart';

class SupportProvider extends ChangeNotifier {
  final SupportService _supportService = SupportService();

  static SupportProvider supportProvider(BuildContext context,
      {bool listen = false}) {
    return Provider.of<SupportProvider>(context, listen: listen);
  }

  Future createComplaint({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      var response = await _supportService.createComplaint(name, email, message);
      print('[][][][][][][][][][] COMPLAINT [][][][][][][][][][][][]');
      print('${response}');
      return response;
    } catch (err) {
      throw ApiFailureException(err);
    }
  }
}
