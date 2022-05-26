import 'package:flutter/material.dart';
import 'package:untitled/screens/homepage.dart';

import '../screens/chatroom.dart';
import '../screens/health.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  final List _screens = [
    const HomePage(),
    const PatientChart(),
    const HomePage(),
    const ChatRoom()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 0.0,
        items: [
          Icons.home,
          Icons.add_chart_outlined,
          Icons.book,
          Icons.message
        ].asMap().map(
              (key, value) => MapEntry(
                key,
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                        color: _currentIndex == key
                            ? Colors.orange[600]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Icon(value),
                  ),
                ),
              ),
            ).values
        .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        elevation: 0.0,
        child: const Icon(
          Icons.qr_code_scanner_sharp,
        color: Colors.orange,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
