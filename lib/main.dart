import 'package:flutter/material.dart';
import 'package:ticket_resale/screens/home_first_screen.dart';


void main() {
  runApp(const TicketResale());
}

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
      home: const HomeFirstScreen(),
    );
  }
}
