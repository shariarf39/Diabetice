// @dart=2.9
import 'package:flutter/material.dart';

import 'activitys/pages/plash_screen.dart';

void main() {
  runApp( MyApp());
}
// @dart=2.9

class MyApp extends StatelessWidget {
 // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PlashScreen(),
    );
  }
}
