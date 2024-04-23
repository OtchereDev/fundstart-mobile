

class TransactionResponse {
    String? message;
    List<Transaction>? transactions;

    TransactionResponse({
        this.message,
        this.transactions,
    });

    factory TransactionResponse.fromJson(Map<String, dynamic> json) => TransactionResponse(
        message: json["message"],
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
    };
}

class Transaction {
    String id;
    String transType;
    String amount;
    DateTime createdAt;
    DateTime updatedAt;
    String userId;
    User user;

    Transaction({
        required this.id,
        required this.transType,
        required this.amount,
        required this.createdAt,
        required this.updatedAt,
        required this.userId,
        required this.user,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        transType: json["transType"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "transType": transType,
        "amount": amount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "userId": userId,
        "user": user.toJson(),
    };
}

class User {
    String id;
    String email;
    String pangeaUserId;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        required this.id,
        required this.email,
        required this.pangeaUserId,
        required this.createdAt,
        required this.updatedAt,
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
