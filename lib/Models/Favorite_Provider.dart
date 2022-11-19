import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Favorite_model.dart';

class FavoriteProvider with ChangeNotifier {
  static void addFavoriteData({
    required String title,
    required String servings,
    required String image,
    required String time,
    required String info,
    required bool isVeg

  }) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseFirestore.instance
        .collection('favourites')
        .doc(id)
        .set(
      {
        'title': title,
        'servings': servings,
        'image': image,
        'time': time,
        'isVeg': true,
        'id':id,
        'info': info
      },
    );
  }
  List<FavoriteModel> Favoritelist = [];
  getFavoriteData() async {
    List<FavoriteModel> newlist = [];
    QuerySnapshot value = (await FirebaseFirestore.instance
        .collection('favourites')
        .doc()
        .get()) as QuerySnapshot<Object?>;
    value.docs.forEach((element) {
      FavoriteModel favoriteModel = FavoriteModel(
          title: element.get('title'),
          servings: element.get('servings').toString(),
          image: element.get('image'),
          time: element.get('time').toString(),
          info: element.get('info'),
          isVeg: element.get('isVeg')
      );


      newlist.add(favoriteModel);
    });
    Favoritelist = newlist;
    notifyListeners();
  }
  List<FavoriteModel> get getWishlist{
    return Favoritelist;
  }
}