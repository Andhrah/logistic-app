import 'package:async/async.dart';
import 'package:custom_bloc/custom_bloc.dart';
import 'package:location/location.dart' as Loca;
import 'package:rxdart/rxdart.dart';

class MiscBloc {
  MiscBloc() {
    fetchLocation();
  }

  CancelableOperation? _cancelableOperation;

  //user location
  BehaviorSubject<BaseModel<Loca.LocationData, String>> get myLocationSubject =>
      _myLocationSubject;
  final BehaviorSubject<BaseModel<Loca.LocationData, String>>
      _myLocationSubject =
      BehaviorSubject<BaseModel<Loca.LocationData, String>>();

  Loca.LocationData? currentLocation;

  Future<Loca.LocationData?> fetchLocation() async {
    var location = Loca.Location();
    print('called');
    try {
      currentLocation = await location.getLocation();

      _myLocationSubject.addStream(location.onLocationChanged.map(
          (event) => BaseModel(model: event, itemState: ItemState.hasData)));

      return currentLocation;
    } on Exception {
      currentLocation = null;
      print('called now now');
      return currentLocation;
    }
  }

  cancelOperation() async {
    await _cancelableOperation?.cancel();
  }

  invalidate() {
    currentLocation = null;
  }

  dispose() async {
    await _myLocationSubject.drain();
    _myLocationSubject.close();
  }
}

final miscBloc = MiscBloc();
