import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:MysqlApp/MainPages/HomePage/homepage.dart';
import 'package:MysqlApp/MainPages/Profile/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: FluidNavBar(
        defaultIndex: 0,
        scaleFactor: 1.5,
        icons: [
          FluidNavBarIcon(
            backgroundColor: Colors.black,
            icon: Icons.home,
            extras: {"label": "Home"},
          ),
          FluidNavBarIcon(
            backgroundColor: Colors.black,
            icon: Icons.person,
            extras: {"label": "Profile"},
          ),
        ],
        onChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        style: const FluidNavBarStyle(
          iconUnselectedForegroundColor: Colors.white,
          iconSelectedForegroundColor: Colors.white,
          barBackgroundColor: Color.fromARGB(255, 148, 195, 234),
        ),
      ),
    );
  }
}
