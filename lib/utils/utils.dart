import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

// Function to fetch the current location using Geolocator plugin
Future<String> fetchCurrentLocation() async {
  try {
    // Getting the current position with desired accuracy
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    // Returning the latitude and longitude of the current position
    return "${position.latitude.toStringAsFixed(3)}, ${position.longitude.toStringAsFixed(3)}";
  } catch (e) {
    // Handling errors and returning a default location if unable to get the current position
    print(e);
    return "Bengaluru"; // Default location if unable to get current position
  }
}

// Function to check location permission using Geolocator plugin
Future<bool> checkLocationPermission() async {
  // Checking the current location permission status
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    // Requesting location permission if it's denied
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Returning false if permission is still denied
      return false;
    } else {
      // Returning true if permission is granted after request
      return true;
    }
  } else {
    // Returning true if permission is already granted
    return true;
  }
}

// Function to format date string using DateFormat
String formatDate(DateTime dateString) {
  // Formatting the date string to 'Month day, year' format
  String formattedDate = DateFormat('MMMM d, yyyy').format(dateString);
  return formattedDate;
}
