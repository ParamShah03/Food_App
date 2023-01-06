<<<<<<< HEAD
import 'package:app/Models/Nutrients_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/Cuisine_model.dart';

class NutrientsService{
  var results= <NutrientsModel>[];
  Future<List<NutrientsModel>> getNutrientsData(int? minCarbs,maxCarbs) async{
    String apiKey = "790a770402d74aa7904fec399c6f59b4";
    String baseUrl = "https://api.spoonacular.com/recipes/findByNutrients";
    String url = "$baseUrl?minCarbs=$minCarbs&maxCarbs=$maxCarbs&number=2&apiKey=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    try{
      if (response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        results = NutrientsModel.fromJson(responseBody) as List<NutrientsModel>;
      } else {
        print(response.statusCode);
      }
    } catch(e){
      print(e);
    }

    return results;
  }
}
=======
import 'package:app/Models/Nutrients_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/Cuisine_model.dart';

class NutrientsService{
  var results= <NutrientsModel>[];
  Future<List<NutrientsModel>> getNutrientsData(int? minCarbs,maxCarbs) async{
    String apiKey = "790a770402d74aa7904fec399c6f59b4";
    String baseUrl = "https://api.spoonacular.com/recipes/findByNutrients";
    String url = "$baseUrl?minCarbs=$minCarbs&maxCarbs=$maxCarbs&number=2&apiKey=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    try{
      if (response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        results = NutrientsModel.fromJson(responseBody) as List<NutrientsModel>;
      } else {
        print(response.statusCode);
      }
    } catch(e){
      print(e);
    }

    return results;
  }
}
>>>>>>> origin/main
