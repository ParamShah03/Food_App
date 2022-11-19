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
        'https://api.spoonacular.com/recipes/random?apiKey=6cc1b0e3bed04f34bcc64f54a1cf4856&number=2'
    ));
    try{
      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // title = data["recipes"][0]["title"].toString();
        // time = data["recipes"][0]["readyInMinutes"].toString();
        // image = data["recipes"][0]["image"];
        // isVeg = data['recipes'][0]['vegetarian'];
        // servings = data["recipes"][0]["servings"].toString();
        // cuisine = data['recipes'][0]['cuisines'][0];
        // info = data['recipes'][[0]]['instructions'];
        // debugPrint(title);
        // debugPrint(time);
        //debugPrint(image);
        // debugPrint(servings);
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

