import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/models.dart';

class ApiService{
  String? title;
  String? time;
  String? image;
  // String? cuisine;
  String? servings;
  String? info;
  bool? isVeg;
  String? e;
  RecipesMain? recipesMain;
  List<Recipes> _recipesList =[];

  getApiData(String? query) async {

    http.Response response = await http.get(Uri.parse(
        'https://api.spoonacular.com/recipes/random?apiKey=790a770402d74aa7904fec399c6f59b4&number=20'
    ));
    try{
      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(response.statusCode);

        var recipesMain = RecipesMain.fromJson(data);
        _recipesList = recipesMain.recipes;
        if(query!=null){
          _recipesList = _recipesList!.where((element) => element.title!.toLowerCase().contains(query.toLowerCase())).toList();
        }
      } else {
        print(response.statusCode);

      }
      return _recipesList;
    } catch(e){
      print(e);
    }

  }

}

