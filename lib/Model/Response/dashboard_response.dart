

class DashboardResponse {
    Data? data;

    DashboardResponse({
         this.data,
    });

    factory DashboardResponse.fromJson(Map<String, dynamic> json) => DashboardResponse(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };
}

class Data {
    int? investedIn;
    int? fundraisersPercentage;
    int? amountInvested;
    int? investedPercentage;
    double? proposedProfit;
    double? profitPercentage;

    Data({
        this.investedIn,
        this.fundraisersPercentage,
        this.amountInvested,
        this.investedPercentage,
        this.proposedProfit,
        this.profitPercentage,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        investedIn: json["investedIn"],
        fundraisersPercentage: json["fundraisersPercentage"],
        amountInvested: json["amountInvested"],
        investedPercentage: json["investedPercentage"],
        proposedProfit: json["proposedProfit"]?.toDouble(),
        profitPercentage: json["profitPercentage"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "investedIn": investedIn,
        "fundraisersPercentage": fundraisersPercentage,
        "amountInvested": amountInvested,
        "investedPercentage": investedPercentage,
        "proposedProfit": proposedProfit,
        "profitPercentage": profitPercentage,
    };
}
