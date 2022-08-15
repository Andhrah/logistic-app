/*
*
*  Created by [Folarin Opeyemi].
*  Copyright © 2022 [Zebrra]. All rights reserved.
    */

import 'package:custom_bloc/custom_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomerStreamSocket with BaseBloc<LatLng, String> {
  String? _socketID;

  String? get socketID => _socketID;

  void addResponseOnMove(LatLng currentLatLng) {
    addToModel(currentLatLng);
  }

  updateSocketID(String socketID) => _socketID = socketID;

  invalidate() => invalidateBaseBloc();

  void dispose() async {
    disposeBaseBloc();
  }
}

CustomerStreamSocket customerStreamSocket = CustomerStreamSocket();
