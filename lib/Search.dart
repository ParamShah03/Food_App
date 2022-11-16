import 'package:flutter/material.dart';
import 'home1.dart';
import 'models.dart';
import 'apiService.dart';


class CustomSearchDelegate extends SearchDelegate{
  List<Recipes>? _recipesList;

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
            itemCount: _recipesList!.length.compareTo(0),
            itemBuilder: (BuildContext context, int index) {
              Recipes recipe = _recipesList![index];
              return RecipesData(
                title: recipe.title!,
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
    return Center(child: Text('Enter Recipe'));
  }

  getRecipeData({required String? query}) async {
    _recipesList = await ApiService().getApiData(query)!;
  }
}

