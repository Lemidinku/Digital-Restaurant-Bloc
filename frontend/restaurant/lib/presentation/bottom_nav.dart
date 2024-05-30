import 'package:flutter/material.dart';
import 'package:restaurant/presentation/home.dart';
import 'package:restaurant/presentation/login_page.dart';
import 'package:restaurant/presentation/order_now.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  //Create variable for selected index on the bottom nav bar
  int selected_idx = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      selected_idx = index;
    });
  }

  List _pages = [HomePage(), OrderNowPage(), LoginPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Restaurant'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: _pages[selected_idx],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFF97350),
        unselectedItemColor: Colors.black,
        iconSize: 34,
        currentIndex: selected_idx,
        onTap: _navigateBottomBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
