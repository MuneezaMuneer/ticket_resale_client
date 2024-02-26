import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/admin_panel/splash_screen_admin.dart';

import 'package:ticket_resale/firebase_options.dart';
import 'package:ticket_resale/providers/drop_down_provider.dart';

import 'package:ticket_resale/providers/providers.dart';

import 'package:ticket_resale/utils/app_routes.dart';

import 'providers/search_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SwitchProvider provider = SwitchProvider();
  await provider.loadPreferences();

  runApp(const TicketResale());
}

class TicketResale extends StatelessWidget {
  const TicketResale({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DropDownProvider>(
          create: (context) => DropDownProvider(),
        ),
        ChangeNotifierProvider<NavigationProvider>(
            create: (context) => NavigationProvider()),
        ChangeNotifierProvider<FeedbackProvider>(
            create: (context) => FeedbackProvider()),
        ChangeNotifierProvider<ImagePickerProvider>(
            create: (context) => ImagePickerProvider()),
        ChangeNotifierProvider<SwitchProvider>(
            create: (context) => SwitchProvider()),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
      ],
      child: MaterialApp(
          onGenerateRoute: onGenerateRoute,
          theme: ThemeData(
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreenAdmin()),
    );
  }
}
