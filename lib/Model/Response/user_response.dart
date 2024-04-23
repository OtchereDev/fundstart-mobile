
class UserResponse {
    Data data;

    UserResponse({
        required this.data,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    String requestId;
    DateTime requestTime;
    DateTime responseTime;
    String status;
    Result result;
    String summary;
    bool success;

    Data({
        required this.requestId,
        required this.requestTime,
        required this.responseTime,
        required this.status,
        required this.result,
        required this.summary,
        required this.success,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        requestId: json["request_id"],
        requestTime: DateTime.parse(json["request_time"]),
        responseTime: DateTime.parse(json["response_time"]),
        status: json["status"],
        result: Result.fromJson(json["result"]),
        summary: json["summary"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "request_id": requestId,
        "request_time": requestTime.toIso8601String(),
        "response_time": responseTime.toIso8601String(),
        "status": status,
        "result": result.toJson(),
        "summary": summary,
        "success": success,
    };
}

class Result {
    String id;
    String email;
    Profile profile;
    bool verified;
    bool disabled;
    bool lockedOut;
    DateTime lastLoginAt;
    DateTime createdAt;
    int loginCount;
    String lastLoginIp;
    String lastLoginCity;
    String lastLoginCountry;
    List<Authenticator> authenticators;

    Result({
        required this.id,
        required this.email,
        required this.profile,
        required this.verified,
        required this.disabled,
        required this.lockedOut,
        required this.lastLoginAt,
        required this.createdAt,
        required this.loginCount,
        required this.lastLoginIp,
        required this.lastLoginCity,
        required this.lastLoginCountry,
        required this.authenticators,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        email: json["email"],
        profile: Profile.fromJson(json["profile"]),
        verified: json["verified"],
        disabled: json["disabled"],
        lockedOut: json["locked_out"],
        lastLoginAt: DateTime.parse(json["last_login_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        loginCount: json["login_count"],
        lastLoginIp: json["last_login_ip"],
        lastLoginCity: json["last_login_city"],
        lastLoginCountry: json["last_login_country"],
        authenticators: List<Authenticator>.from(json["authenticators"].map((x) => Authenticator.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "profile": profile.toJson(),
        "verified": verified,
        "disabled": disabled,
        "locked_out": lockedOut,
        "last_login_at": lastLoginAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "login_count": loginCount,
        "last_login_ip": lastLoginIp,
        "last_login_city": lastLoginCity,
        "last_login_country": lastLoginCountry,
        "authenticators": List<dynamic>.from(authenticators.map((x) => x.toJson())),
    };
}

class Authenticator {
    String id;
    String type;
    bool enabled;
    String phase;
    String enrollingBrowser;
    String enrollingIp;
    DateTime createdAt;
    DateTime updatedAt;

    Authenticator({
        required this.id,
        required this.type,
        required this.enabled,
        required this.phase,
        required this.enrollingBrowser,
        required this.enrollingIp,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Authenticator.fromJson(Map<String, dynamic> json) => Authenticator(
        id: json["id"],
        type: json["type"],
        enabled: json["enabled"],
        phase: json["phase"],
        enrollingBrowser: json["enrolling_browser"],
        enrollingIp: json["enrolling_ip"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "enabled": enabled,
        "phase": phase,
        "enrolling_browser": enrollingBrowser,
        "enrolling_ip": enrollingIp,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Profile {
    String? firstName;
    String? lastName;
    String? phone;

    Profile({
         this.firstName,
         this.lastName,
         this.phone,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        firstName: json["first_name"],
        lastName: json["last_name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
    };
}
