import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void openWhatsapp(
    {required String phoneNumber,
    required String message,
    required BuildContext context}) async {

  late String formattedPhoneNumber;
  if(phoneNumber.contains('+91')){
    formattedPhoneNumber = phoneNumber;
  }else{
    formattedPhoneNumber = "+91$phoneNumber";
  }


  var whatsAppAndroid =
      "https://wa.me/$formattedPhoneNumber?text=$message";
  var whatsAppIos = "https://wa.me/$phoneNumber?text=${Uri.parse(message)}";

  if (Platform.isIOS) {
    if (await canLaunchUrl(Uri.parse(whatsAppIos))) {
      await launchUrl(Uri.parse(whatsAppIos),
          mode: LaunchMode.externalNonBrowserApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("whatsapp not installed")));
    }
  } else if (Platform.isAndroid) {
    await launchUrl(Uri.parse(whatsAppAndroid),
        mode: LaunchMode.externalNonBrowserApplication);
  }
}
