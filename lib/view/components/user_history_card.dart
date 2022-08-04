import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserHistory extends StatelessWidget {
  final String name, status, service, orderId;
  final Timestamp time;

  const UserHistory(
      this.name, this.status, this.service, this.time, this.orderId,
      {Key? key})
      : super(key: key);

  void updateOrder(String status) {
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderId)
        .update({'status': status});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
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
                  Text(
                    status,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: status == 'Pending'
                            ? Colors.amber
                            : status == 'Confirmed'
                                ? Colors.orange
                                : status == 'Completed'
                                    ? Colors.green
                                    : Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (status == 'Pending')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateOrder('Canceled');
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
