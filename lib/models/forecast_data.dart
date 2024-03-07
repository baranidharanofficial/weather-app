class ForecastData {
  List<DailyTimeline> timelines;
  Location location;

  ForecastData({
    required this.timelines,
    required this.location,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      timelines: List<DailyTimeline>.from(
        json['timelines']['daily'].map(
          (x) => DailyTimeline.fromJson(x),
        ),
      ),
      location: Location.fromJson(json['location']),
    );
  }
}

class DailyTimeline {
  DateTime time;
  Values values;

  DailyTimeline({
    required this.time,
    required this.values,
  });

  factory DailyTimeline.fromJson(Map<String, dynamic> json) {
    return DailyTimeline(
      time: DateTime.parse(json['time']),
      values: Values.fromJson(json['values']),
    );
  }
}

class Values {
  double? temperatureAvg;
  double? temperatureMax;
  double? temperatureMin;

  Values({
    this.temperatureAvg,
    this.temperatureMax,
    this.temperatureMin,
  });

  factory Values.fromJson(Map<String, dynamic> json) {
    return Values(
      temperatureAvg: json['temperatureAvg']?.toDouble(),
      temperatureMax: json['temperatureMax']?.toDouble(),
      temperatureMin: json['temperatureMin']?.toDouble(),
    );
  }
}

class Location {
  final double lat;
  final double lon;
  final String name;
  final String type;

  Location(
      {required this.lat,
      required this.lon,
      required this.name,
      required this.type});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lon: json['lon'],
      name: json['name'] ?? "",
      type: json['type'] ?? "",
    );
  }
}
