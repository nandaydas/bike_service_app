import 'package:bike_service_app/view/components/servicecenters_card.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      //item builder type is compulsory.
      itemBuilder: (context, documentSnapshots, index) {
        final data = documentSnapshots[index].data() as Map?;
        Rx<String> imageUrl = ''.obs;
        if (data!['serviceProvider'] == true) {
          getImage(data['image'], imageUrl);
          return Obx(
            () => ScCard(
              data['name'],
              imageUrl.value,
              data['services'],
              data['location'],
            ),
          );
        } else {
          return SizedBox();
        }
      },
      // orderBy is compulsory to enable pagination
      query: FirebaseFirestore.instance.collection('Users').orderBy('name'),
      //Change types accordingly
      itemBuilderType: PaginateBuilderType.listView,
      // to fetch real-time data
      isLive: true,
      itemsPerPage: 20,
    );
  }

  void getImage(String image, Rx<String> imageUrl) async {
    imageUrl.value =
        await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
