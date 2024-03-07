import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DegreeText extends StatelessWidget {
  final String temp;
  const DegreeText({
    super.key,
    required this.temp,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          temp,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: theme.primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0, left: 2),
          child: Text(
            "O",
            style: GoogleFonts.poppins(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: theme.primaryColorDark,
            ),
          ),
        ),
      ],
    );
  }
}
