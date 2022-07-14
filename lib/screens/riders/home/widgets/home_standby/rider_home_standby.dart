import 'package:flutter/material.dart';
import 'package:trakk/bloc/misc_bloc.dart';
import 'package:trakk/screens/riders/home/widgets/home_standby/rider_bottom_sheet.dart';
import 'package:trakk/screens/riders/home/widgets/home_standby/rider_location_card.dart';
import 'package:trakk/screens/riders/home/widgets/home_standby/rider_top_part.dart';
import 'package:trakk/utils/assets.dart';

class RiderHomeStandbyScreen extends StatefulWidget {
  final MiscBloc locaBloc;

  static const String id = 'riderHome';

  const RiderHomeStandbyScreen(this.locaBloc, {Key? key}) : super(key: key);

  @override
  _RiderHomeStandbyScreenState createState() => _RiderHomeStandbyScreenState();
}

class _RiderHomeStandbyScreenState extends State<RiderHomeStandbyScreen> {
  @override
  void initState() {
    super.initState();
  }

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
              const RiderTopPart(),
              const Spacer(),
              RiderLocationCard(widget.locaBloc),
              const Spacer(flex: 2),
            ],
          ),
          const RiderBottomSheet(),
        ],
      ),
    );
  }
}
