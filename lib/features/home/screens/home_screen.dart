import 'package:corre_aqui/common/widgets/custom_bottom_navigation_bar.dart';
import 'package:corre_aqui/features/event/screens/event_screen.dart';
import 'package:corre_aqui/features/favorite/screens/favorite_screen.dart';
import 'package:corre_aqui/features/home/screens/home_offer_screen.dart';
import 'package:corre_aqui/features/home/widgets/components/offer_map_button.dart';
import 'package:corre_aqui/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Widget> _screens = [
    HomeOfferScreen(),
    FavoriteScreen(),
    EventScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      floatingActionButton: OfferMapButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped
      ),
    );
  }

}
