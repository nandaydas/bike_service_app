import 'package:bike_service_app/view/Provider_Side/history_page.dart';
import 'package:bike_service_app/view/Provider_Side/s_centeres_page.dart';
import 'package:bike_service_app/view/account_page.dart';
import 'package:flutter/material.dart';

class ProviderDashboard extends StatefulWidget {
  @override
  State<ProviderDashboard> createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  int _currentTab = 0;

  List _Body = [ServicesPage(), ProviderHistory(), AccountPage()];

  List _Title = ['Service Requests', 'Service History', 'My Account'];

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
