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

  void _autofillNo() async {
    phoneNumberController.text = await autoFill.hint ?? '';
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
    if (await FirebaseAuth.instance.currentUser != null) {
      Get.toNamed("USERDASHBOARD");
    } else {
      Get.toNamed("SIGNUP");
    }
  }

  String phoneNo = '';

  void signup() {
    if (phoneNumberController.text.length <= 10) {
      phoneNo = '+91${phoneNumberController.text}';
    } else {
      phoneNo = phoneNumberController.text;
    }

    if (phoneNo.length == 13) {
      verifyPhone(phoneNo);
    } else {
      Fluttertoast.showToast(msg: "Phone Number Should Be 10 Digits");
    }
  }

  Future<void> verifyPhone(String phoneNo) async {
    try {
      EasyLoading.show(status: "Verifing....");
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (PhoneAuthCredential credential) {
          Fluttertoast.showToast(msg: 'Verification Completed');
        },
        verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(msg: 'Verification Failed');
        },
        codeSent: (String verificationId, int? resendToken) async {
          verificationID.value = verificationId;
        },
        timeout: Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      EasyLoading.dismiss();
      focus.removeListener(_autofillNo);
      Get.toNamed("OTP");
    }
    // ignore: empty_catches
    catch (ignored) {}
  }

  void submit() async {
    try {
      EasyLoading.show(status: "Submitting...");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID.value,
        smsCode: smsController.text,
      );
      authResult = await auth.signInWithCredential(credential);

      if (authResult!.additionalUserInfo!.isNewUser) {
        registerTheUser();
        EasyLoading.dismiss();
        Get.toNamed("USERDASHBOARD");
      } else {
        // loginUser();
        EasyLoading.dismiss();
        Get.toNamed("USERDASHBOARD");
      }
    } catch (e) {
      print(e);
    }
  }

  void registerTheUser() async {
    await firebase.collection('Users').doc(auth.currentUser!.uid).set(
      {
        'uid': auth.currentUser!.uid,
        'createdAt': Timestamp.now(),
      },
      SetOptions(
        merge: true,
      ),
    );
    Get.offAllNamed('HOME');
  }

  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      pageInitiator();
    } catch (e) {
      print(e);
    }
  }
}
