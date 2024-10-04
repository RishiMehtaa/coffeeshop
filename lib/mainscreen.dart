import 'package:flutter/material.dart';
import 'home.dart'; // Import your pages
import 'menu.dart';
import 'cart.dart';
import 'profile.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens to navigate to
  final List<Widget> _screens = [
    home(),    // Replace with your home page
    menu(),    // Replace with your menu page
    cart(),    // Replace with your cart page
    profile(), // Replace with your profile page
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
      body: _screens[_selectedIndex],  // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,  // Highlight the current screen
        selectedItemColor: const Color.fromARGB(255, 255, 231, 222),
        unselectedItemColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 64, 44, 38),
        onTap: _onItemTapped,  // Handle tab switch
      ),
    );
  }
}
