// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    String context;
    WelcomeType type;
    String id;
    Category category;
    String datePublished;
    String description;
    String image;
    String name;
    String prepTime;
    List<String> recipeIngredient;
    List<RecipeInstruction> recipeInstructions;
    String recipeYield;
    String totalTime;

    Welcome({
        required this.context,
        required this.type,
        required this.id,
        required this.category,
        required this.datePublished,
        required this.description,
        required this.image,
        required this.name,
        required this.prepTime,
        required this.recipeIngredient,
        required this.recipeInstructions,
        required this.recipeYield,
        required this.totalTime,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        context: json["@context"],
        type: welcomeTypeValues.map[json["@type"]]!,
        id: json["_id"],
        category: categoryValues.map[json["category"]]!,
        datePublished: json["datePublished"],
        description: json["description"],
        image: json["image"],
        name: json["name"],
        prepTime: json["prepTime"],
        recipeIngredient: List<String>.from(json["recipeIngredient"].map((x) => x)),
        recipeInstructions: List<RecipeInstruction>.from(json["recipeInstructions"].map((x) => RecipeInstruction.fromJson(x))),
        recipeYield: json["recipeYield"],
        totalTime: json["totalTime"],
    );

    Map<String, dynamic> toJson() => {
        "@context": context,
        "@type": welcomeTypeValues.reverse[type],
        "_id": id,
        "category": categoryValues.reverse[category],
        "datePublished": datePublished,
        "description": description,
        "image": image,
        "name": name,
        "prepTime": prepTime,
        "recipeIngredient": List<dynamic>.from(recipeIngredient.map((x) => x)),
        "recipeInstructions": List<dynamic>.from(recipeInstructions.map((x) => x.toJson())),
        "recipeYield": recipeYield,
        "totalTime": totalTime,
    };
}

enum Category {
    ADD_INS,
    CAF_INSPIRED_RECIPES,
    FOOD,
    HOT_BEVERAGES,
    ICED_BEVERAGES,
    SYRUPS
}

final categoryValues = EnumValues({
    "ADD-INS": Category.ADD_INS,
    "CAFÉ-INSPIRED RECIPES": Category.CAF_INSPIRED_RECIPES,
    "FOOD": Category.FOOD,
    "HOT BEVERAGES": Category.HOT_BEVERAGES,
    "ICED BEVERAGES": Category.ICED_BEVERAGES,
    "SYRUPS": Category.SYRUPS
});

class RecipeInstruction {
    RecipeInstructionType type;
    String image;
    String name;
    String text;

    RecipeInstruction({
        required this.type,
        required this.image,
        required this.name,
        required this.text,
    });

    factory RecipeInstruction.fromJson(Map<String, dynamic> json) => RecipeInstruction(
        type: recipeInstructionTypeValues.map[json["@type"]]!,
        image: json["image"],
        name: json["name"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "@type": recipeInstructionTypeValues.reverse[type],
        "image": image,
        "name": name,
        "text": text,
    };
}

enum RecipeInstructionType {
    HOW_TO_STEP
}

final recipeInstructionTypeValues = EnumValues({
    "HowToStep": RecipeInstructionType.HOW_TO_STEP
});

enum WelcomeType {
    RECIPE
}

final welcomeTypeValues = EnumValues({
    "Recipe": WelcomeType.RECIPE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
