

import 'package:crowdfunding/Model/Response/fundraiser_model.dart';

class PortfolioResponse {
    String? message;
    List<Portfolio>? portfolio;

    PortfolioResponse({
         this.message,
         this.portfolio,
    });

    factory PortfolioResponse.fromJson(Map<String, dynamic> json) => PortfolioResponse(
        message: json["message"],
        portfolio: List<Portfolio>.from(json["portfolio"].map((x) => Portfolio.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "portfolio": List<dynamic>.from(portfolio!.map((x) => x.toJson())),
    };
}

class Portfolio {
    String? id;
    String? amount;
    String? fundraiserId;
    String? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;
    Fundraiser? fundraiser;

    Portfolio({
         this.id,
         this.amount,
         this.fundraiserId,
         this.userId,
         this.createdAt,
         this.updatedAt,
         this.user,
         this.fundraiser,
    });

    factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        id: json["id"],
        amount: json["amount"],
        fundraiserId: json["fundraiserId"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: User.fromJson(json["User"]),
        fundraiser: Fundraiser.fromJson(json["Fundraiser"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "fundraiserId": fundraiserId,
        "userId": userId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "User": user?.toJson(),
        "Fundraiser": fundraiser?.toJson(),
    };
}

class User {
    String? id;
    String? email;
    String? pangeaUserId;
    DateTime? createdAt;
    DateTime? updatedAt;

    User({
         this.id,
         this.email,
         this.pangeaUserId,
         this.createdAt,
         this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        pangeaUserId: json["pangeaUserId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "pangeaUserId": pangeaUserId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
