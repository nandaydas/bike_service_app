import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class AuthController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController smsController = TextEditingController();
  FocusNode focus = FocusNode();
  SmsAutoFill autoFill = SmsAutoFill();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  Rx<String> verificationID = ''.obs;
  UserCredential? authResult;

  Rx<bool> otpSent = false.obs;

  void _autofillNo() async {
    phoneNumberController.text =
        await autoFill.hint ?? phoneNumberController.text;
  }

  @override
  void onInit() async {
    focus.addListener(_autofillNo);
    super.onInit();
    await pageInitiator();
  }

  @override
  void onClose() {
    focus.removeListener(_autofillNo);
    super.onClose();
  }

  Future<void> pageInitiator() async {
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      firebase
          .collection('Users')
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          bool isServiceProvide = documentSnapshot.get("serviceProvider");
          if (isServiceProvide) {
            Get.offAllNamed("PROVIDERDASHBOARD");
          } else {
            Get.offAllNamed("USERDASHBOARD");
          }
        } else {
          Get.offAllNamed("REGISTRATION");
        }
      });
    } else {
      Get.offAllNamed("SIGNUP");
    }
  }

  Rx<String> phoneNo = ''.obs;

  void signup() {
    otpSent.value = false;
    if (phoneNumberController.text.length <= 10) {
      phoneNo.value = '+91${phoneNumberController.text}';
    } else {
      phoneNo.value = phoneNumberController.text;
    }

    if (phoneNo.value.length == 13) {
      verifyPhone(phoneNo.value);
      Get.toNamed("OTP");
    } else {
      Fluttertoast.showToast(msg: "Phone Number Should Be 10 Digits");
    }
  }

  Future<void> verifyPhone(String phoneNo) async {
    focus.removeListener(_autofillNo);
    try {
      EasyLoading.show(status: "Verifing....");
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) {
          otpSent.value = true;
        },
        verificationFailed: (FirebaseAuthException e) {
          otpSent.value = true;
          Fluttertoast.showToast(msg: 'Verification Failed');
        },
        codeSent: (String verificationId, int? resendToken) async {
          otpSent.value = true;
          verificationID.value = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationID.value = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
      EasyLoading.dismiss();
    }
    // ignore: empty_catches
    catch (ignored) {}
  }

  void submit() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID.value,
        smsCode: smsController.text,
      );
      authResult = await auth.signInWithCredential(credential);

      if (authResult!.additionalUserInfo!.isNewUser) {
        otpSent.value = false;
        Get.offAllNamed("REGISTRATION");
      } else {
        EasyLoading.dismiss();
        otpSent.value = false;
        pageInitiator();
      }
    } catch (e) {}
  }

  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      pageInitiator();
    } catch (e) {}
  }
}
