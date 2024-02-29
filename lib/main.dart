import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ticket_resale/firebase_options.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/screens/screens.dart';
import 'package:ticket_resale/utils/app_routes.dart';
import 'package:ticket_resale/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  SwitchProvider provider = SwitchProvider();
  await provider.loadPreferences();
runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const TicketResale(), // Wrap your app
  ),
);


}

class TicketResale extends StatelessWidget {
  const TicketResale({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<NavigationProvider>(
              create: (context) => NavigationProvider()),
          ChangeNotifierProvider<FeedbackProvider>(
              create: (context) => FeedbackProvider()),
          ChangeNotifierProvider<ImagePickerProvider>(
              create: (context) => ImagePickerProvider()),
          ChangeNotifierProvider<SwitchProvider>(
              create: (context) => SwitchProvider()),
          ChangeNotifierProvider<BottomSheetProvider>(
              create: (context) => BottomSheetProvider())
        ],
        child: MaterialApp(
          onGenerateRoute: onGenerateRoute,
          theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            fontFamily: GoogleFonts.openSans().fontFamily,
          ),
          debugShowCheckedModeBanner: false,
          home: FirebaseAuth.instance.currentUser != null
              ? const CustomNavigation()
              : const SplashScreen(),
        ));
  }
}
