import 'package:bike_service_app/view/components/textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/account_controller.dart';

class OrderPage extends StatelessWidget {
  final AccountController ac = Get.find<AccountController>();

  final String providerId, providerName, image, services, location;
  final serviceController = TextEditingController();
  final vehicleController = TextEditingController();

  OrderPage(this.providerId, this.providerName, this.image, this.services,
      this.location,
      {Key? key})
      : super(key: key);

  _launchMapsURL() async {
    var url = Uri.parse('https://www.google.com/maps/search/$providerName');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future _createOrder(
      {required String service, required String vehicle}) async {
    final order = FirebaseFirestore.instance.collection('Orders').doc();
    final json = {
      'client': ac.userId.value,
      'clientName': ac.name.value,
      'service': service,
      'vehicle': vehicle,
      'provider': providerId,
      'providerName': providerName,
      'status': 'Pending',
      'time': DateTime.now(),
      'orderId': order.id
    };
    await order.set(json);
    //A snackbar or notifier shouled be added here: "Order Placed !"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(providerName),
              background: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  color: Colors.grey,
                  child: const Icon(
                    Icons.image_rounded,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey,
                  child: const Icon(
                    Icons.broken_image_rounded,
                    color: Colors.white,
                  ),
                ),
                imageUrl: image,
                fit: BoxFit.cover,
              ),
            ),
            floating: true,
            pinned: true,
          )
        ],
        body: SingleChildScrollView(
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
                      Row(
                        children: [
                          const Icon(
                            Icons.build_rounded,
                            color: Colors.grey,
                            size: 16,
                          ),
                          Expanded(
                            child: Text(
                              ' $services',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.grey,
                            size: 16,
                          ),
                          Expanded(
                            child: Text(' $location',
                                style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              _launchMapsURL();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder()),
                            icon: const Icon(Icons.location_pin),
                            label: const Text('View on Map'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Book an Apointment',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      MyTextField(
                          textEditingController: serviceController,
                          hintText: 'Service you want',
                          textInputType: TextInputType.text),
                      MyTextField(
                          textEditingController: vehicleController,
                          hintText: 'Vehicle no./Model',
                          textInputType: TextInputType.text),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Book Apointment'),
                                    content: Text(
                                        '${serviceController.text} of ${vehicleController.text} at $providerName'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('No')),
                                      TextButton(
                                          onPressed: () {
                                            final service =
                                                serviceController.text;
                                            final vehicle =
                                                vehicleController.text;
                                            _createOrder(
                                                service: service,
                                                vehicle: vehicle);
                                            serviceController.clear();
                                            vehicleController.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Yes, Sure')),
                                    ],
                                  ));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                        icon: const Icon(Icons.date_range),
                        label: const Text('Book Now'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
