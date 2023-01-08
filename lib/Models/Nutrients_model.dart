class NutrientsModel {
  String? status;
  Nutrition? nutrition;
  Category? category;
  List<Recipes>? recipes;

  NutrientsModel({this.status, this.nutrition, this.category, this.recipes});

  NutrientsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    nutrition = json['nutrition'] != null
        ? new Nutrition.fromJson(json['nutrition'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['recipes'] != null) {
      recipes = <Recipes>[];
      json['recipes'].forEach((v) {
        recipes!.add(new Recipes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.nutrition != null) {
      data['nutrition'] = this.nutrition!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.recipes != null) {
      data['recipes'] = this.recipes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nutrition {
  int? recipesUsed;
  Calories? calories;
  Calories? fat;
  Calories? protein;
  Calories? carbs;

  Nutrition(
      {this.recipesUsed, this.calories, this.fat, this.protein, this.carbs});

  Nutrition.fromJson(Map<String, dynamic> json) {
    recipesUsed = json['recipesUsed'];
    calories = json['calories'] != null
        ? new Calories.fromJson(json['calories'])
        : null;
    fat = json['fat'] != null ? new Calories.fromJson(json['fat']) : null;
    protein =
    json['protein'] != null ? new Calories.fromJson(json['protein']) : null;
    carbs = json['carbs'] != null ? new Calories.fromJson(json['carbs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipesUsed'] = this.recipesUsed;
    if (this.calories != null) {
      data['calories'] = this.calories!.toJson();
    }
    if (this.fat != null) {
      data['fat'] = this.fat!.toJson();
    }
    if (this.protein != null) {
      data['protein'] = this.protein!.toJson();
    }
    if (this.carbs != null) {
      data['carbs'] = this.carbs!.toJson();
    }
    return data;
  }
}

class Calories {
  int? value;
  String? unit;
  ConfidenceRange95Percent? confidenceRange95Percent;
  double? standardDeviation;

  Calories(
      {this.value,
        this.unit,
        this.confidenceRange95Percent,
        this.standardDeviation});

  Calories.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    unit = json['unit'];
    confidenceRange95Percent = json['confidenceRange95Percent'] != null
        ? new ConfidenceRange95Percent.fromJson(
        json['confidenceRange95Percent'])
        : null;
    standardDeviation = json['standardDeviation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    if (this.confidenceRange95Percent != null) {
      data['confidenceRange95Percent'] =
          this.confidenceRange95Percent!.toJson();
    }
    data['standardDeviation'] = this.standardDeviation;
    return data;
  }
}

class ConfidenceRange95Percent {
  double? min;
  double? max;

  ConfidenceRange95Percent({this.min, this.max});

  ConfidenceRange95Percent.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}

class Category {
  String? name;
  double? probability;

  Category({this.name, this.probability});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    probability = json['probability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['probability'] = this.probability;
    return data;
  }
}

class Recipes {
  int? id;
  String? title;
  String? imageType;
  String? url;

  Recipes({this.id, this.title, this.imageType, this.url});

  Recipes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageType = json['imageType'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['imageType'] = this.imageType;
    data['url'] = this.url;
    return data;
  }
}