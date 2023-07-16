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
  String getLabel(int key) {
    switch (key) {
      case 0:
        return 'Home';
      case 1:
        return 'History';
      case 2:
        return 'Message';
      case 3:
        return 'Message';
      default:
        return '';
    }
  }

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
          // BottomNavigationBarItem(
          //     icon: _currentIndex == 0
          //         ? Icon(
          //             Icons.home,
          //             color: Colors.black,
          //           )
          //         : Icon(
          //             Icons.home,
          //             color: Colors.blue,
          //           ),
          //     label: 'Home'),
          // const BottomNavigationBarItem(
          //     icon: Icon(Icons.add_chart_outlined),
          //     label: 'add_chart_outlined'),
          // const BottomNavigationBarItem(icon: Icon(Icons.book), label: 'book'),
          // const BottomNavigationBarItem(
          //     icon: Icon(Icons.message), label: 'message'),
          Icons.home,
          Icons.add_chart_outlined,
          Icons.book,
          Icons.message
        ]
            .asMap()
            .map(
              (key, value) => MapEntry(
                key,
                BottomNavigationBarItem(
                  label: _currentIndex == key ? getLabel(key) : '',
                  // label: '',
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
            )
            .values
            .toList(),
      ),
    );
  }
}
