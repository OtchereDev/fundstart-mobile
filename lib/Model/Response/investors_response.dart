class InvestorsResponse {
  String? message;
  List<Investor>? investors;

  InvestorsResponse({
    this.message,
    this.investors,
  });

  factory InvestorsResponse.fromJson(Map<String, dynamic> json) =>
      InvestorsResponse(
        message: json["message"],
        investors: List<Investor>.from(
            json["investors"].map((x) => Investor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "investors": List<dynamic>.from(investors!.map((x) => x.toJson())),
      };
}

class Investor {
  String? id;
  String? email;
  String? pangeaUserId;
  String? firstName;
  String? lastName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Investor(
      {this.id,
      this.email,
      this.pangeaUserId,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName});

  factory Investor.fromJson(Map<String, dynamic> json) => Investor(
        id: json["id"],
        email: json["email"],
        pangeaUserId: json["pangeaUserId"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "pangeaUserId": pangeaUserId,
        "firstName": firstName,
        "lastName": lastName,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
