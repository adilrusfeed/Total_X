import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/auth_controller.dart';
import 'package:totalx/view/home.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  String verificationId;
  String phoneNumber;
  OtpScreen(
      {super.key, required this.verificationId, required this.phoneNumber});

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: screensize.height * 0.20,
                    width: screensize.width * 0.33,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/download (1).jpg"))),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'OTP Verification',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                      'Enter the verification code we just sent to your number +91 *******21.'),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: PinCodeTextField(
                      controller: otpController,
                      pinTextStyle:
                          const TextStyle(fontSize: 17, color: Colors.red),
                      maxLength: 6,
                      pinBoxWidth: screensize.width * 0.13,
                      pinBoxHeight: screensize.height * 0.08,
                      pinBoxRadius: 10,
                      highlightColor: Colors.red,
                      defaultBorderColor: Colors.grey,
                      onDone: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      verifyOtp(context, otpController.text, phoneNumber);
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                        child: Text(
                          "Verify OTP",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void verifyOtp(context, String userOtp, String phonenumber) {
    final authProvider = Provider.of<LoginProviders>(context, listen: false);
    authProvider.verifyOtp(
        otp: userOtp,
        verificationId: verificationId,
        onSuccess: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeSceen(),
              ));
        },
        phone: phonenumber);
  }
}
