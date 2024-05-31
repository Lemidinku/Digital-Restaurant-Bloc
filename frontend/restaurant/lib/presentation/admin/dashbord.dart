import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/application/auth/auth_bloc.dart';
import 'package:restaurant/presentation/admin/addfood.dart';

import 'package:restaurant/presentation/admin/component/dashbordhome.dart';
import 'package:restaurant/presentation/admin/orderlist.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key, required this.title});

  final String title;

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    AddedFoodsPage(),
    AddFoodPage(),
    OrdersListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin page'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                ),
                child: Center(
                  child: Text(
                    'Digital resturant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Dashbord',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onItemTapped(0);

                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Add Food',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);

                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Order List',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: _widgetOptions[_selectedIndex],
    );
  }
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Logout Confirmation"),
        content: const Text("Are you sure you want to logout?"),
        actions: <Widget>[
          TextButton(
            child: const Text("Logout"),
            onPressed: () {
              GoRouter.of(context).go('/login');
              context.read<AuthBloc>().add(AuthLogout());
            },
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
