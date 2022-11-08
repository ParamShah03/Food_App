import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models.dart';
import 'package:app/apiService.dart';
import 'dart:developer';

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {

  List<Recipes> _recipesList= [];

  getRecipeData() async {
    _recipesList = await ApiService().getApiData()!;

   }


  @override
  void initState() {
    getRecipeData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getRecipeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            itemCount: _recipesList!.length,
            itemBuilder: (BuildContext context, int index) {
              Recipes recipe = _recipesList![index];
              return RecipesData(
                    title: recipe.title!,
                    image: recipe.image!,
                    isVeg: recipe.vegetarian,
                    time: recipe.readyInMinutes!.toString(),
                  );
            },
            separatorBuilder: (context,index){
              return SizedBox(height: 10,);
            },
          );
        }
      )
    );
  }
}

class RecipesData extends StatefulWidget {
  final String title;
  final String image;
  final String time;
  final bool isVeg;


  const RecipesData({Key? key,
    required this.title,
    required this.image,
    required this.time,
    required this.isVeg})
      : super(key: key, );

  @override
  _RecipesDataState createState() => _RecipesDataState();
}

class _RecipesDataState extends State<RecipesData> {


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.image),
        radius: 40,
      ),
      title: Text(widget.title),
      subtitle: Text((widget.isVeg== true? "Veg":"Non-Veg")),
      trailing: Text(widget.time+"mins"),
    );
  }
}


// Row(
// children: [
// CircleAvatar(
// backgroundImage: NetworkImage(widget.image),
// radius: 40,
// ),
// Expanded(
// child: Column(
// children: [
// Text(widget.title),
// Text((widget.isVeg== true? "Veg":"Non-Veg")),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Text("Time: "+widget.time),
// Text("Servings"+widget.time),
//
// ]
// )
// ],
// ),
// )
//
// ],
// );