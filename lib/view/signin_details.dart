import 'package:bike_service_app/controller/auth_controller.dart';
import 'package:bike_service_app/controller/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_const.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegistrationController rc = Get.put(RegistrationController());
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 42,
          bottom: 16,
        ),
        child: Stack(
          children: [
            Align(
              child: Column(
                children: [
                  const Text(
                    'Regisatration',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                                : MaterialStateProperty.all(Colors.blue),
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
                                ? MaterialStateProperty.all(Colors.blue)
                                : MaterialStateProperty.all(Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: rc.nameController,
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
                    focusNode: new AlwaysDisabledFocusNode(),
                    controller: rc.phoneNumberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter Phone Number',
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
                    if (rc.isServiceProvider.value) {
                      return TextField(
                        controller: rc.locationController,
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
                  })
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: rc.signup,
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
            )
          ],
        ),
      ),
    );
  }
}
