import 'package:app/Screens/home.dart';
import 'package:app/Search/Search.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/models.dart';

class ApiService {
  // fields of class ApiService
  String? title;
  String? time;
  String? image;
  // String? cuisine;
  String? servings;
  String? info;
  bool? isVeg;
  String? e;
  RecipesMain? recipesMain; // instance of class RecipesMain from model
  List<Recipes> _recipesList =[]; //list of recipe class from model

  getApiData(String? query) async {
    // the entire response body is known in advance
    http.Response response = await http.get(Uri.parse(// converted to URL
        'https://api.spoonacular.com/recipes/random?apiKey=790a770402d74aa7904fec399c6f59b4&number=1'
    ));
    try{// unhandled exception
      if(response.statusCode == 200) // properly working
      {
        var data = jsonDecode(response.body);// a map where keys are string and values dynamic
        //print(response.statusCode);

        var recipesMain = RecipesMain.fromJson(data);// passing parsed json
        _recipesList = recipesMain.recipes;// recipes is a list
        print(_recipesList.toString());



        if(query!=null){
          // converting title to list
          _recipesList = _recipesList!.where((element) => element.title!.toLowerCase().contains(query.toLowerCase())).toList();
        }

      } else {
        print(response.statusCode);

      } // function has to return list of recipes
      return _recipesList;
    } catch(e){
      print(e);
    }

  }
}




