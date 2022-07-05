import 'package:custom_bloc/custom_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trakk/models/rider/on_move_response.dart';

class StreamSocket with BaseBloc<OnMoveResponse, String> {
  String? _socketID;

  String? get socketID => _socketID;

  //on move
  final _socketResponse = BehaviorSubject<OnMoveResponse>();

  void addResponseOnMove(OnMoveResponse event) {
    addToModel(event);
  }

  BehaviorSubject<OnMoveResponse> get getResponse => _socketResponse;

  //on surrounding client broadcast
  final _surroundingResponse = BehaviorSubject<List<OnMoveResponse>>();

  void Function(List<OnMoveResponse>) get addSurroundingResponse =>
      _surroundingResponse.sink.add;

  BehaviorSubject<List<OnMoveResponse>> get getSurroundingResponse =>
      _surroundingResponse;

  updateSocketID(String socketID) => _socketID = socketID;

  invalidate() => invalidateBaseBloc();

  void dispose() async {
    await _socketResponse.drain();
    _socketResponse.close();

    await _surroundingResponse.drain();
    _surroundingResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();
