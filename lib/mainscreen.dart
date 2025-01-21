import 'package:coffeeshop/appcolors.dart';
import 'package:flutter/material.dart';
import 'home.dart'; // Import your pages
import 'menu.dart';
import 'cart.dart';
import 'profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens to navigate to
  late final List<Widget> _screens = [
    home(onTabSelected: _onItemTapped),   // Replace with your home page
    const menu(),    // Replace with your menu page
    const cart(),    // Replace with your cart page
    const profile(), // Replace with your profile page
  ];

  // Method to handle navigation between screens
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkThemeColors.bg1,

      body: _screens[_selectedIndex],  // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // backgroundColor: Color.fromARGB(255, 66, 73, 52),
            backgroundColor: DarkThemeColors.bg2,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Color.fromARGB(255, 66, 73, 52),
            backgroundColor: DarkThemeColors.bg2,
            icon: Icon(Icons.menu_book),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Color.fromARGB(255, 66, 73, 52),
            backgroundColor: DarkThemeColors.bg2,
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            // backgroundColor: Color.fromARGB(255, 66, 73, 52),
            backgroundColor: DarkThemeColors.bg2,
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,  // Highlight the current screen
        selectedItemColor:  const Color.fromARGB(255, 255, 255, 255),
        // fixedColor: Color.fromARGB(255, 64, 44, 38),
        // unselectedItemColor: const Color.fromARGB(255, 135, 144, 118),
        unselectedItemColor: const Color.fromARGB(255, 138, 142, 132),
        backgroundColor:  const Color.fromARGB(255, 137, 74, 55),
        onTap: _onItemTapped,  // Handle tab switch
      ),
    );
  }
}
