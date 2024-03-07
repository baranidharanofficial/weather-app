import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_assignment/bloc/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app_assignment/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app_assignment/models/forecast_data.dart';
import 'package:weather_app_assignment/models/weather_data.dart';
import 'package:weather_app_assignment/utils/utils.dart';
import 'package:weather_app_assignment/widgets/forecast_weather.dart';
import 'package:weather_app_assignment/widgets/todays_weather.dart';

// This is the homepage widget that is a StatefulWidget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// This is the state class for the HomePage widget
class _HomePageState extends State<HomePage> {
  WeatherData? weatherData;
  ForecastData? forcastData;
  String location = "Bengaluru"; // Default location
  TextEditingController controller = TextEditingController();
  WeatherBloc weatherBloc = WeatherBloc();
  ForecastBloc forecastBloc = ForecastBloc();

  // This method is called when the stateful widget is initialized
  @override
  void initState() {
    controller.text = location;
    setState(() {});
    getCurrentLocation(); // Get current location

    super.initState();
  }

  // Method to get the current location
  Future<void> getCurrentLocation() async {
    bool isPermitted = await checkLocationPermission();

    if (isPermitted) {
      location = await fetchCurrentLocation();
      controller.text = location;
      setState(() {});
    }

    // Fetch weather and forecast data for the current location
    weatherBloc.add(WeatherInitialFetchEvent(location: location));
    forecastBloc.add(ForecastInitialFetchEvent(location: location));
  }

  // This method builds the UI of the widget
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            location,
            style: GoogleFonts.poppins(
              color: theme.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: const Padding(
          padding: EdgeInsets.only(
            top: 12.0,
            left: 24,
          ),
          child: Icon(
            Icons.cloud_rounded,
            size: 32,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Show modal bottom sheet to change location
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                              color: theme.primaryColorDark.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: controller,
                              autofocus: true,
                              cursorColor: theme.primaryColor,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Eg., Chennai or lat, long",
                                hintStyle: GoogleFonts.poppins(
                                  color: theme.primaryColor.withOpacity(0.3),
                                ),
                              ),
                              style: GoogleFonts.poppins(
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        FilledButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              location = controller.text;
                              setState(() {});
                              // Fetch weather and forecast data for new location
                              weatherBloc.add(
                                  WeatherInitialFetchEvent(location: location));
                              forecastBloc.add(ForecastInitialFetchEvent(
                                  location: location));
                            } else {
                              var snackBar = SnackBar(
                                backgroundColor: theme.highlightColor,
                                content: Text(
                                  'Not a valid location',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: theme.primaryColor,
                                  ),
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }

                            Navigator.pop(context);
                          },
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Change",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: theme.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
                right: 16,
              ),
              child: Icon(
                Icons.edit_location_alt_outlined,
                color: theme.primaryColorDark,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCurrentLocation();
        },
        tooltip: "Get Current location weather",
        backgroundColor: theme.primaryColorDark,
        child: const Icon(
          Icons.refresh,
          size: 32,
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocConsumer<WeatherBloc, WeatherState>(
                bloc: weatherBloc,
                listenWhen: (previous, current) =>
                    current is WeatherActionState,
                buildWhen: (previous, current) =>
                    current is! WeatherActionState,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case const (WeatherLoading):
                      return TodayLoader(theme: theme); // Loading state

                    case const (WeatherFetchSuccessState):
                      final successState = state as WeatherFetchSuccessState;

                      return TodaysWeather(
                        // Widget to display today's weather
                        successState: successState,
                        theme: theme,
                      );

                    case const (WeatherError):
                      return TodayError(theme: theme); // Error state

                    default:
                      return const SizedBox();
                  }
                },
                listener: (context, state) {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "5-day Forecast",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: theme.primaryColorDark.withOpacity(0.4),
                      ),
                    ),
                    Text(
                      "High / Low",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: theme.primaryColorDark.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
              BlocConsumer<ForecastBloc, ForecastState>(
                bloc: forecastBloc,
                listenWhen: (previous, current) =>
                    current is ForecastActionState,
                buildWhen: (previous, current) =>
                    current is! ForecastActionState,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case const (ForecastLoading):
                      return ForecastLoader(theme: theme); // Loading state

                    case const (ForecastFetchSuccessState):
                      final successState = state as ForecastFetchSuccessState;

                      return ForecastWeather(
                          // Widget to display forecast weather
                          successState: successState,
                          theme: theme);

                    case const (ForecastError):
                      return ForecastErrorWidget(theme: theme); // Error state

                    default:
                      return const SizedBox();
                  }
                },
                listener: (context, state) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
