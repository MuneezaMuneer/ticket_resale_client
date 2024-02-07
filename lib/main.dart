
import 'package:flutter/material.dart';
import 'package:ticket_resale/screens/feed_back_screen.dart';
import 'package:ticket_resale/screens/screens.dart';

void main() => runApp(
      const TicketResale(),
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
        home: const FeedBackScreen());
  }
}
