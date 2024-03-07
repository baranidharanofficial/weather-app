part of "forecast_bloc.dart";

abstract class ForecastEvent {}

class ForecastInitialFetchEvent extends ForecastEvent {
  String location;

  ForecastInitialFetchEvent({required this.location});
}
