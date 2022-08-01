import 'package:bike_service_app/view/components/S_Center_Card.dart';
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
        if (data!['serviceProvider'] == true) {
          return ScCard(
              data['name'], data['image'], data['services'], data['location']);
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
}
