// ignore_for_file: constant_identifier_names

part of AppConfig;

class AppColors {
  static final Color primaryColor = HexColor.fromHex("0D6726");
  static const PRIMARYCOLOR = Color(0xff171F45);
  static const SECONDARYCOLOR = Color(0xff541975);
  static const TERTIARYCOLOR = Color(0xff9AC8CD);
  static const ACTIVECOLOR = Color(0xff3A7518);
  static const INACTIVEBUTTONS = Color(0XFFB2E5CD);
  static const WHITE = Colors.white;
  static const BLACK = Colors.black;
  static const ASHDEEP = Colors.grey;
  static const ASH = Color(0xffCCCCCC);
  static const DIFCOLOR = Color(0xffA8A8A9);
  static const LIGHTASH = Color(0XFFEFEFF4);
  static const BACKREDCOLOR = Color(0xffF0F5FF);
  static const ICONCOLOR = Color(0xFFE6A9A9);
  static const LIGHTGREEN = Color(0xffD8F2E6);
// ignore: use_full_hex_values_for_flutter_colors
  static const LIGHTGREEN2 = Color(0xffccf0df6);
  static const LIGHTRED = Color(0xFFE6A9A9);
  static const RED = Color(0xffC44646);
  static const SPLASHSCREEN_COLOR = Color(0xfff5f5e9);
  static const GREENCOLOR = Color(0xff27AE60);
  static const GREY = Color(0xffEEEEEE);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
