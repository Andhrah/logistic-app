import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trakk/src/bloc/app_settings_bloc.dart';
import 'package:trakk/src/models/app_settings.dart';
import 'package:trakk/src/models/order/order.dart';
import 'package:trakk/src/screens/dispatch/item_detail/item_details.dart';
import 'package:trakk/src/screens/dispatch/order/order.dart';
import 'package:trakk/src/screens/merchant/company_home.dart';
import 'package:trakk/src/screens/profile/dispatch_history_screen/user_dispatch_history.dart';
import 'package:trakk/src/screens/profile/profile_menu.dart';
import 'package:trakk/src/screens/riders/home/rider_home.dart';
import 'package:trakk/src/screens/wallet/wallet.dart';
import 'package:trakk/src/utils/app_toast.dart';
import 'package:trakk/src/values/enums.dart';
import 'package:trakk/src/values/values.dart';

class Tabs extends StatefulWidget {
  static const String id = 'tab';

  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _selectedIndex = 0;

  String currentTitle = 'Home';

  OrderModel? orderModel;

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
                    ? RiderHomeScreen(_onItemTapped)
                    : snapshot.data?.loginResponse?.data?.user?.userType ==
                            "customer"
                        ? ItemDetails(orderModel: orderModel)
                        : CompanyHome(_onItemTapped);
              }
              return const SizedBox();
            });
      case 1:
        return StreamBuilder<AppSettings>(
            stream: appSettingsBloc.appSettings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data?.loginResponse?.data?.user?.userType ==
                    "customer") {
                  currentTitle = 'Order';
                  return CustomerOrderScreen(_onItemTapped);
                } else {
                  currentTitle = 'Dispatch history';
                  return const UserDispatchHistory(
                    canPop: false,
                  );
                }
              }
              return const SizedBox();
            });

      case 2:
        currentTitle = 'Wallet';
        return const WalletScreen();
      default:
        return StreamBuilder<AppSettings>(
            stream: appSettingsBloc.appSettings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data?.loginResponse?.data?.user?.userType ==
                    "customer") {
                  currentTitle = 'Profile';
                  return const ProfileMenu();
                } else {
                  currentTitle = 'More';
                  return const ProfileMenu();
                }
              }
              return const SizedBox();
            });
    }
  }

  _onItemTapped(int index, {OrderModel? orderModel}) {
    if (index == 2) {
      runToast('Coming soon!!');
    }
    print(orderModel?.data?.receiverName);
    setState(() {
      this.orderModel = orderModel;
      _selectedIndex = index == 2 ? _selectedIndex : index;
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _willPop() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return WillPopScope(
      onWillPop: _willPop,
      child: FutureBuilder<UserType>(
          future: appSettingsBloc.getUserType,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == UserType.none) {
                return const Scaffold(
                  body: SizedBox(),
                );
              }
              return Scaffold(
                body: _currentOtherUserPage(_selectedIndex),
                bottomNavigationBar: SizedBox(
                  height: 70,
                  child: BottomNavigationBar(
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
                          padding: const EdgeInsets.symmetric(vertical: 3.5),
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
                          padding: const EdgeInsets.symmetric(vertical: 3.5),
                          child: Icon(
                            snapshot.data == UserType.customer
                                ? Remix.file_list_line
                                : Remix.history_line,
                            color: _selectedIndex != 1
                                ? appPrimaryColor
                                : secondaryColor,
                            size: 24,
                          ),
                        ),
                        label: snapshot.data == UserType.customer
                            ? 'Order'
                            : 'History',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.5),
                          child: Icon(
                            Remix.wallet_2_line,
                            color: _selectedIndex != 2
                                ? appPrimaryColor.withOpacity(0.35)
                                : secondaryColor.withOpacity(0.35),
                            size: 24,
                          ),
                        ),
                        label: 'Wallet',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.5),
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
          }),
    );
  }
}
