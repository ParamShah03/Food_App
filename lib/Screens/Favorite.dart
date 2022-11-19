import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Models/Favs.dart';
import 'Recipe_Info.dart';


class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;

  Stream<List<Favs>> readFavourites() =>
      FirebaseFirestore.instance.collection('users').doc(user?.uid).collection(
          'Favorite')
          .snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Favs.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Favs>>(
          stream: readFavourites(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error occured!"),
              );
            } else if (snapshot.hasData) {
              final favs = snapshot.data!;
              return ListView(
                children: favs.map(buildFavs).toList(),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text("Empty"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }


  Widget buildFavs(Favs favs) {
    return FavoriteData(
      title: favs.title!,
      image: favs.image!,
      time: favs.time!.toString(),
      servings: favs.servings!.toString(),
      docId: favs.id,
      c: 1,
      info: favs.info!,
      isVeg: favs.isVeg,
    );
  }
}

class FavoriteData extends StatefulWidget {
  String? title;
  String? servings;
  String? image;
  String? time;
  String? docId;
  String? info;
  bool isVeg;
  int c;
  FavoriteData({Key? key,
    required this.title,
    required this.image,
    required this.servings,
    required this.time,
    required this.docId,
    required this.info,
    required this.isVeg,
    required this.c,
  })
      : super(key: key);

  @override
  State<FavoriteData> createState() => _FavoriteDataState();
}

class _FavoriteDataState extends State<FavoriteData> {
  var user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  Future deleteFavorite() async {
    final docFav =
    firestoreInstance.collection("users").doc(user?.uid).collection("Favorite").doc(widget.docId);
    await docFav.delete();
    widget.c = widget.c - 1;
  }

  @override
  Widget build(BuildContext context) {
    bool like = true;
    return Container(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context, PageTransition(
                type: PageTransitionType.size,
                alignment: Alignment.bottomCenter,
                child: Details(
                  title: widget.title!,
                  time: widget.time!,
                  image: widget.image!,
                  isVeg: widget.isVeg,
                  info: widget.info!,
                  servings: widget.servings!,
                  //cuisine: widget.cuisine
                )),);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            width: MediaQuery
                .of(context)
                .size
                .width,
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
                image: NetworkImage(widget.image!),
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
                      widget.title!,
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
                              like = !like;
                            });
                            if (like == false ) {
                               await deleteFavorite();
                            }
                          },
                          icon: Icon(
                            (like == false ? Icons.star_border : Icons.star),
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
                      (widget.isVeg == true ? "Veg" : "Non-Veg"),
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
                            Text(widget.time! + '\'',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
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
  }

}
