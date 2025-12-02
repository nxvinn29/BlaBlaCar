import 'package:geolocator/geolocator.dart';

class LocationService {
  /// Determines the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  // In a real app, you would use a service like Google Places API
  // to get location suggestions based on user input.
  // For this simulation, we'll just return a few mock locations.
  Future<List<String>> getAutocomplete(String input) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final suggestions = [
      'Bengaluru, Karnataka',
      'Chennai, Tamil Nadu',
      'Hyderabad, Telangana',
      'Mumbai, Maharashtra',
      'Delhi, NCR',
      'Kolkata, West Bengal',
      'Pune, Maharashtra',
    ];
    return suggestions.where((s) => s.toLowerCase().contains(input.toLowerCase())).toList();
  }
}
