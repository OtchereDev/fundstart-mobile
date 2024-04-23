import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static shareMessageViaUrl({String? headerText, String? message}) {
    Share.share(message ?? "", subject: headerText ?? "");
  }
}
