import 'package:flutter/material.dart';
import 'package:sims_ppob/features/home/presentation/home_page.dart';
import 'package:sims_ppob/features/profile/profile_page.dart';
import 'package:sims_ppob/features/top_up/top_up_page.dart';
import 'package:sims_ppob/features/transaction/transaction_page.dart';
import 'package:sims_ppob/presentation/widgets/navigation/custom_nav_item.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Homepage(),
    const TopUpPage(),
    const TransactionPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isActive: _selectedIndex == 0,
              onTap: () => _onItemTapped(0),
            ),
            CustomNavItem(
              icon: Icons.money,
              label: 'Top Up',
              isActive: _selectedIndex == 1,
              onTap: () => _onItemTapped(1),
            ),
            CustomNavItem(
              icon: Icons.credit_card,
              label: 'Transaction',
              isActive: _selectedIndex == 2,
              onTap: () => _onItemTapped(2),
            ),
            CustomNavItem(
              icon: Icons.person_outline,
              label: 'Akun',
              isActive: _selectedIndex == 3,
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
