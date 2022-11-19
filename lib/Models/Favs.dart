import 'package:cloud_firestore/cloud_firestore.dart';

class Favs{
  String id;
  String? title;
  String? time;
  String? servings;
  String? image;
  String? info;
  bool isVeg;

  Favs({
    required this.id ,
    required this.title,
    required this.time,
    required this.servings,
    required this.image,
    required this.info,
    required this.isVeg
  });



  Map<String,dynamic> toJson()=>{
    'id':id,
    'title':title,
    'servings':servings,
    'time':time,
    'image': image,
    'info': info,
    'isVeg': isVeg

  };

  static Favs fromJson(Map<String,dynamic>json)=>Favs(
    title:json["title"],
    time:json["time"],
    servings:json["servings"],
    image: json['image'],
    id: json['id'],
    info: json['info'],
    isVeg: json['isVeg']

  );

}