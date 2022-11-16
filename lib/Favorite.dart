import 'package:app/home1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'Recipe_Info.dart';

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
  bool like = true;
  // var user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
      } else if(snapshot.hasData){
          return Container(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context, PageTransition(
                      type: PageTransitionType.size,
                      alignment: Alignment.bottomCenter,
                      child: Details(
                      title: title!,
                      time: time!,
                      image: image!,
                      isVeg: isVeg,
                      info: info!,
                      servings: servings!,
                      //cuisine: cuisine!
                  )),);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(
                          0.0,
                          10.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: -6.0,
                      ),
                    ],
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.35),
                        BlendMode.multiply,
                      ),
                      image: NetworkImage(image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            title! ,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: IconButton(
                                onPressed: () async {
                                  setState(() {
                                    like = false;
                                  });

                                    await firestoreInstance.collection('users').doc(user?.uid).update({
                                      "title": FieldValue.delete(),
                                      "image": FieldValue.delete(),
                                      "time": FieldValue.delete(),
                                      "servings": FieldValue.delete(),
                                      "info": FieldValue.delete(),
                                      "cuisine":FieldValue.delete(),
                                      "isVeg": FieldValue.delete()
                                    });


                                },
                                icon: Icon(
                                  (like==false? Icons.star_border:Icons.star),
                                  color: Colors.white,
                                  size: 30.0,
                                )
                            )
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            (isVeg == true? "Veg":"Non-Veg"),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.schedule,
                                    color: Colors.yellow,
                                    size: 18,
                                  ),
                                  SizedBox(width: 7),
                                  Text(time! + '\'',
                                    style: TextStyle(
                                        color: Colors.white,fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
          );
        } else {
          return Center(child: Text('Empty'),);
        }

      },
    );
  }
}


// RecipesData(
// title: title!,
// image: image!,
// cuisine: cuisine!,
// time: time!.toString(),
// info: info!,
// isVeg: isVeg,
// servings: servings!.toString()
// );
