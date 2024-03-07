part of "weather_bloc.dart";

abstract class WeatherEvent {}

class WeatherInitialFetchEvent extends WeatherEvent {
  String location;

  WeatherInitialFetchEvent({required this.location});
}
