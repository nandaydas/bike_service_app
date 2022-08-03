import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProviderHistory extends StatelessWidget {
  final String name, status, service;
  final Timestamp time;

  const ProviderHistory(this.name, this.status, this.service, this.time);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            service,
                          ),
                          Text(
                            time.toDate().toString(),
                          ),
                        ],
                      ),
                    ),
                    Text(status,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: status == 'Completed'
                              ? Colors.green
                              : status == 'Canceled'
                                  ? Colors.red
                                  : Colors.amber,
                        )),
                  ],
                ),
                const SizedBox(height: 10),
                if (status == 'Pending')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                        child: const Text('Confirm'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
              ],
            )),
      ),
    );
  }
}
