import 'dart:convert';

import 'package:crowdfunding/Core/Api/routes.dart';
import 'package:crowdfunding/Core/Mixins/auth_base_repository.dart';
import 'package:crowdfunding/Core/Repositories/Payments/payments_repo.dart';

class PaymentService with AuthBaseRepository implements PaymentRepository {
  @override
  String token = "N/A";
  // SharedPrefsManager _manager = new SharedPrefsManager();

  @override
  // Future<Map<String, String>> setHeaders() async {
  //   token = await SharedPrefsManager().getAuthToken();
  //   return {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  // }

  @override
  Future createPaymentInit(context, data) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(
      context,
      url: "$kBaseUrl/payment/create-payment",
      data: jsonEncode(data),
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
      // print(responseMap);
    });
    return responseMap;
  }

  Future getAllTransactions(
    context, {
    String? filter,
  }) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await get(
      context,
      url: "$kBaseUrl/transaction",
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
      // print(responseMap);
    });
    return responseMap;
  }

  @override
  Future getTransactions(context, String day) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};

    await get(
      context,
      url: "$kBaseUrl/transaction",
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (dataResponse['status'] == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
      // print(responseMap);
    });
    return responseMap;
  }

  @override
  Future receiveMoney(context, data) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    // print(jsonEncode(data));
    await post(
      context,
      url: "$kTheTellerBaseUrl/payment/momo/process",
      data: jsonEncode(data),
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (dataResponse['status'] == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
      // print(responseMap);
    });
    return responseMap;
  }

  Future initPaymanet(
    context,
    data,
  ) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(
      context,
      url: "$kTheTellerBaseUrl/payment/momo/initiate",
      data: jsonEncode(data),
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (dataResponse['status'] == 201) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
      // print(responseMap);
    });
    return responseMap;
  }

  Future getSuccessfulCount(context, data) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(
      context,
      url: "$kTheTellerBaseUrl/transaction/count",
      data: jsonEncode(data),
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (dataResponse['status'] == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
      // print(responseMap);
    });
    return responseMap;
  }

  Future getBalance(context, data) async {
    dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(
      context,
      url: "$kTheTellerBaseUrl/transaction/sales/today",
      data: jsonEncode(data),
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);
        if (dataResponse['status'] == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
    });
    return responseMap;
  }

  Future checkStatus(context, data) async {
    print(data);

    dynamic responseMap = {"status": false, "message": "", "data": null};
    await post(
      context,
      url: "$kTheTellerBaseUrl/transaction/status",
      data: jsonEncode(data),
    ).then((response) {
      if (response != null) {
        var dataResponse = json.decode(response.body);

        print(dataResponse);
        if (dataResponse['status'] == 200) {
          responseMap['status'] = true;
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        } else {
          responseMap['message'] = dataResponse['message'];
          responseMap['data'] = dataResponse;
        }
      }
      // print(responseMap);
    });
    return responseMap;
  }
}
