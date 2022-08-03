import 'package:bike_service_app/view/components/user_history_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../controller/account_controller.dart';
import 'components/provider_history_card.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  AccountController ac = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
      //item builder type is compulsory.
      itemBuilder: (context, documentSnapshots, index) {
        final data = documentSnapshots[index].data() as Map?;

        return Obx(() {
          if (data!['client'] == ac.userId.value) {
            return UserHistory(
              data['providerName'],
              data['status'],
              data['service'],
              data['time'],
            );
          } else if (data['provider'] == ac.userId.value) {
            return ProviderHistory(
              data['clientName'],
              data['status'],
              data['service'],
              data['time'],
            );
          } else {
            return SizedBox();
          }
        });
      },
      // orderBy is compulsory to enable pagination
      query: FirebaseFirestore.instance
          .collection('Orders')
          .orderBy('time', descending: true),
      //Change types accordingly
      itemBuilderType: PaginateBuilderType.listView,
      // to fetch real-time data
      isLive: true,
      itemsPerPage: 20,
    );
  }
}
