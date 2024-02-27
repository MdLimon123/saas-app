import 'dart:io';

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';

late bool isIos;
TranslateStringService? tsProvider;

getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

screenSizeAndPlatform(BuildContext context) {
  checkPlatform();
}
//responsive screen codes ========>

var fourinchScreenHeight = 610;
var fourinchScreenWidth = 385;

checkPlatform() {
  if (Platform.isAndroid) {
    isIos = false;
  } else if (Platform.isIOS) {
    isIos = true;
  }
}
