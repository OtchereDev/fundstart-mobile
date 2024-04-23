

abstract class FundraisersRepository {
  Future<dynamic> createFundraiser(context, data);
  Future<dynamic> getAllFundraiser(context);
  Future<dynamic> getCategory(context);
  Future<dynamic> getSingleFundraiser(context, String id);
  Future<dynamic> getAnalytics(context, {String? filter});


}