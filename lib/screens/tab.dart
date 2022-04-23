import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trakk/screens/home.dart';
import 'package:trakk/screens/riders/rider_home.dart';
import 'package:trakk/screens/wallet.dart';
import 'package:trakk/utils/colors.dart';

class Tabs extends StatefulWidget {
    static const String id = 'tab';

  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;
  int _page = 0;
  String currentTitle = 'Home';

  Widget _currentPage (int page){
    switch (page){
      case 0 :
        currentTitle = 'Home';
        return const RiderHomeScreen();
      case 1 :
        currentTitle = 'Vehicles';
        return Container();
      case 2 :
        currentTitle = 'Wallet';
        return Container();
      case 3 :
        currentTitle = 'Histroy';
        return Container();
      default:
        currentTitle = 'Profile';
        return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage(_page),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
           icon: SvgPicture.asset("assets/images/home_icon.svg",
              color: _selectedIndex != 0 ? Colors.grey.withOpacity(0.3) : secondaryColor
            ),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/favorite_icon.svg",
              color: _selectedIndex != 1 ? Colors.grey.withOpacity(0.3) : secondaryColor
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/search_icon.svg",
              color: _selectedIndex != 2 ? Colors.grey.withOpacity(0.3) : secondaryColor
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/cart_icon.svg",
              color: _selectedIndex != 3 ? Colors.grey.withOpacity(0.3) : secondaryColor
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/profile_icon.svg",
              color: _selectedIndex != 4 ? Colors.grey.withOpacity(0.3) : secondaryColor
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ButtonBarItem extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;
  final Function onPressed;
  const ButtonBarItem({
    required Key key, required this.icon, required this.title, required this.color, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          SvgPicture.asset("images/$icon.svg"),
          SizedBox(height: 5,),
          Text(
            title, 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14, 
              color: color),
            )
        ],),
      ),
    );
  }
}
