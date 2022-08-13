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

class CustomerOrderInFocus with BaseBloc<int, String> {
  CustomerOrderInFocus() {
    setOrderInFocusID(inFocusOrderId);
  }

  int inFocusOrderId = -1;

  setOrderInFocusID(int orderId) {
    inFocusOrderId = orderId;
    addToModel(inFocusOrderId);
  }

  invalidate() {
    inFocusOrderId = -1;
    invalidateBaseBloc();
  }

  void dispose() {
    disposeBaseBloc();
  }
}

CustomerOrderInFocus customerOrderInFocus = CustomerOrderInFocus();
