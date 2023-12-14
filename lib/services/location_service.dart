// location_service.dart
import 'package:location/location.dart' as location_package;
import 'package:permission_handler/permission_handler.dart' as permission_package;

class LocationService {
  final location_package.Location _location = location_package.Location();

  Future<location_package.LocationData> getLocation() async {
    await _checkLocationPermission();
    _location.changeSettings(
      accuracy: location_package.LocationAccuracy.high,
      interval: 2500,
      distanceFilter: 10
    );
    _location.enableBackgroundMode(enable: true);
    return await _location.getLocation();
  }

  Future<void> _checkLocationPermission() async {
    permission_package.PermissionStatus permissionStatus = await permission_package.Permission.locationWhenInUse.status;
    if (permissionStatus != permission_package.PermissionStatus.granted) {
      permissionStatus = await permission_package.Permission.locationWhenInUse.request();
      if (permissionStatus != permission_package.PermissionStatus.granted) {
        // Handle the case where the user denied permission
        throw Exception('Location permission not granted.');
      }
    }
  }
}
