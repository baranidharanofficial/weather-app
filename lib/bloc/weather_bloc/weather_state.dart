part of "weather_bloc.dart";

abstract class WeatherState {}

abstract class WeatherActionState extends WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherFetchSuccessState extends WeatherState {
  final WeatherData weatherData;

  WeatherFetchSuccessState({required this.weatherData});
}

class WeatherError extends WeatherState {}
