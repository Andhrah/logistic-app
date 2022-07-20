import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/src/models/rider/order_response.dart';

class RiderStreamSocket with BaseBloc<OrderResponse, String> {
  String? _socketID;

  String? get socketID => _socketID;

  void addResponseOnMove(OrderResponse event) {
    addToModel(event);
  }

  updateSocketID(String socketID) => _socketID = socketID;

  invalidate() => invalidateBaseBloc();

  void dispose() async {
    disposeBaseBloc();
  }
}

RiderStreamSocket riderStreamSocket = RiderStreamSocket();
