import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'Recipe_Info.dart';
import 'models.dart';
import 'package:app/apiService.dart';

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {

  List<Recipes> _recipesList = [];
  String? query;
  getRecipeData() async {
    _recipesList = await ApiService().getApiData(query)!;
    print(_recipesList.length);
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
          } else {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: _recipesList!.length.compareTo(0),
              itemBuilder: (BuildContext context, int index) {
                Recipes recipe = _recipesList[index];
                return RecipesData(
                    title: recipe.title!,
                    image: recipe.image!,
                    isVeg: recipe.vegetarian,
                    time: recipe.readyInMinutes.toString(),
                    info: recipe.instructions!,
                    servings: recipe.servings.toString(),
                    //cuisine: recipe.cuisines[0]
                );
              },
              separatorBuilder: (context,index){
                return SizedBox(height: 5,);
              },
            );
          }
          // else {
          //   return Center(child: Text('Some Error Occured'),);
          // }

        }
      )
    );
  }
}

class RecipesData extends StatefulWidget {
  final String title;
  final String image;
  final String time;
  final String info;
 // final String cuisine;
  final String servings;
  final bool isVeg;


  const RecipesData({Key? key,
    required this.title,
    required this.image,
    //required this.cuisine,
    required this.time,
    required this.info,
    required this.isVeg,
    required this.servings})
      : super(key: key, );

  @override
  _RecipesDataState createState() => _RecipesDataState();
}

class _RecipesDataState extends State<RecipesData> {
  bool like = false;
  var user = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context, PageTransition(
              type: PageTransitionType.size,
              alignment: Alignment.bottomCenter,
              child: Details(
            title: widget.title,
            time: widget.time,
            image: widget.image,
            isVeg: widget.isVeg,
            info: widget.info,
            servings: widget.servings,
            //cuisine: widget.cuisine
          )),);
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          width: MediaQuery.of(context).size.width,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: Offset(
                  0.0,
                  10.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -6.0,
              ),
            ],
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.35),
                BlendMode.multiply,
              ),
              image: NetworkImage(widget.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    widget.title ,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: IconButton(
                      onPressed: () async {
                        setState(() {
                          like = !like;
                        });

                        if(like==true){
                          await firestoreInstance.collection('users').doc(user?.uid).set({
                                "title": widget.title,
                                "image": widget.image,
                                "time": widget.time,
                                "servings": widget.servings,
                                "info": widget.info,
                                //"cuisine": widget.cuisine
                              });
                          await firestoreInstance.collection('users').doc(user?.uid).update({
                            "isVeg": widget.isVeg
                          });
                        } else{
                          await firestoreInstance.collection('users').doc(user?.uid).update({
                            "title": FieldValue.delete(),
                            "image": FieldValue.delete(),
                            "time": FieldValue.delete(),
                            "servings": FieldValue.delete(),
                            "info": FieldValue.delete(),
                            "cuisine":FieldValue.delete(),
                            "isVeg": FieldValue.delete()
                          });
                        }

                      },
                      icon: Icon(
                        (like==false? Icons.star_border:Icons.star),
                      color: Colors.white,
                        size: 30.0,
                      )
                  )
                ),

              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    (widget.isVeg == true? "Veg":"Non-Veg"),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          SizedBox(width: 7),
                          Text(widget.time + '\'',
                            style: TextStyle(
                                color: Colors.white,fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
