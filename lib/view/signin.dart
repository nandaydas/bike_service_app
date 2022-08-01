import 'package:bike_service_app/constants/color_const.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import '../controller/auth_controller.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController ac = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  'assets/welcome_re.svg',
                  height: 180,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'SIGN IN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  'We Provide Your Vehicles with the care it deservs',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  focusNode: ac.focus,
                  controller: ac.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Your Phone No.',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: ac.signup,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Send OTP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'By continuing you agree to our ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {}),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
