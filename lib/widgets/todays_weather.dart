import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_assignment/bloc/weather_bloc/weather_bloc.dart';

class TodaysWeather extends StatelessWidget {
  const TodaysWeather({
    super.key,
    required this.successState,
    required this.theme,
  });

  final WeatherFetchSuccessState successState;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Image.asset(
                "assets/icons/weather.png",
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    successState.weatherData.values.temperature
                        .toInt()
                        .toString(),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 84,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                    ),
                    child: Text(
                      "O",
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: theme.primaryColorDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.cloud,
                    size: 32,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${successState.weatherData.values.cloudCover.toString()} %",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColorDark,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.air,
                    size: 32,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${successState.weatherData.values.windSpeed.toString()} m/s",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColorDark,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.water_drop_rounded,
                    size: 32,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${successState.weatherData.values.humidity.toString()} %",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColorDark,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TodayError extends StatelessWidget {
  const TodayError({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.highlightColor.withOpacity(0.1),
      ),
      child: Center(
        child: Text(
          "API limit Reached. Try again later",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: theme.highlightColor.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}

class TodayLoader extends StatelessWidget {
  const TodayLoader({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.primaryColorDark.withOpacity(0.1),
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(
          color: theme.primaryColor.withOpacity(0.5),
          duration: const Duration(milliseconds: 800),
        );
  }
}
