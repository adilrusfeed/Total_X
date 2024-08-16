import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneFieldController = TextEditingController();
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
              child: Consumer<LoginProviders>(
                builder: (context, value, child) => Column(
                  children: [
                    Container(
                      height: screensize.height * 0.20,
                      width: screensize.width * 0.33,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/otp.avif"))),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter Phone Number',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phoneFieldController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: "Enter Phone Number ",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        "By Continuing,I agree to total_x's Terms and Conditions & Privacy Policy"),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        value.signinWithPhone(
                            phoneNumber: "+91${phoneFieldController.text}",
                            context: context);
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            "Get OTP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
