<<<<<<< HEAD
class NutrientsModel {
  int? calories;
  String? carbs;
  String? fat;
  int? id;
  String? image;
  String? imageType;
  String? protein;
  String? title;

  NutrientsModel(
      {this.calories,
        this.carbs,
        this.fat,
        this.id,
        this.image,
        this.imageType,
        this.protein,
        this.title});

  NutrientsModel.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    carbs = json['carbs'];
    fat = json['fat'];
    id = json['id'];
    image = json['image'];
    imageType = json['imageType'];
    protein = json['protein'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calories'] = this.calories;
    data['carbs'] = this.carbs;
    data['fat'] = this.fat;
    data['id'] = this.id;
    data['image'] = this.image;
    data['imageType'] = this.imageType;
    data['protein'] = this.protein;
    data['title'] = this.title;
    return data;
  }
=======
class NutrientsModel {
  int? calories;
  String? carbs;
  String? fat;
  int? id;
  String? image;
  String? imageType;
  String? protein;
  String? title;

  NutrientsModel(
      {this.calories,
        this.carbs,
        this.fat,
        this.id,
        this.image,
        this.imageType,
        this.protein,
        this.title});

  NutrientsModel.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    carbs = json['carbs'];
    fat = json['fat'];
    id = json['id'];
    image = json['image'];
    imageType = json['imageType'];
    protein = json['protein'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calories'] = this.calories;
    data['carbs'] = this.carbs;
    data['fat'] = this.fat;
    data['id'] = this.id;
    data['image'] = this.image;
    data['imageType'] = this.imageType;
    data['protein'] = this.protein;
    data['title'] = this.title;
    return data;
  }
>>>>>>> origin/main
}