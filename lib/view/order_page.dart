import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderPage extends StatelessWidget {
  final String name;

  OrderPage(this.name);

  _launchMapsURL() async {
    var url = Uri.parse('https://www.google.com/maps/search/' + name);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        children: [
          Expanded(child: Column()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _launchMapsURL();
                },
                child: Row(
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(
                      width: 10,
                    ),
                    Text('View on Map')
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.date_range),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Book Appointment')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
