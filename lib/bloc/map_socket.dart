import 'package:custom_bloc/custom_bloc.dart';
import 'package:trakk/models/rider/order_response.dart';

class StreamSocket with BaseBloc<OrderResponse, String> {
  String? _socketID;

  String? get socketID => _socketID;

  //on move

  void addResponseOnMove(OrderResponse event) {
    addToModel(event);
  }

  // //on surrounding client broadcast
  // final _surroundingResponse = BehaviorSubject<List<OrderResponse>>();
  //
  // void Function(List<OnNewRequestResponse>) get addSurroundingResponse =>
  //     _surroundingResponse.sink.add;
  //
  // BehaviorSubject<List<OnNewRequestResponse>> get getSurroundingResponse =>
  //     _surroundingResponse;

  updateSocketID(String socketID) => _socketID = socketID;

  invalidate() => invalidateBaseBloc();

  void dispose() async {
    disposeBaseBloc();

    // await _surroundingResponse.drain();
    // _surroundingResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();
