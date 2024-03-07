part of "forecast_bloc.dart";

abstract class ForecastState {}

abstract class ForecastActionState extends ForecastState {}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastFetchSuccessState extends ForecastState {
  final ForecastData forecastData;

  ForecastFetchSuccessState({required this.forecastData});
}

class ForecastError extends ForecastState {}
