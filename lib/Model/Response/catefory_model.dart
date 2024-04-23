
class CategoryModel {
    List<Category> response;

    CategoryModel({
        required this.response,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        response: List<Category>.from(json["response"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
    };
}

class Category {
    int? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;

    Category({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
