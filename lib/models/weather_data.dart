class WeatherData {
  final DateTime time;
  final WeatherValues values;
  final WeatherLocation location;

  WeatherData(
      {required this.time, required this.values, required this.location});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      time: DateTime.parse(json['data']['time']),
      values: WeatherValues.fromJson(json['data']['values']),
      location: WeatherLocation.fromJson(json['location']),
    );
  }
}

class WeatherValues {
  final int cloudCover;
  final int humidity;
  final double temperature;
  final double windSpeed;

  WeatherValues({
    required this.cloudCover,
    required this.humidity,
    required this.temperature,
    required this.windSpeed,
  });

  factory WeatherValues.fromJson(Map<String, dynamic> json) {
    return WeatherValues(
      cloudCover: json['cloudCover'] ?? 0,
      humidity: json['humidity'] ?? 0,
      temperature: double.parse((json['temperature'] ?? "0").toString()),
      windSpeed: double.parse((json['windSpeed'] ?? "0").toString()),
    );
  }
}

class WeatherLocation {
  final double lat;
  final double lon;
  final String name;
  final String type;

  WeatherLocation(
      {required this.lat,
      required this.lon,
      required this.name,
      required this.type});

  factory WeatherLocation.fromJson(Map<String, dynamic> json) {
    return WeatherLocation(
      lat: json['lat'],
      lon: json['lon'],
      name: json['name'] ?? "",
      type: json['type'] ?? "",
    );
  }
}
