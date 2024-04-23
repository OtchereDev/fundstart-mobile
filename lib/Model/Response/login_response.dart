
class LoginResponse {
    String message;
    Data data;

    LoginResponse({
        required this.message,
        required this.data,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String flowId;

    Data({
        required this.flowId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        flowId: json["flow_id"],
    );

    Map<String, dynamic> toJson() => {
        "flow_id": flowId,
    };
}
