import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_assignment/bloc/forecast_bloc/forecast_bloc.dart';
import 'package:weather_app_assignment/utils/utils.dart';
import 'package:weather_app_assignment/widgets/degree_text.dart';

class ForecastWeather extends StatelessWidget {
  const ForecastWeather({
    super.key,
    required this.successState,
    required this.theme,
  });

  final ForecastFetchSuccessState successState;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.primaryColorDark.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: successState.forecastData.timelines
                .map(
                  (daily) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/weather.png",
                              height: 40,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              formatDate(daily.time),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: theme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            DegreeText(
                              theme: theme,
                              temp: daily.values.temperatureMax!
                                  .toInt()
                                  .toString(),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "/",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: theme.primaryColor,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            DegreeText(
                              theme: theme,
                              temp: daily.values.temperatureMin!
                                  .toInt()
                                  .toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ForecastLoader extends StatelessWidget {
  const ForecastLoader({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
            duration: const Duration(
              milliseconds: 800,
            ),
          ),
    );
  }
}

class ForecastErrorWidget extends StatelessWidget {
  const ForecastErrorWidget({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
      ),
    );
  }
}
