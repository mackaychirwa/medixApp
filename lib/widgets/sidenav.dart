import 'package:flutter/material.dart';
import 'package:untitled/screens/location.dart';
import '../screens/Login.dart';
import '../screens/appointments.dart';
import '../screens/healthMap.dart';
import '../screens/profile.dart';
import '../screens/reminder.dart';
import 'bottom_nav.dart';
import 'customlist.dart';

class SideNav extends StatelessWidget {
  const SideNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.orange[600]),
            child: Container(
              child: Column(
                children: [
                  ClipOval(
                    child: Image.asset("assets/images/logo.png",
                        width: 110, height: 90),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Profile Picture",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          CustomListTile(
            icon: Icons.person,
            text: 'Dashboard',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const BottomNav()));
            },
          ),
          CustomListTile(
            icon: Icons.notification_add,
            text: 'My Appointments',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Appointments()));
            },
          ),
          CustomListTile(
            icon: Icons.map,
            text: 'Nearest Medical Facility',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Locations()));
            },
          ),
          CustomListTile(
            icon: Icons.add_alert_sharp,
            text: 'Dosage',
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PillReminder()));
            },
          ),
          CustomListTile(
            icon: Icons.airline_seat_individual_suite_sharp,
            text: 'Statistics',
            onTap: () {

            },
          ),
          CustomListTile(
            icon: Icons.app_settings_alt,
            text: 'Account Settings',
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfileView()));
            },
          ),
          CustomListTile(
            icon: Icons.app_settings_alt,
            text: 'Logout',
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>
                  const Login()), (Route<dynamic> route)=> false);
            },
          ),
        ],
      ),
    );
  }
}
