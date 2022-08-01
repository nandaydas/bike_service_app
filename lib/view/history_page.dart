import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      //item builder type is compulsory.
      itemBuilder: (context, documentSnapshots, index) {
        final data = documentSnapshots[index].data() as Map?;

        return Card(
          child: Column(
            children: [
              Text(
                data!['clientName'],
              ),
              Text(
                data['providerName'],
              ),
              Text(
                data['status'],
              ),
              Text(
                data['service'],
              ),
              Text(
                data['time'].toDate().toString(),
              ),
            ],
          ),
        );
      },
      // orderBy is compulsory to enable pagination
      query: FirebaseFirestore.instance.collection('Orders').orderBy('status'),
      //Change types accordingly
      itemBuilderType: PaginateBuilderType.listView,
      // to fetch real-time data
      isLive: true,
    );
  }
}
