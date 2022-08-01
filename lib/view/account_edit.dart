import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_const.dart';
import '../controller/account_controller.dart';
import '../controller/auth_controller.dart';

class AccountEdit extends StatelessWidget {
  AccountEdit({Key? key}) : super(key: key);

  AuthController auth_controller = Get.find<AuthController>();
  AccountController ac = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
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
                      'Account Edit',
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
                                  placeholder: (context, url) => Container(
                                        color: Colors.grey,
                                        child: Icon(
                                          Icons.image_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        color: Colors.grey,
                                        child: Icon(
                                          Icons.broken_image_rounded,
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
                    TextField(
                      controller: ac.nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Enter Name',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 16,
                          bottom: 16,
                        ),
                      ),
                    ),
                    TextField(
                      controller: ac.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Enter Email',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 16,
                          bottom: 16,
                        ),
                      ),
                    ),
                    Obx(() {
                      if (ac.serviceProvider.value) {
                        return TextField(
                          controller: ac.locationController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Enter Location',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 16,
                              bottom: 16,
                            ),
                          ),
                        );
                      }
                      return Container();
                    }),
                    Obx(() {
                      if (ac.serviceProvider.value) {
                        return TextField(
                          controller: ac.servicesController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: 'Enter Services',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 16,
                              bottom: 16,
                            ),
                          ),
                        );
                      }
                      return Container();
                    })
                  ],
                ),
                SizedBox(height: 20),
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
      ),
    );
  }
}
