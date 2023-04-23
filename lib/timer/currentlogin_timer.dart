import 'dart:async';
// import 'package:edistribution/services/api.dart';
// import 'package:edistribution/utility/cartCountTimer.dart';
// import 'package:edistribution/utility/chatCountTimer.dart';
import 'package:rider_cc/variables/GlobalVars.dart';
import 'chatcount_timer.dart';
import 'session.dart';
import 'package:flutter/cupertino.dart';
import 'cart_timer.dart';
import 'package:flutter/material.dart';

class Concurrentlogintimer {
  void initializeTimer(BuildContext context) {
    startCheckingconcurrentlog(context);
  }

  startCheckingconcurrentlog(BuildContext context) {
    print('Setting to 5 seconds');
    print('Check Concurrent Login Timer starts');
    // GlobalVars.timerCheckConcurrentLogIn = Timer.periodic(
    //     Duration(seconds: 5), (Timer t) => checkCustomerActive(context));
  }

  cancelCheckingconcurrentlog() {
    if (GlobalVars.timerCheckConcurrentLogIn != null) {
      print('Cancelling Check Concurrent Login Timer');
      GlobalVars.timerCheckConcurrentLogIn?.cancel();
    }
  }
}
