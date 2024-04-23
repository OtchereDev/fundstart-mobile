
abstract class WalletRepository {
  Future<dynamic> createWallet(context, data);
  Future<dynamic> getAllWallet(context);
  Future<dynamic> getSingleWallet(context, String id);
}