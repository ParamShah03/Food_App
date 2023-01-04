import 'package:app/Screens/Cuisine1.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Cuisine extends StatefulWidget {
  const Cuisine({Key? key}) : super(key: key);

  @override
  State<Cuisine> createState() => _CuisineState();
}

class _CuisineState extends State<Cuisine> {
  List<String> cuisinesList = [
    "Indian",
    "Thai",
    "Chinese",
    "Japanese",
    "Mexican",
    "Italian",
    "French"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: CuisineDisplay(name: cuisinesList[0])),
                );
              },
              leading: Icon(
                Icons.restaurant_menu_outlined,
                size: 25,
              ),
              title: Text(
                cuisinesList[0],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                    letterSpacing: 2),
              ),
              tileColor: Colors.brown[100],
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: CuisineDisplay(name: cuisinesList[1])),
                );
              },
              leading: Icon(
                Icons.restaurant_menu_outlined,
                size: 25,
              ),
              title: Text(
                cuisinesList[1],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                    letterSpacing: 2),
              ),
              tileColor: Colors.brown[100],
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: CuisineDisplay(name: cuisinesList[2])),
                );
              },
              leading: Icon(
                Icons.restaurant_menu_outlined,
                size: 25,
              ),
              title: Text(
                cuisinesList[2],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                    letterSpacing: 2),
              ),
              tileColor: Colors.brown[100],
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: CuisineDisplay(name: cuisinesList[3])),
                );
              },
              leading: Icon(
                Icons.restaurant_menu_outlined,
                size: 25,
              ),
              title: Text(
                cuisinesList[3],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                    letterSpacing: 2),
              ),
              tileColor: Colors.brown[100],
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: CuisineDisplay(name: cuisinesList[4])),
                );
              },
              leading: Icon(
                Icons.restaurant_menu_outlined,
                size: 25,
              ),
              title: Text(
                cuisinesList[4],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                    letterSpacing: 2),
              ),
              tileColor: Colors.brown[100],
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: CuisineDisplay(name: cuisinesList[5])),
                );
              },
              leading: Icon(
                Icons.restaurant_menu_outlined,
                size: 25,
              ),
              title: Text(
                cuisinesList[5],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                    letterSpacing: 2),
              ),
              tileColor: Colors.brown[100],
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: CuisineDisplay(name: cuisinesList[6])),
                );
              },
              leading: Icon(
                Icons.restaurant_menu_outlined,
                size: 25,
              ),
              title: Text(
                cuisinesList[6],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25,
                    letterSpacing: 2),
              ),
              tileColor: Colors.brown[100],
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
