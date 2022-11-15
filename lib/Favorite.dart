import 'package:app/home1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final user = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('users');
  String? title;
  String? image;
  String? time;
  String? info;
  String? cuisine;
  String? servings;
  late bool isVeg;
  Future<List<Object?>> getData() async {
    DocumentSnapshot data = await userCollection.doc(user.uid).get();
    title = data.get("title");
    image = data.get("image");
    time = data.get("time");
    isVeg = data.get("isVeg");
    cuisine = data.get("cuisine");
    servings = data.get("servings");
    info = data.get("info");

    return [title,image,time,isVeg,cuisine,servings,info];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        return RecipesData(
            title: title!,
            image: image!,
            cuisine: cuisine!,
            time: time!.toString(),
            info: info!,
            isVeg: isVeg,
            servings: servings!.toString()
        );
      },
    );
  }
}
