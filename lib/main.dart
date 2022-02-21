import 'package:flutter/material.dart';
import 'package:push_notifications/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.tealAccent
        ),
      ),
      title: 'Green Thumbs',
      home: const HomePage(),
    );
  }
}