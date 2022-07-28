import 'package:bike_service_app/constants/color_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final String uid = 'VrOdwpieBBaPbDjskmwTsrHxN7d2';

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
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574?b=1&k=20&m=1300972574&s=170667a&w=0&h=2nBGC7tr0kWIU8zRQ3dMg-C5JLo9H2sNUuDjQ5mlYfo='),
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
          _ProfileDetails('Name', 'User Name'),
          _ProfileDetails('Phone', '+91 000000000'),
          _ProfileDetails('Email', 'username@mail.com'),
          _ProfileDetails('Services', 'Bike/Car Wash, Reparing'),
          _ProfileDetails(
              'Location', 'Netaji Chowmoni, Shop no. 420, Agartala'),
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
                onPressed: () => FirebaseAuth.instance.signOut(),
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
        SizedBox(width: 20),
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
