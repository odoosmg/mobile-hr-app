import 'package:flutter/material.dart';
import 'package:hrm_employee/extensions/textstyle_extension.dart';
import 'package:hrm_employee/utlis/app_color.dart';

class SAHomeScreen extends StatefulWidget {
  static const route = '/home';
  const SAHomeScreen({super.key});

  @override
  State<SAHomeScreen> createState() => _SAHomeScreenState();
}

class _SAHomeScreenState extends State<SAHomeScreen> {
  String username = '';

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: 0,
        // sizing: StackFit.passthrough,
        children: const [
          Text("hi")
          // SaleListPage(),
          // OrderListPage(),
          // CustomerListPage(),
          // AccountPage(),
        ],
      ),
      bottomNavigationBar: _botttomNavigation(),
    );
  }

  Widget _botttomNavigation() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 15,
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 25,
        currentIndex: selectedIndex,
        backgroundColor: Colors.grey.shade200,
        selectedItemColor: AppColor.kMainColor,
        unselectedItemColor: AppColor.kGreyTextColor,
        onTap: (index) => selectedIndex,
      ),
    );
  }
}