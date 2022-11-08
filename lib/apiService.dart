import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';

class ApiService{
  String? title;
  String? time;
  String? image;
  String? servings;
  bool? isVeg;
  String? e;
  RecipesMain? recipesMain;
  List<Recipes> _recipesList=[];

  getApiData() async {

    http.Response response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/random?apiKey=790a770402d74aa7904fec399c6f59b4&number=2'
    ));
    try{
      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        title = data["recipes"][0]["title"].toString();
        time = data["recipes"][0]["readyInMinutes"].toString();
        image = data["recipes"][0]["image"];
        servings = data["recipes"][0]["servings"].toString();
        isVeg = data['recipes'][0]['vegetarian'];
        // debugPrint(title);
        // debugPrint(time);
        //debugPrint(image);
        // debugPrint(servings);
        print(response.statusCode);
        // setState(() {
        //
        // });
        var recipesMain = RecipesMain.fromJson(data);
        _recipesList = recipesMain.recipes;

      } else {
        print(response.statusCode);

      }
      return _recipesList;
    } catch(e){
      print(e);
    }

  }

}

