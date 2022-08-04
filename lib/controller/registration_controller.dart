import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart' as path;
import 'package:bike_service_app/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class RegistrationController extends GetxController {
  AuthController ac = Get.find<AuthController>();

  Rx<bool> isServiceProvider = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firebase = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  final ImagePicker _picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  Rx<String> imageUrl = ''.obs;
  File? imageFile;
  String fileName = '';

  void serviceProvider(bool answer) {
    isServiceProvider.value = answer;
  }

  @override
  onInit() async {
    phoneNumberController.text = await auth.currentUser!.phoneNumber!;
    super.onInit();
  }

  Future pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      EasyLoading.show(status: "Uploading");
      fileName = path.basename(image.path);
      String extention = fileName.split('.')[1];
      fileName = auth.currentUser!.uid.toString() + "." + extention;

      imageFile = File(image.path);
      try {
        await storage.ref(fileName).putFile(
              imageFile!,
            );
        final storageRef = FirebaseStorage.instance.ref();
        imageUrl.value = await storageRef.child(fileName).getDownloadURL();
        EasyLoading.dismiss();
      } catch (e) {
        EasyLoading.dismiss();
      }
    }
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
        'image': fileName,
        'name': nameController.text,
        'email': emailController.text,
        'phoneNumber': phoneNumberController.text,
        'location': isServiceProvider.value ? locationController.text : "",
        'services': isServiceProvider.value ? servicesController.text : "",
        'createdAt': Timestamp.now(),
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}
