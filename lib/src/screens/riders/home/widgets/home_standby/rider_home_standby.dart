import 'package:flutter/material.dart';
import 'package:trakk/src/bloc/misc_bloc.dart';
import 'package:trakk/src/screens/riders/home/widgets/home_standby/rider_bottom_sheet.dart';
import 'package:trakk/src/screens/riders/home/widgets/home_standby/rider_location_card.dart';
import 'package:trakk/src/screens/riders/home/widgets/home_standby/rider_top_part.dart';
import 'package:trakk/src/values/assets.dart';

class RiderHomeStandbyScreen extends StatelessWidget {
  final MiscBloc locaBloc;
  final Function(int index) forHomeNavigation;

  static const String id = 'riderHome';

  const RiderHomeStandbyScreen(this.locaBloc, this.forHomeNavigation,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.rider_home_bg), fit: BoxFit.cover)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RiderTopPart(forHomeNavigation),
              const Spacer(),
              RiderLocationCard(locaBloc),
              const Spacer(flex: 2),
            ],
          ),
          const RiderBottomSheet(),
        ],
      ),
    );
  }
}
