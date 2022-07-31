import 'package:flutter/material.dart';
import '../account_page.dart';
import '../history_page.dart';
import 's_centers_page.dart';

class UserDashboard extends StatefulWidget {
  @override
  State<UserDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<UserDashboard> {
  int _currentTab = 0;
  List _Body = [ServicesPage(), HistoryPage(), AccountPage()];
  List _Title = ['Service Centers', 'Service History', 'My Account'];

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
              label: 'Service Centers',
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
