import 'package:bike_service_app/Model/centers_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class centersController extends GetxController {
  var isLoading = false;
  var centerList = <centersModel>[];

  Future<void> getData() async {
    try {
      QuerySnapshot centers = await FirebaseFirestore.instance
          .collection("Service Centers")
          .orderBy("Name")
          .get();
      centerList.clear();
      for (var center in centers.docs) {
        centerList.add(centersModel(center['Name'], center['Image'],
            center['Services'], center['Location']));
      }
      isLoading = false;
    } catch (e) {
      Get.snackbar('Error', '${e.toString()}');
    }
  }
}
