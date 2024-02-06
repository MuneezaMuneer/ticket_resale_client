import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ticket_resale/screens/splash_screen.dart';
import 'package:ticket_resale/utils/app_routes.dart';

void main() {
  runApp(const TicketResale());
}

class TicketResale extends StatelessWidget {
  const TicketResale({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        fontFamily: GoogleFonts.openSans().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
