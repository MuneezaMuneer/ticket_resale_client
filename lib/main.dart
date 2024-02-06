import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ticket_resale/screens/screens.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const TicketResale(), // Wrap your app
      ),
    );

class TicketResale extends StatelessWidget {
  const TicketResale({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ticket Resale',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PaymentConnectScreen());
  }
}
