
import 'dart:async';

import 'package:flutter/cupertino.dart';

class GlobalVars{

  static BuildContext? context;
  static BuildContext? menuContext;
  static StateSetter? setModalState;
  static double? spinProgress;
  static String tableProcessing = '';
  static int menuCurrentIndex = 0;
  static int chatCount = 0;
  static int axisCount = 2;
  static bool loadSpinkit = true;
  static String appVersion = '1.0.0';
  static String replyHolder = '';
  static Timer? timerCartCount;
  static Timer? timerSessionInactivity;
  static Timer? timerCheckConcurrentLogIn;
  static Timer? timerChatCount;
  static bool isLoggedin = false;
}