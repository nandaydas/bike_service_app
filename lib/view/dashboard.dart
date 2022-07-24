import 'package:bike_service_app/view/account_page.dart';
import 'package:bike_service_app/view/history_page.dart';
import 'package:bike_service_app/view/s_centeres_page.dart';
import 'package:flutter/material.dart';

class MyDashboard extends StatefulWidget {
  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  int _currentTab = 0;

  List _Body = [ServicesPage(), HistoryPage(), AccountPage()];

  List _Title = ['Service Centeres', 'Service History', 'My Account'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text(_Title[_currentTab]),
      ),
      body: _Body[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: (index) => setState(() => _currentTab = index),
          currentIndex: _currentTab,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              label: 'Service Centeres',
              icon: Icon(Icons.garage_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Service History',
              icon: Icon(Icons.history_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(Icons.account_circle_outlined),
            ),
          ]),
    );
  }
}
