import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/Cuisine_model.dart';

class CuisineService {
  var results = <Results>[];

  Future<List<Results>> getCuisinesData({required String cuisine}) async {
    String apiKey = "790a770402d74aa7904fec399c6f59b4";
    String baseUrl = "https://api.spoonacular.com/recipes/complexSearch";
    String url = "$baseUrl?cuisine=$cuisine&apiKey=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        var cuisinesMain = CuisinesModel.fromJson(responseBody);
        results = cuisinesMain.results;
        print(results);
      }
    } catch (e) {
      print(e);
    }
    return results;
  }
}
