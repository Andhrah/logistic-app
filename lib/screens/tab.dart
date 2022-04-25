import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/screens/riders/rider_home.dart';
import 'package:trakk/screens/riders/rider_order.dart';
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
  String currentTitle = 'Home';

  Widget _currentPage (_selectedIndex){
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
      body: _currentPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
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

// class ButtonBarItem extends StatelessWidget {
//   final String icon;
//   final String title;
//   final Color color;
//   final Function onPressed;
//   const ButtonBarItem({
//     required Key key, required this.icon, required this.title, required this.color, required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onPressed(),
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//           SvgPicture.asset("images/$icon.svg"),
//           SizedBox(height: 5,),
//           Text(
//             title, 
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 14, 
//               color: color),
//             )
//         ],),
//       ),
//     );
//   }
// }