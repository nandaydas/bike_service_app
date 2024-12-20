import 'package:bike_service_app/constants/color_const.dart';
import 'package:bike_service_app/controller/account_controller.dart';
import 'package:bike_service_app/controller/auth_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  AuthController auth_controller = Get.find<AuthController>();
  AccountController ac = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Obx(
                  () => CachedNetworkImage(
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Container(
                            color: Colors.grey,
                            child: const Icon(
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
            ],
          ),
          const SizedBox(height: 20),
          Obx(() => _ProfileDetails('Name', ac.name.value)),
          Obx(
            () => _ProfileDetails('Phone', ac.phone.value),
          ),
          Obx(
            () => _ProfileDetails('Email', ac.email.value),
          ),
          Obx(() {
            if (ac.serviceProvider.value == true) {
              return _ProfileDetails('Location', ac.location.value);
            } else {
              return Container();
            }
          }),
          Obx(() {
            if (ac.serviceProvider.value == true) {
              return _ProfileDetails('Services', ac.services.value);
            } else {
              return Container();
            }
          }),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ac.changeLocation();
                },
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  auth_controller.logout();
                },
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                icon: const Icon(Icons.logout),
                label: const Text(' Log Out '),
              ),
            ],
          ),
          const Spacer()
        ],
      ),
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  final title, subtitle;
  _ProfileDetails(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    if (subtitle.toString().isNotEmpty) {
      return Row(children: [
        const SizedBox(width: 30),
        Container(
          height: 35,
          width: 7,
          color: primaryColor,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        )
      ]);
    } else {
      return const SizedBox();
    }
  }
}
