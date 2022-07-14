/*
*  styles.dart
*  Trakk
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra Technologies]. All rights reserved.
    */

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:trakk/utils/colors.dart';

const kCircularProgressIndicator =
    CircularProgressIndicator(color: secondaryColor);

class LoadingDataStyle extends StatelessWidget {
  double height;
  double width;
  Color bgColor;
  Color? baseColor;
  Color? highlightColor;
  bool isCircle;

  double borderRadius;

  LoadingDataStyle(
      {this.height = 24,
      this.width = double.infinity,
      this.bgColor = Colors.white,
      this.borderRadius = 10,
      this.baseColor,
      this.highlightColor,
      this.isCircle = false}) {
    if (this.baseColor == null) {
      this.baseColor = Colors.grey[300];
    }
    if (this.highlightColor == null) {
      this.highlightColor = Colors.grey[100];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: baseColor!,
        highlightColor: highlightColor!,
        enabled: true,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius:
                  isCircle ? null : BorderRadius.circular(borderRadius),
              color: bgColor,
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle),
        ),
      ),
    );
  }
}

class LoadingDataListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        child: Container(
      height: 63,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.grey.shade300),
    ));
  }
}
