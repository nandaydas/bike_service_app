import 'package:bike_service_app/constants/color_const.dart';
import 'package:bike_service_app/controller/auth_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String name = 'Loading...';
  String phone = 'Loading...';
  bool serviceProvider = true;
  String image = 'url';
  String services = '';
  String location = '';

  AuthController ac = Get.find<AuthController>();

  void getData() async {
    User? user = await FirebaseAuth.instance.currentUser!;
    var userData = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .get();
    setState(() {
      name = userData.data()!['name'];
      phone = userData.data()!['phoneNumber'];
      image = userData.data()!['serviceProvider'];
      image = userData.data()!['image'];
      services = userData.data()!['services'];
      location = userData.data()!['location'];
    });
  }

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Spacer(),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                          color: Colors.grey,
                          child: Icon(
                            Icons.image_rounded,
                            color: Colors.white,
                          ),
                        ),
                    errorWidget: (context, url, error) => Container(
                          color: Colors.grey,
                          child: Icon(
                            Icons.broken_image_rounded,
                            color: Colors.white,
                          ),
                        ),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    imageUrl: image),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(Icons.add_a_photo, color: Colors.black),
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
                      ]),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _ProfileDetails('Name', name),
          _ProfileDetails('Phone', phone),
          _ProfileDetails('Services', services),
          _ProfileDetails('Location', location),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Edit Profile')
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  ac.logout();
                },
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Log Out')
                  ],
                ),
              ),
            ],
          ),
          Spacer()
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
        SizedBox(width: 30),
        Container(
          height: 35,
          width: 7,
          color: primaryColor,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        )
      ]);
    } else {
      return SizedBox();
    }
  }
}
