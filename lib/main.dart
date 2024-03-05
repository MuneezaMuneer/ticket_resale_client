import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_resale/constants/app_texts.dart';
import 'package:ticket_resale/firebase_options.dart';
import 'package:ticket_resale/providers/event_image_provider.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/screens/splash_screen.dart';
import 'package:ticket_resale/utils/app_routes.dart';
import 'providers/drop_down_provider.dart';
import 'providers/search_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppText.preference = await SharedPreferences.getInstance();
  SwitchProvider provider = SwitchProvider();
  await provider.loadPreferences();
  runApp(
    const TicketResale(),
  );
}

class TicketResale extends StatelessWidget {
  const TicketResale({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventImagePickerProvider>(
          create: (context) => EventImagePickerProvider(),
        ),
        ChangeNotifierProvider<NavigationProvider>(
          create: (context) => NavigationProvider(),
        ),
        ChangeNotifierProvider<FeedbackProvider>(
          create: (context) => FeedbackProvider(),
        ),
        ChangeNotifierProvider<ImagePickerProvider>(
          create: (context) => ImagePickerProvider(),
        ),
        ChangeNotifierProvider<SwitchProvider>(
          create: (context) => SwitchProvider(),
        ),
        ChangeNotifierProvider<BottomSheetProvider>(
          create: (context) => BottomSheetProvider(),
        ),
        ChangeNotifierProvider<DropDownProvider>(
          create: (context) => DropDownProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
      ],
      child: MaterialApp(
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
