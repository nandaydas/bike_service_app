import 'package:bike_service_app/view/User_side/user_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class MobileVerification extends StatefulWidget {
  MobileVerification({Key? key}) : super(key: key);

  @override
  State<MobileVerification> createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId = '';

  bool showLoading = false;

  void signInWithPhoneAuthCredentials(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => MyDashboard()),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
    }
  }

  getMobileForWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          decoration: InputDecoration(hintText: "Phone Number"),
          controller: phoneController,
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () async {
            await _auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (PhoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
              },
              verificationFailed: (PhoneVerificationFailed) async {
                setState(() {
                  showLoading = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(PhoneVerificationFailed.message!),
                  ),
                );
              },
              codeSent: (verificationId, forceResendingToken) {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) {},
            );
            print(verificationId);
          },
          child: Text("Send OTP"),
        ),
        Spacer(),
      ],
    );
  }

  getOtpForWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          decoration: InputDecoration(hintText: "Enter OTP"),
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text);

            signInWithPhoneAuthCredentials(phoneAuthCredential);
          },
          child: Text("Verify"),
        ),
        Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
              ? getMobileForWidget(context)
              : getOtpForWidget(context),
    );
  }
}
