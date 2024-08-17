import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:totalx/model/auth_model.dart';
import 'package:totalx/view/auth/otp.dart';

class AuthService {
  FirebaseAuth authentication = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  signinWithPhone(
      {required String phoneNumber, required BuildContext context}) async {
    try {
      await authentication.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await authentication.signInWithCredential(phoneAuthCredential);
          print("Phone number verified and signed in :$phoneAuthCredential");
        },
        verificationFailed: (firebaseAuthException) {
          print('Error: ${firebaseAuthException.message}');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Verification failed. Please try again.")));
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OtpScreen(
              verificationId: verificationId,
              phoneNumber: phoneNumber,
            ),
          ));
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      throw Exception('phone auth is intrrupted$e');
    }
  }

  verifyOtp(
      {required String verificationId,
      required String otp,
      required String phone,
      required Function onSuccess}) async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      User? user =
          (await authentication.signInWithCredential(phoneAuthCredential)).user;

      if (user != null) {
        UserModel userData = UserModel(id: user.uid, phoneNumber: phone);
        firestore.collection('users').doc(user.uid).set(userData.toJson());
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception('phone auth is intrrupted$e');
    }
  }

  Future<void> signOut() async {
    try {
      await authentication.signOut();
    } catch (e) {
      throw Exception('sign out is error$e');
    }
  }
}
