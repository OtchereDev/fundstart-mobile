

abstract class PaymentRepository {
  Future<dynamic> receiveMoney(context, data);
  Future<dynamic> createPaymentInit(context, data);
  Future<dynamic> getTransactions(context, String day);
  // Future<dynamic> getAnalytics(context, {String? filter});


}