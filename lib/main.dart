import 'package:flutter/material.dart';
import 'package:movies_flutter_app/src/pages/details_page.dart';
import 'package:movies_flutter_app/src/pages/home_page.dart';

void main() => runApp(
    MoviesApp());

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      initialRoute: 'home',
      routes: {
        'home'   : (BuildContext context) => HomePage(),
        'details':(BuildContext context) => DetailsPage(),
      },

    );
  }
}
