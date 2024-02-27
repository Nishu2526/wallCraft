import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  String word1;
  String word2;
  CustomAppBar({super.key, required this.word1, required this.word2});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: word1,
            style: GoogleFonts.poppins(
                color: Colors.black87,
                letterSpacing: 2,
                fontSize: 25,
                fontWeight: FontWeight.w800),
            children: [
              TextSpan(
                  text: word2,
                  style: GoogleFonts.portLligatSans(
                      letterSpacing: 3,
                      color: Colors.blueAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.w700)),
            ]));
  }
}
