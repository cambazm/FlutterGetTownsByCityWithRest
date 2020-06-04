import 'package:flutter/material.dart';
import 'package:citiesrest/ui/cities_screen.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CitiesScreen(),
    );
  }
}
