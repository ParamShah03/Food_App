import 'package:flutter/material.dart';

class Cuisine extends StatefulWidget {
  const Cuisine({Key? key}) : super(key: key);

  @override
  State<Cuisine> createState() => _CuisineState();
}

class _CuisineState extends State<Cuisine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Cuisine')),
    );
  }
}
