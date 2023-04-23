import 'package:flutter/material.dart';
import 'providers/id.dart';
import 'package:provider/provider.dart';
import 'screens/nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => Id(),
      child: MaterialApp(
        title: 'no_sql',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const NavBar(),
      ),
    );
  }
}
