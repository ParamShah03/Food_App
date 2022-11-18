import 'dart:core';

class FavoriteModel{
  late String title;
  late String servings;
  late String image;
  late String time;
  late String info;
  late bool isVeg;

  FavoriteModel({
    required this.title,
    required this.servings,
    required this.image,
    required this.time,
    required this.info,
    required this.isVeg
  });

}