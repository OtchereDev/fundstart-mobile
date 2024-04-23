import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crowdfunding/Core/Enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;

class Utils {
  static double screenWidth(context) => MediaQuery.of(context).size.width;
  static double screenHeight(context) => MediaQuery.of(context).size.height;

  static Future<String> convertImageToBase64(String imageAsset) async {
    ByteData bytes = await rootBundle.load(imageAsset);
    var buffer = bytes.buffer;
    return base64.encode(Uint8List.view(buffer));
  }

  bool keyboardIsVisible(context) {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  String formatDateTimeString(String date) {
    return date.substring(0, 10);
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static double calculateBearing(lat1, lon1, lat2, lon2) {
    double dLon = (lon2 - lon1);
    double y = sin(dLon) * cos(lat2);
    double x = (cos(lat1) * sin(lat2)) - (sin(lat1) * cos(lat2) * cos(dLon));
    double bearing = atan2(y, x);
    bearing = (360 - ((bearing + 360) % 360));
    return bearing;
  }

   static ScreenSize screenSize(BuildContext context) {
    return screenHeight(context) <= 480
        ? ScreenSize.small
        : screenHeight(context) > 480 && screenHeight(context) <= 900
            ? ScreenSize.medium
            : ScreenSize.large;
  }

  static int daysBetweenDates(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  static String timeAgo(DateTime dateTime){
  return  timeago.format(DateTime.now().subtract(dateTime.timeZoneOffset));
  }

}
