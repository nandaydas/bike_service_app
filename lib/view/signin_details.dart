import 'package:bike_service_app/controller/registration_controller.dart';
import 'package:bike_service_app/view/components/textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_const.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegistrationController rc = Get.put(RegistrationController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  children: [
                    const Text(
                      'Regisatration',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Obx(
                              () => CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        color: Colors.grey,
                                        child: Icon(
                                          Icons.image_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                  imageUrl: rc.imageUrl.value),
                            ),
                          ),
                          Positioned(
                            right: 1,
                            bottom: 1,
                            child: Container(
                              child: InkWell(
                                onTap: () async {
                                  rc.pickImage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(Icons.add_a_photo,
                                      color: Colors.black),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(2, 4),
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Account Type : "),
                          ElevatedButton(
                            onPressed: () {
                              rc.isServiceProvider(false);
                            },
                            child: Text(
                              "Customer",
                              style: TextStyle(
                                  color: rc.isServiceProvider.value
                                      ? Colors.black
                                      : Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: rc.isServiceProvider.value
                                  ? MaterialStateProperty.all(Colors.white)
                                  : MaterialStateProperty.all(primaryColor),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              rc.isServiceProvider(true);
                            },
                            child: Text(
                              "Provider",
                              style: TextStyle(
                                  color: rc.isServiceProvider.value
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor: rc.isServiceProvider.value
                                  ? MaterialStateProperty.all(primaryColor)
                                  : MaterialStateProperty.all(Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                        textEditingController: rc.nameController,
                        hintText: 'Enter Name',
                        textInputType: TextInputType.text),
                    MyTextField(
                        textEditingController: rc.emailController,
                        hintText: 'Enter Email',
                        textInputType: TextInputType.emailAddress),
                    TextField(
                      focusNode: new AlwaysDisabledFocusNode(),
                      controller: rc.phoneNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Phone Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 16,
                          bottom: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(() {
                      if (rc.isServiceProvider.value) {
                        return MyTextField(
                            textEditingController: rc.locationController,
                            hintText: 'Enter Location',
                            textInputType: TextInputType.text);
                      }
                      return Container();
                    }),
                    Obx(() {
                      if (rc.isServiceProvider.value) {
                        return MyTextField(
                            textEditingController: rc.servicesController,
                            hintText: 'Enter Services',
                            textInputType: TextInputType.text);
                      }

                      return Container();
                    }),
                  ],
                ),
                InkWell(
                  onTap: rc.signup,
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
                          'Register',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
