import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_assignment/api/data_service.dart';
import 'package:weather_app_assignment/models/weather_data.dart';

// Importing event and state classes
part "weather_event.dart";
part "weather_state.dart";

// Bloc class for managing weather data
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // Constructor initializing the bloc with initial state and event handlers
  WeatherBloc() : super(WeatherInitial()) {
    // Listening for initial fetch event and calling corresponding method
    on<WeatherInitialFetchEvent>(weatherInitialFetchEvent);
  }

  // Event handler method for initial fetch event
  FutureOr<void> weatherInitialFetchEvent(
      WeatherInitialFetchEvent event, Emitter<dynamic> emit) async {
    // Emitting loading state to indicate data retrieval is in progress
    emit(WeatherLoading());

    // Fetching weather data from DataService based on event location
    WeatherData? weatherData =
        await DataService.fetchWeatherData(event.location);

    // Checking if weather data is successfully retrieved
    if (weatherData != null) {
      // Emitting success state with retrieved weather data
      emit(WeatherFetchSuccessState(weatherData: weatherData));
    } else {
      // Emitting error state if weather data retrieval fails
      emit(WeatherError());
    }
  }
}
