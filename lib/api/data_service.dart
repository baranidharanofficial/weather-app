import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_assignment/models/forecast_data.dart';
import 'package:weather_app_assignment/models/weather_data.dart';

// Base URL for API requests
String baseURL = "https://api.tomorrow.io/v4/weather/";
// API key for authentication
String apiKey = '2aj7QwO7BAn76KjXQ6V8Ww5QMcPefSJU';

class DataService {
  // Method to fetch current weather data
  static Future<WeatherData?> fetchWeatherData(String location) async {
    // Constructing the API URL for weather data retrieval
    String apiUrl = '${baseURL}realtime?location=$location&apikey=$apiKey';

    try {
      // Sending HTTP GET request to the API
      final response = await http.get(Uri.parse(apiUrl));

      // Uncomment the line below for debugging purposes
      // print('Test ${response.body}');

      // Checking if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parsing the JSON response and creating a WeatherData object
        final Map<String, dynamic> jsonData = json.decode(response.body);
        WeatherData weatherData = WeatherData.fromJson(jsonData);

        return weatherData; // Returning the retrieved weather data
      } else {
        // Logging an error message if the request fails
        debugPrint('Failed to load weather data: ${response.statusCode}');
        return null; // Returning null in case of failure
      }
    } catch (e) {
      // Handling any exceptions that occur during the request
      debugPrint('Error 1: $e');
      return null; // Returning null in case of an exception
    }
  }

  // Method to fetch forecast data
  static Future<ForecastData?> fetchForecastData(String location) async {
    // Constructing the API URL for forecast data retrieval
    String apiUrl = '${baseURL}forecast?location=$location&apikey=$apiKey';

    try {
      // Sending HTTP GET request to the API
      final response = await http.get(Uri.parse(apiUrl));

      // Uncomment the line below for debugging purposes
      // print('Test ${response.body}');

      // Checking if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parsing the JSON response and creating a ForecastData object
        final Map<String, dynamic> jsonData = json.decode(response.body);
        ForecastData forecastData = ForecastData.fromJson(jsonData);

        return forecastData; // Returning the retrieved forecast data
      } else {
        // Logging an error message if the request fails
        debugPrint('Failed to load weather data: ${response.statusCode}');
        return null; // Returning null in case of failure
      }
    } catch (e) {
      // Handling any exceptions that occur during the request
      debugPrint('Error 2: $e');
      return null; // Returning null in case of an exception
    }
  }
}
