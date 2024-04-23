import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Formatters {
  static List<String> countryCodes = ["+233", "+234", "+44", "+1"];
  static String removeZeroFormNumber(String number) {
    String correctNumber = "";
    if (number[0] == "0") {
      correctNumber = (number.substring(1));
    } else {
      correctNumber = (number);
    }
    return correctNumber;
  }

  static String formatToInternationNumber(String countryCode, String number) {
    if (number[0] == "+") {
      return number;
    }
    return countryCode + removeZeroFormNumber(number);
  }

  static String removeCountryCode(String number) {
    String result = number
        .replaceAll('+233', '')
        .replaceAll('+234', '')
        .replaceAll("+1", "");
    return result;
  }

  static String getLocalNumber(String number) {
    if (number == '') return '';
    return number.substring(number.length - 9);
  }

  static String formatUserTime(String time) {
    String periodType = time.trim().substring(time.length - 2);
    String newTime = time.trim().substring(0, 5);

    return '$newTime $periodType';
  }

  static dynamic uTCDateFormat(DateTime dateTime) {
    var val = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(dateTime);
    var offset = dateTime.timeZoneOffset;
    var hours =
        offset.inHours > 0 ? offset.inHours : 1; // For fixing divide by 0

    if (!offset.isNegative) {
      val =
          "$val+${offset.inHours.toString().padLeft(2, '0')}:${(offset.inMinutes % (hours * 60)).toString().padLeft(2, '0')}";
    } else {
      val =
          "$val-${(-offset.inHours).toString().padLeft(2, '0')}:${(offset.inMinutes % (hours * 60)).toString().padLeft(2, '0')}";
    }
    return val;
  }

  static String getApproxTime(String movTime, String finishTime) {
    String periodType = "PM";
    final startTime = TimeOfDay(
        hour: int.parse(movTime.substring(0, 1)),
        minute: int.parse(movTime.substring(3, 4)));

    final endTime = TimeOfDay(
        hour: int.parse(finishTime.substring(0, 1)),
        minute: int.parse(finishTime.substring(3, 4)));

    var time = TimeOfDay(
        hour: startTime.hour + endTime.hour,
        minute: startTime.minute + endTime.minute);
    return "${time.hour}:${time.minute}$periodType";
  }

  static String getPayCardStr(String code) {
    final int length = code.length;
    final int replaceLength = length - 4;
    final String replacement =
        List<String>.generate((replaceLength / 4).ceil(), (int _) => '**** ')
            .join('');
    return code.replaceRange(0, replaceLength, replacement);
  }

  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    }
    if (hour < 17) {
      return 'Good afternoon';
    }
    return 'Good evening';
  }

  static whatsapp(String phone) async {
    //  var contact = "$phone";
    var androidUrl = "whatsapp://send?phone=$phone&text=Hi, I need some help";
    var iosUrl =
        "https://wa.me/$phone?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      //  EasyLoading.showError('WhatsApp is not installed.');
    }
  }

  static call(String phone) async {
     final call = Uri.parse('tel:$phone');
    launchUrl(call);
  }

  static email(String email) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Telapay support',
      }),
    );

    launchUrl(emailLaunchUri);
  }

   static Future<void> openMap() async {
    String googleUrl =
        'https://www.google.com/maps/dir/?api=1&destination=5.6279221,-0.2874478';
    if (await canLaunch(googleUrl)) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  } 

 static void launchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }
}


// 5.6279221,-0.2874478
