

class FundRaiserModel {
    String? message;
    List<Fundraiser>? fundraisers;

    FundRaiserModel({
         this.message,
         this.fundraisers,
    });

    factory FundRaiserModel.fromJson(Map<String, dynamic> json) => FundRaiserModel(
        message: json["message"],
        fundraisers: List<Fundraiser>.from(json["fundraisers"].map((x) => Fundraiser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "fundraisers": List<dynamic>.from(fundraisers!.map((x) => x.toJson())),
    };
}
class Fundraiser {
    String? id;
    String? title;
    String? description;
    String? image;
    String? amountRaising;
    DateTime? expiryDate;
    dynamic isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? categoryId;
    String? userId;
    Category? category;
    Organizer? organizer;
    List<Investment>? investments;
    List<dynamic>? comments;

    Fundraiser({
        this.id,
        this.title,
        this.description,
        this.image,
        this.amountRaising,
        this.expiryDate,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
        this.userId,
        this.category,
        this.organizer,
        this.investments,
        this.comments,
    });

    factory Fundraiser.fromJson(Map<String, dynamic> json){
      return Fundraiser(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        amountRaising: json["amountRaising"],
        expiryDate:json["expiryDate"] == null ? null: DateTime.parse(json["expiryDate"]),
        isDeleted: json["isDeleted"],
        createdAt:json["createdAt"] == null ? null: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null: DateTime.parse(json["updatedAt"]),
        categoryId: json["categoryId"],
        userId: json["userId"],
        category:json["category"] == null ? null: Category.fromJson(json["category"]),
        organizer: json["organizer"] == null ? null:Organizer.fromJson(json["organizer"]),
        investments:json["investments"] == null ? []: List<Investment>.from(json["investments"].map((x) => Investment.fromJson(x))),
        comments: json["comments"] == null ? []: List<dynamic>.from(json["comments"].map((x) => x)),
    );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "amountRaising": amountRaising,
        "expiryDate": expiryDate?.toIso8601String(),
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "categoryId": categoryId,
        "userId": userId,
        "category": category?.toJson(),
        "organizer": organizer?.toJson(),
        "investments": List<dynamic>.from(investments!.map((x) => x)),
        "comments": List<dynamic>.from(comments!.map((x) => x)),
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

class Organizer {
    String? id;
    String? email;
    String? pangeaUserId;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? firstName;
    String? lastName;
    String? phone;

    Organizer({
         this.id,
         this.email,
         this.pangeaUserId,
         this.createdAt,
         this.updatedAt,
         this.firstName,
         this.lastName,
         this.phone,
    });

    factory Organizer.fromJson(Map<String, dynamic> json) => Organizer(
        id: json["id"],
        email: json["email"],
        pangeaUserId: json["pangeaUserId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "pangeaUserId": pangeaUserId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
    };
}


class Investment {
    String? id;
    String? amount;
    String? fundraiserId;
    String? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;

    Investment({
        required this.id,
        required this.amount,
        required this.fundraiserId,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
         this.user,
    });

    factory Investment.fromJson(Map<String, dynamic> json){
      return Investment(
        id: json["id"],
        amount: json["amount"],
        fundraiserId: json["fundraiserId"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user:json["User"] == null ? null: User.fromJson(json["User"]),
    );

    }
    Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "fundraiserId": fundraiserId,
        "userId": userId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "User": user?.toJson(),
    };
}

class User {
    String? id;
    String? email;
    String? pangeaUserId;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? firstName;
    String? lastName;
    String? phone;

    User({
        this.id,
        this.email,
        this.pangeaUserId,
        this.createdAt,
        this.updatedAt,
        this.firstName,
        this.lastName,
        this.phone,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        pangeaUserId: json["pangeaUserId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "pangeaUserId": pangeaUserId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
    };
}
