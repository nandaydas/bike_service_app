import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import "package:path/path.dart" as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountController extends GetxController {
  Rx<String> name = ''.obs;
  Rx<String> phone = ''.obs;
  Rx<String> email = ''.obs;
  Rx<bool> serviceProvider = false.obs;
  Rx<String> imageUrl = ''.obs;
  Rx<String> services = ''.obs;
  Rx<String> location = ''.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  User? user;
  Rx<String> userId = ''.obs;
  Rx<bool> isServiceProvider = false.obs;

  final ImagePicker _picker = ImagePicker();

  TextEditingController? nameController;
  TextEditingController? phoneNumberController;
  TextEditingController? emailController;
  TextEditingController? locationController;
  TextEditingController? servicesController;
  File? imageFile;
  String fileName = '';

  @override
  void onInit() async {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      await firebase.collection('Users').doc(user!.uid).get().then(
        (DocumentSnapshot documentSnapshot) async {
          userId.value = documentSnapshot.get("uid");
          name.value = documentSnapshot.get("name");
          phone.value = documentSnapshot.get("phoneNumber");
          email.value = documentSnapshot.get("email");
          serviceProvider.value = documentSnapshot.get("serviceProvider");
          services.value = documentSnapshot.get("services");
          location.value = documentSnapshot.get("location");
          imageLoad(documentSnapshot.get("image"));
        },
      );
    }
  }

  void imageLoad(String image) async {
    imageUrl.value = await storage.ref().child(image).getDownloadURL();
  }

  void changeLocation() {
    fetchData();
    loadTexts();
    Get.toNamed("ACCOUNTEDIT");
  }

  void loadTexts() async {
    nameController = TextEditingController(text: name.value);
    phoneNumberController = TextEditingController(text: phone.value);
    emailController = TextEditingController(text: email.value);
    locationController = TextEditingController(text: location.value);
    servicesController = TextEditingController(text: services.value);
  }

  Future pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      fileName = path.basename(image.path);
      String extention = fileName.split('.')[1];
      fileName = auth.currentUser!.uid.toString() + "." + extention;

      imageFile = File(image.path);
      try {
        await storage.ref(fileName).putFile(
              imageFile!,
            );
        Fluttertoast.showToast(msg: "Uploaded");
        final storageRef = FirebaseStorage.instance.ref();
        imageUrl.value = await storageRef.child(fileName).getDownloadURL();
      } catch (e) {}
    }
  }

  void updateData() async {
    if (nameController!.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter a name');
      return;
    }
    if (isServiceProvider.value && locationController!.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please Enter Location');
      return;
    }
    updateUserInfo();
    fetchData();
    Get.back();
  }

  void updateUserInfo() async {
    await firebase.collection('Users').doc(auth.currentUser!.uid).set(
      {
        'uid': auth.currentUser!.uid,
        'serviceProvider': serviceProvider.value,
        'image': fileName,
        'name': nameController!.text,
        'email': emailController!.text,
        'phoneNumber': phoneNumberController!.text,
        'location': serviceProvider.value ? locationController!.text : "",
        'services': serviceProvider.value ? servicesController!.text : "",
        'createdAt': Timestamp.now(),
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}
