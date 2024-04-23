

class FundraiserRequest {
    String? title;
    String? description;
    String? image;
    int? amountRaising;
    int? categoryId;
    DateTime? expiryDate;

    FundraiserRequest({
        this.title,
        this.description,
        this.image,
        this.amountRaising,
        this.categoryId,
        this.expiryDate,
    });

    factory FundraiserRequest.fromJson(Map<String, dynamic> json) => FundraiserRequest(
        title: json["title"],
        description: json["description"],
        image: json["image"],
        amountRaising: json["amountRaising"],
        categoryId: json["categoryId"],
        expiryDate: DateTime.parse(json["expiryDate"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "image": image,
        "amountRaising": amountRaising,
        "categoryId": categoryId,
        "expiryDate": expiryDate?.toIso8601String(),
    };
}
