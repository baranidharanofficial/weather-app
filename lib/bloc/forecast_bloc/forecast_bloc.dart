import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_assignment/api/data_service.dart';
import 'package:weather_app_assignment/models/forecast_data.dart';

// Importing event and state classes
part "forecast_event.dart";
part "forecast_state.dart";

// Bloc class for managing forecast data
class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  // Constructor initializing the bloc with initial state and event handlers
  ForecastBloc() : super(ForecastInitial()) {
    // Listening for initial fetch event and calling corresponding method
    on<ForecastInitialFetchEvent>(forecastInitialFetchEvent);
  }

  // Event handler method for initial fetch event
  FutureOr<void> forecastInitialFetchEvent(
      ForecastInitialFetchEvent event, Emitter<dynamic> emit) async {
    // Emitting loading state to indicate data retrieval is in progress
    emit(ForecastLoading());

    // Fetching forecast data from DataService based on event location
    ForecastData? forecastData =
        await DataService.fetchForecastData(event.location);

    // Uncomment the line below for debugging purposes
    // print(forecastData!.timelines);

    // Checking if forecast data is successfully retrieved
    if (forecastData != null) {
      // Emitting success state with retrieved forecast data
      emit(ForecastFetchSuccessState(forecastData: forecastData));
    } else {
      // Emitting error state if forecast data retrieval fails
      emit(ForecastError());
    }
  }
}
