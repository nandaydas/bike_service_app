import 'package:bike_service_app/controller/centers_controller.dart';
import 'package:bike_service_app/view/components/S_Center_Card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesPage extends StatelessWidget {
  centersController centerController = Get.put(centersController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<centersController>(
        init: centersController(),
        initState: (_) {},
        builder: (centerController) {
          centerController.getData();
          return Center(
            child: centerController.isLoading
                ? Text('Loading...')
                : ListView.builder(
                    itemCount: centerController.centerList.length,
                    itemBuilder: ((context, index) {
                      return ScCard(
                        centerController.centerList[index].name,
                        centerController.centerList[index].image,
                        centerController.centerList[index].services,
                        centerController.centerList[index].location,
                      );
                    })),
          );
        });
  }
}
