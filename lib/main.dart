import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/providers/navigation_provider.dart';
import 'package:ticket_resale/screens/screens.dart';
import 'package:ticket_resale/utils/app_routes.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const TicketResale(),
      ),
    );

class TicketResale extends StatelessWidget {
  const TicketResale({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
          create: (context) {
            return NavigationProvider();
          },
        )
      ],
      child: MaterialApp(
          onGenerateRoute: onGenerateRoute,
          theme: ThemeData(
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen()),
    );
  }
}
