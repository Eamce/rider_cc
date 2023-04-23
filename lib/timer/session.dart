
import 'dart:async';
import 'package:rider_cc/variables/GlobalVars.dart';
import 'cart_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'currentlogin_timer.dart';
import 'chatcount_timer.dart';

class Sessiontimer {
  void initializeTimer(BuildContext context) {
    resetTimer(context);
  }

  resetTimer(BuildContext context) {
    //CartCountTimer cartCountTimer = CartCountTimer();
    Concurrentlogintimer concurrentlogintimer = Concurrentlogintimer();
    ChatCountTimer chatCountTimer = ChatCountTimer();
   // cartCountTimer.initializeTimer(context);

    if (GlobalVars.timerSessionInactivity != null) {
      print('Reset Session Timer');
      GlobalVars.timerSessionInactivity?.cancel();
  //    cartCountTimer.initializeTimer(context);
    }

    print('Setting to 10 minutes');
    GlobalVars.timerSessionInactivity =
        Timer(const Duration(minutes: 1), () async {
          //
          print('Session is over');
          if (GlobalVars.timerSessionInactivity != null) {
            print('Reset Session Timer');
            GlobalVars.timerSessionInactivity?.cancel();
          //  cartCountTimer.initializeTimer(context);
          }

        //   cartCountTimer.cancelCartCount();
        //   concurrentlogintimer.cancelCheckingconcurrentlog();
        //   chatCountTimer.cancelChatCount();
        //   customModal(
        //       context,
        //       Icon(CupertinoIcons.exclamationmark_circle,
        //           size: 50, color: Colors.redAccent),
        //       Text("Your session has expired due to inactivity.",
        //           textAlign: TextAlign.center),
        //       false,
        //       Icon(
        //         CupertinoIcons.checkmark_alt,
        //         size: 25,
        //         color: Colors.greenAccent,
        //       ),
        //       'Okay', () {
        //    // imageCache.clear();
        //  //   imageCache.clearLiveImages();
        //     GlobalVariables.logcustomerCode = '';
        // ////    GlobalVariables.menuCurrentIndex = 0;
        //    // Cart.cartItemCount = 0;
        //   //  GlobalVariables.chatCount = 0;
        //     // Navigator.of(context).pushAndRemoveUntil(
        //     //   MaterialPageRoute(
        //     //     builder: (BuildContext context) => Menu(),
        //     //   ),
        //     //       (Route route) =>
        //     //   false, //if you want to disable back feature set to false1
        //     // );
        //   });
          //
        });
  }

  cancelSessiontimer() {
    if (GlobalVars.timerSessionInactivity != null) {
      print('Cancelling Session Timer');
      GlobalVars.timerSessionInactivity?.cancel();
    }
  }
}
