import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/firebase_options.dart';
import 'package:ticket_resale/providers/providers.dart';
import 'package:ticket_resale/screens/screens.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:ticket_resale/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.requestPermission();
  SwitchProvider provider = SwitchProvider();
  await provider.loadPreferences();
  FirebaseMessaging.instance.requestPermission();
  AppText.preference = await SharedPreferences.getInstance();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const TicketResale(),
  ));
  // const TicketResale());
}

class TicketResale extends StatelessWidget {
  const TicketResale({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ClearProvider>(
          create: (context) => ClearProvider(),
        ),
       
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
        home: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Some Thing Has Went Wrong',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        backgroundColor: AppColors.blue),
                  ),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data!.email! == 'test@gmail.com') {
                  return const CustomNavigationAdmin();
                } else {
                  return const CustomNavigationClient();
                }
              }
              return const SplashScreen();
            }),
      ),
    );
  }
}
