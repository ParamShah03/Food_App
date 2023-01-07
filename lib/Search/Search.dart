import 'package:flutter/material.dart';
import '../Models/models.dart';
import '../Screens/home1.dart';
import '../Service/apiService.dart';


class CustomSearchDelegate extends SearchDelegate{

  List<Recipes>? _recipesList1;


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (){
            query = '';
          },
          icon: Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_outlined)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: getRecipeData(query: query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            itemCount: _recipesList1!.length,
            itemBuilder: (BuildContext context, int index) {
              Recipes recipe = _recipesList1![index];
              return RecipesData(
                title: recipe.title!,
                c: 0,
                docId: '',
                image: recipe.image!,
                isVeg: recipe.vegetarian,
                time: recipe.readyInMinutes!.toString(),
                info: recipe.instructions!,
                //cuisine: recipe.cuisines[0],
                servings: recipe.servings.toString(),
              );
            },
            separatorBuilder: (context,index){
              return SizedBox(height: 5,);
            },
          );
        }
    );
    }

  @override
  Widget buildSuggestions(BuildContext context) {
   return FutureBuilder(
        future: getRecipeData(query: query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            itemCount: _recipesList1!.length,
            itemBuilder: (BuildContext context, int index) {
              Recipes recipe = _recipesList1![index];
              return RecipesData(
                title: recipe.title!,
                c: 0,
                docId: '',
                image: recipe.image!,
                isVeg: recipe.vegetarian,
                time: recipe.readyInMinutes!.toString(),
                info: recipe.instructions!,
                //cuisine: recipe.cuisines[0],
                servings: recipe.servings.toString(),
              );
            },
            separatorBuilder: (context,index){
              return SizedBox(height: 5,);
            },
          );
        }
    );
  }
  // SearchRecipe({String? query}) async {
  //   try {
  //     if (query != null) {
  //       _recipesList2 = recipesList!.where((element) =>
  //           element.title!.toLowerCase().contains(query.toLowerCase()))
  //           .toList();
  //       print(query);
  //       return _recipesList2;
  //     } else {
  //       return _recipesList1;
  //     }
  //   } catch (e){
  //     print(e);
  //   }
  //
  //
  // }

  getRecipeData({required String? query}) async {
    _recipesList1 = await ApiService().getApiData(query)!;
  }
}

