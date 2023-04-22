import 'package:flutter/material.dart';
import 'patients_screen.dart';
import 'doctors_screen.dart';

class NavBar extends StatefulWidget {
  static const routeName = '/nav-bar';
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var selectedIndex = 0;
  static List<Widget> screens = const [
    PatientsScreen(),
    DoctorsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) => setState(() {
          selectedIndex = value;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Doctors',
          ),
        ],
      ),
    );
  }
}
