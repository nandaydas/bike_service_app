import 'package:bike_service_app/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class RegistrationController extends GetxController {
  AuthController ac = Get.find<AuthController>();

  Rx<bool> isServiceProvider = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  void serviceProvider(bool answer) {
    isServiceProvider.value = answer;
  }

  onInit() async {
    phoneNumberController.text = await auth.currentUser!.phoneNumber!;
    super.onInit();
  }

  void signup() async {
    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter a name');
      return;
    }
    if (isServiceProvider.value && locationController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Location');
      return;
    }
    registerTheUser();
    await ac.pageInitiator();
  }

  void registerTheUser() async {
    await firebase.collection('Users').doc(auth.currentUser!.uid).set(
      {
        'uid': auth.currentUser!.uid,
        'serviceProvider': isServiceProvider.value,
        'name': nameController.text,
        'phoneNumber': phoneNumberController.text,
        'location': isServiceProvider.value ? locationController.text : null,
        'createdAt': Timestamp.now(),
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}
