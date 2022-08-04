import 'package:bike_service_app/view/components/textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_const.dart';
import '../controller/account_controller.dart';
import '../controller/auth_controller.dart';

class AccountEdit extends StatelessWidget {
  AccountEdit({Key? key}) : super(key: key);

  AuthController auth_controller = Get.find<AuthController>();
  AccountController ac = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit account details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                children: [
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
                                errorWidget: (context, url, error) => Container(
                                      color: Colors.grey,
                                      child: Icon(
                                        Icons.image_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                                imageUrl: ac.imageUrl.value),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: Container(
                            child: InkWell(
                              onTap: () async {
                                ac.pickImage();
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
                  SizedBox(height: 20),
                  MyTextField(
                      textEditingController: ac.nameController!,
                      hintText: 'Enter Name',
                      textInputType: TextInputType.text),
                  MyTextField(
                      textEditingController: ac.emailController!,
                      hintText: 'Enter Email',
                      textInputType: TextInputType.emailAddress),
                  Obx(() {
                    if (ac.serviceProvider.value) {
                      return MyTextField(
                          textEditingController: ac.locationController!,
                          hintText: 'Enter Location',
                          textInputType: TextInputType.text);
                    }
                    return Container();
                  }),
                  Obx(() {
                    if (ac.serviceProvider.value) {
                      return MyTextField(
                          textEditingController: ac.servicesController!,
                          hintText: 'Enter Services',
                          textInputType: TextInputType.text);
                    }
                    return Container();
                  })
                ],
              ),
              InkWell(
                onTap: ac.updateData,
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
                        'Update',
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
    );
  }
}
