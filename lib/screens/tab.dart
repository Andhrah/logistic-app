import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/dispatch/cart.dart';
import 'package:trakk/screens/dispatch/item_details.dart';
import 'package:trakk/screens/dispatch/order.dart';
import 'package:trakk/screens/dispatch/payment.dart';
import 'package:trakk/screens/profile/profile_menu.dart';
import 'package:trakk/screens/riders/rider_home.dart';
import 'package:trakk/screens/riders/rider_order.dart';
import 'package:trakk/screens/wallet/wallet.dart';
import 'package:trakk/utils/colors.dart';

class Tabs extends StatefulWidget {
  static const String id = 'tab';

  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {

  _fetchUser() async {
    var box = await Hive.openBox('appState');
    setState(() {
      userType = box.get("userType");
    });
  }

  
  
  int _selectedIndex = 0;
  String userType =  "customer";

  String currentTitle = 'Home';

  Widget _currentUserPage (_selectedIndex){
    switch (_selectedIndex){
      case 0 :
        currentTitle = 'Home';
        return const ItemDetails();
      case 1 :
        currentTitle = 'Cart';
        return const CartScreen();
      case 2 :
        currentTitle = 'Order';
        return const UserOrderScreen();
      case 3 :
        currentTitle = 'Wallet';
        return const WalletScreen();
      default:
        currentTitle = 'Profile';
        return const ProfileMenu();
    }
  }

  Widget _currentRiderPage (_selectedIndex){
    switch (_selectedIndex){
      case 0 :
        currentTitle = 'Home';
        return const RiderHomeScreen();
      case 1 :
        currentTitle = 'Order';
        return const RiderOrderScreen();
      case 2 :
        currentTitle = 'Wallet';
        return Container();
      case 3 :
        currentTitle = 'Histroy';
        return Container();
      default:
        currentTitle = 'Profile';
        return const ProfileMenu();
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
  void initState() {
    super.initState();
    _fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userType == "customer" ? _currentUserPage(_selectedIndex) : _currentRiderPage(_selectedIndex),
      bottomNavigationBar: userType == "customer" ? BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Remix.home_7_line,
              color: _selectedIndex != 0 ? appPrimaryColor : secondaryColor
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Remix.shopping_cart_2_line,
              color: _selectedIndex != 1 ? appPrimaryColor : secondaryColor
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Remix.file_list_fill,
              color: _selectedIndex != 2 ? appPrimaryColor : secondaryColor
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            // icon: SvgPicture.asset("assets/images/cart_icon.svg",
            //   color: _selectedIndex != 3 ? appPrimaryColor : secondaryColor
            // ),
            icon: Icon(
              Remix.wallet_2_line,
              color: _selectedIndex != 3 ? appPrimaryColor : secondaryColor
            ),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/profile_icon.svg",
              color: _selectedIndex != 4 ? appPrimaryColor : secondaryColor
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: secondaryColor,
        unselectedItemColor: appPrimaryColor,
        onTap: _onItemTapped,
      ) :
      BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
          //  icon: SvgPicture.asset("assets/images/home_icon.svg",
          //     color: _selectedIndex != 0 ? Colors.grey.withOpacity(0.3) : secondaryColor
          //   ),
            icon: Icon(
              Remix.home_7_line,
              color: _selectedIndex != 0 ? appPrimaryColor : secondaryColor
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Remix.file_list_fill,
              color: _selectedIndex != 1 ? appPrimaryColor : secondaryColor
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/search_icon.svg",
              color: _selectedIndex != 2 ? appPrimaryColor : secondaryColor
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/cart_icon.svg",
              color: _selectedIndex != 3 ? appPrimaryColor : secondaryColor
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/profile_icon.svg",
              color: _selectedIndex != 4 ? appPrimaryColor : secondaryColor
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: secondaryColor,
        unselectedItemColor: appPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

