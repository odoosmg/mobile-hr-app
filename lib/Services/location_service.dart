import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart' as location_;

class LocationService {
  Future<geo.LocationPermission> requestPermission() async {
    geo.LocationPermission permission;

    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.always ||
        permission == geo.LocationPermission.whileInUse) {
    } else {
      location_.Location location = location_.Location();
      var permissionGranted = await location.hasPermission();
      if (permissionGranted == location_.PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != location_.PermissionStatus.granted) {
          // debugPrint('Location permission denied');
        }
      }
    }

    return permission;
  }

  /// Status
  Future<geo.LocationPermission> permissoinStatus() async {
    return await geo.Geolocator.checkPermission();
  }

  /// Current location
  Future<geo.Position> getCurrentLocation() async {
    geo.Position position = await geo.Geolocator.getCurrentPosition(
      desiredAccuracy: geo.LocationAccuracy.high,
    );
    return position;
  }
}
