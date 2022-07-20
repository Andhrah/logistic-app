import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/screens/dispatch/cart.dart';
import 'package:trakk/src/screens/dispatch/item_detail/item_details.dart';
import 'package:trakk/src/screens/dispatch/order/order.dart';
import 'package:trakk/src/screens/merchant/company_home.dart';
import 'package:trakk/src/screens/profile/dispatch_history_screen/user_dispatch_history.dart';
import 'package:trakk/src/screens/profile/profile_menu.dart';
import 'package:trakk/src/screens/riders/home/rider_home.dart';
import 'package:trakk/src/screens/wallet/wallet.dart';
import 'package:trakk/src/values/values.dart';
import 'package:trakk/src/values/enums.dart';

class Tabs extends StatefulWidget {
  static const String id = 'tab';

  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;

  String currentTitle = 'Home';

  Widget _currentUserPage(_selectedIndex) {
    switch (_selectedIndex) {
      case 0:
        currentTitle = 'Home';
        return const ItemDetails();
      // case 1:
      //   currentTitle = 'Cart';
      //   return const CartScreen();
      case 1:
        currentTitle = 'Order';
        return const UserOrderScreen();
      case 2:
        currentTitle = 'Wallet';
        return const WalletScreen();
      default:
        currentTitle = 'Profile';
        return const ProfileMenu();
    }
  }

  Widget _currentOtherUserPage(_selectedIndex) {
    switch (_selectedIndex) {
      case 0:
        currentTitle = 'Home';
        return StreamBuilder<AppSettings>(
            stream: appSettingsBloc.appSettings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data?.loginResponse?.data?.user?.userType ==
                        "rider"
                    ? const RiderHomeScreen()
                    : const CompanyHome();
              }
              return const SizedBox();
            });
      case 1:
        currentTitle = 'Dispatch history';
        return const UserDispatchHistory(
          canPop: false,
        );
      case 2:
        currentTitle = 'Wallet';
        return const WalletScreen();
      // case 2:
      //   currentTitle = 'Cart';
      //   return const CartScreen();
      default:
        currentTitle = 'More';
        return const ProfileMenu();
    }
  }

  // Widget _currentMerchantPage (_selectedIndex){
  //   switch (_selectedIndex){
  //     case 0 :
  //       currentTitle = 'Home';
  //       return const CompanyData();
  //     case 1 :
  //       currentTitle = 'Wallet';
  //       return const WalletScreen();
  //     case 2 :
  //       currentTitle = 'Wallet';
  //       return Container();
  //     case 3 :
  //       currentTitle = 'Histroy';
  //       return Container();
  //     default:
  //       currentTitle = 'Profile';
  //       return const ProfileMenu();
  //   }
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final arg = ModalRoute.of(context)!.settings.arguments as Map;
        int? index = arg["_selectedIndex"];
        if (index != null) {
          _selectedIndex = index;
        }
      }
    });
    // _fetchUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return FutureBuilder<UserType>(
        future: appSettingsBloc.getUserType,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == UserType.none) {
              return const Scaffold(
                body: SizedBox(),
              );
            }
            return Scaffold(
              body: snapshot.data == UserType.customer
                  ? _currentUserPage(_selectedIndex)
                  : _currentOtherUserPage(_selectedIndex),
              bottomNavigationBar: SizedBox(
                height: 70,
                child: snapshot.data == UserType.customer
                    ? BottomNavigationBar(
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        type: BottomNavigationBarType.fixed,
                        selectedLabelStyle: theme.textTheme.caption,
                        unselectedLabelStyle: theme.textTheme.caption,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.5),
                              child: Icon(
                                Remix.home_7_line,
                                color: _selectedIndex != 0
                                    ? appPrimaryColor
                                    : secondaryColor,
                                size: 24,
                              ),
                            ),
                            label: 'Home',
                          ),
                          // BottomNavigationBarItem(
                          //   icon: Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(vertical: 3.5),
                          //     child: Icon(
                          //       Remix.shopping_cart_2_line,
                          //       color: _selectedIndex != 1
                          //           ? appPrimaryColor
                          //           : secondaryColor,
                          //       size: 24,
                          //     ),
                          //   ),
                          //   label: 'Cart',
                          // ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.5),
                              child: Icon(
                                Remix.file_list_fill,
                                color: _selectedIndex != 1
                                    ? appPrimaryColor
                                    : secondaryColor,
                                size: 24,
                              ),
                            ),
                            label: 'Order',
                          ),
                          BottomNavigationBarItem(
                            // icon: SvgPicture.asset("assets/images/cart_icon.svg",
                            //   color: _selectedIndex != 3 ? appPrimaryColor : secondaryColor
                            // ),
                            icon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.5),
                              child: Icon(
                                Remix.wallet_2_line,
                                color: _selectedIndex != 2
                                    ? appPrimaryColor
                                    : secondaryColor,
                                size: 24,
                              ),
                            ),
                            label: 'Wallet',
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.5),
                              child: SvgPicture.asset(
                                "assets/images/profile_icon.svg",
                                color: _selectedIndex != 3
                                    ? appPrimaryColor
                                    : secondaryColor,
                                width: 24,
                                height: 24,
                              ),
                            ),
                            label: 'Profile',
                          ),
                        ],
                        currentIndex: _selectedIndex,
                        selectedItemColor: secondaryColor,
                        unselectedItemColor: appPrimaryColor,
                        onTap: _onItemTapped,
                      )
                    : BottomNavigationBar(
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        type: BottomNavigationBarType.fixed,
                        selectedLabelStyle: theme.textTheme.caption,
                        unselectedLabelStyle: theme.textTheme.caption,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            //  icon: SvgPicture.asset("assets/images/home_icon.svg",
                            //     color: _selectedIndex != 0 ? Colors.grey.withOpacity(0.3) : secondaryColor
                            //   ),
                            icon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.5),
                              child: Icon(
                                Remix.home_7_line,
                                color: _selectedIndex != 0
                                    ? appPrimaryColor
                                    : secondaryColor,
                                size: 24,
                              ),
                            ),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.5),
                              child: Icon(
                                Remix.history_line,
                                color: _selectedIndex != 1
                                    ? appPrimaryColor
                                    : secondaryColor,
                                size: 24,
                              ),
                            ),
                            label: 'History',
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.5),
                              child: Icon(
                                Remix.wallet_2_line,
                                color: _selectedIndex != 2
                                    ? appPrimaryColor
                                    : secondaryColor,
                                size: 24,
                              ),
                            ),
                            label: 'Wallet',
                          ),
                          BottomNavigationBarItem(
                            icon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.5),
                              child: SvgPicture.asset(
                                "assets/images/profile_icon.svg",
                                color: _selectedIndex != 3
                                    ? appPrimaryColor
                                    : secondaryColor,
                                width: 24,
                                height: 24,
                              ),
                            ),
                            label: 'Profile',
                          ),
                        ],
                        currentIndex: _selectedIndex,
                        selectedItemColor: secondaryColor,
                        unselectedItemColor: appPrimaryColor,
                        onTap: _onItemTapped,
                      ),
              ),
            );
          }
          return const SizedBox();
        });
  }
}
