import 'package:bike_service_app/constants/color_const.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bike_service_app/controller/auth_controller.dart';

class OTP extends StatelessWidget {
  OTP({Key? key}) : super(key: key);

  AuthController ac = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(
                      'assets/message_sent.svg',
                      height: 180,
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'VERIFICATION',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text(
                      'You wil get an OTP via SMS',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextField(
                      controller: ac.smsController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Enter Your OTP',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: ac.submit,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Verify',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Didn\'t receive verfication OTP? ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                      text: 'Resend OTP',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {}),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
