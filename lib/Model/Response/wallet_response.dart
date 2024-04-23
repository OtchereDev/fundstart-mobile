

class WalletResponse {
    String message;
    List<Wallet> wallets;

    WalletResponse({
        required this.message,
        required this.wallets,
    });

    factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
        message: json["message"],
        wallets: List<Wallet>.from(json["wallets"].map((x) => Wallet.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "wallets": List<dynamic>.from(wallets.map((x) => x.toJson())),
    };
}

class Wallet {
    String id;
    String cardNumber;
    String cvv;
    String cardHolder;
    String expiryDate;
    bool isDeleted;
    DateTime createdAt;
    DateTime updatedAt;
    String userId;

    Wallet({
        required this.id,
        required this.cardNumber,
        required this.cvv,
        required this.cardHolder,
        required this.expiryDate,
        required this.isDeleted,
        required this.createdAt,
        required this.updatedAt,
        required this.userId,
    });

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        cardNumber: json["cardNumber"],
        cvv: json["cvv"],
        cardHolder: json["cardHolder"],
        expiryDate: json["expiryDate"],
        isDeleted: json["isDeleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "cardNumber": cardNumber,
        "cvv": cvv,
        "cardHolder": cardHolder,
        "expiryDate": expiryDate,
        "isDeleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
    };
}
