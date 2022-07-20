/*  Trakk
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra Technologies]. All rights reserved.
*/


import 'package:flutter/material.dart';

class TrakkTextScaleValue {
  const TrakkTextScaleValue(this.scale, this.label);

  final double? scale;
  final String label;

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    final TrakkTextScaleValue typedOther = other;
    return scale == typedOther.scale && label == typedOther.label;
  }

  @override
  int get hashCode => hashValues(scale, label);

  @override
  String toString() {
    return '$runtimeType($label)';
  }
}

const List<TrakkTextScaleValue> kAllTrakkTextScaleValues =
    <TrakkTextScaleValue>[
  TrakkTextScaleValue(null, 'System Default'),
  TrakkTextScaleValue(0.8, 'Small'),
  TrakkTextScaleValue(1.0, 'Normal'),
  TrakkTextScaleValue(1.2, 'Large'),
//  TimbalaTextScaleValue(2.0, 'Huge'),
];
