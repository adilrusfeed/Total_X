import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:totalx/service/auth_service.dart';

class LoginProviders extends ChangeNotifier {
  AuthService authService = AuthService();

  signinWithPhone(
      {required String phoneNumber, required BuildContext context}) async {
    try {
      log(phoneNumber);
      await authService.signinWithPhone(
          phoneNumber: phoneNumber, context: context);
    } catch (e) {
      throw Exception("phone auth intrepted$e");
    }
    notifyListeners();
  }

  verifyOtp(
      {required String otp,
      required String verificationId,
      required Function onSuccess,
      required String phone}) {
    try {
      authService.verifyOtp(
          verificationId: verificationId,
          otp: otp,
          phone: phone,
          onSuccess: onSuccess);
    } catch (e) {
      throw Exception("otp verification intrepted$e");
    }
    notifyListeners();
  }
}
