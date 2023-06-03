import 'package:flutter/material.dart';

void main() {
  runApp(const RoomsChat());
}

class RoomsChat extends StatelessWidget {
  const RoomsChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rooms Chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

