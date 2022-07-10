import 'package:location/location.dart';
import 'package:trakk/utils/app_toast.dart';
import 'package:trakk/utils/colors.dart';

class MiscBloc {
  MiscBloc() {
    fetchLocation();
  }

  var location = Location();

  LocationData? currentLocation;

  Future<LocationData?> fetchLocation() async {
    LocationData? locationData;
    final Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return locationData;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      //TODO: do your logic to manage when user denies the permission
      if (permissionGranted != PermissionStatus.granted) {
        appToast('Permission not granted', redColor);
        return locationData;
      }
    }
    locationData = await location.getLocation();

    return locationData;
  }
}

final miscBloc = MiscBloc();
