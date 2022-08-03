import 'package:bike_service_app/view/components/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/account_controller.dart';

class OrderPage extends StatelessWidget {
  AccountController ac = Get.find<AccountController>();

  final String providerId, providerName;
  final serviceController = TextEditingController();

  OrderPage(this.providerId, this.providerName, {Key? key}) : super(key: key);

  _launchMapsURL() async {
    var url = Uri.parse('https://www.google.com/maps/search/$providerName');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _createOrder({required String service}) async {
    final order = FirebaseFirestore.instance.collection('Orders').doc();
    final json = {
      'client': ac.userId.value,
      'clientName': ac.name.value,
      'provider': providerId,
      'providerName': providerName,
      'service': service,
      'status': 'Pending',
      'time': DateTime.now(),
    };
    await order.set(json);
    //A snackbar or notifier shouled be added here: "Order Placed !"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(providerName),
      ),
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        MyTextField(
                            textEditingController: serviceController,
                            hintText: 'Service you want',
                            textInputType: TextInputType.text),
                        ElevatedButton.icon(
                          onPressed: () {
                            final service = serviceController.text;
                            _createOrder(service: service);
                            serviceController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder()),
                          icon: const Icon(Icons.date_range),
                          label: const Text('Book Appointment'),
                        ),
                      ],
                    ),
                  ))
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _launchMapsURL();
                },
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                icon: const Icon(Icons.location_pin),
                label: const Text('View on Map'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
