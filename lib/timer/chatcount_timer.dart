import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rider_cc/services/apichat.dart';
import 'package:rider_cc/tools/notifservice.dart';
import 'package:rider_cc/variables/GlobalVars.dart';

class ChatCountTimer {
  void initializeTimer(BuildContext context) {
    startChatCount(context);
  }

  startChatCount(BuildContext context) {
    print('Setting to 5 seconds');
    print('Check Chat Count starts');
    GlobalVars.timerChatCount =
        Timer.periodic(Duration(seconds: 1), (Timer t) => chatCount(context));
  }

  cancelChatCount() {
    if (GlobalVars.timerChatCount != null) {
      print('Cancelling Chat Count');
      GlobalVars.timerChatCount?.cancel();
    }
  }

  chatCount(BuildContext context) async {
    NotificationService notificationService = NotificationService();
    var res = await getChatCount(context);
    List lst = res;
    // print('unseen mesg(down)');
    // print(lst);
    if (lst.length > 0) {
      GlobalVars.chatCount = int.parse(lst.length.toString());
      var sender =
          'New message from ${lst[lst.length - 1]['sender'].toString().toUpperCase()}';
      var msg = 'Message: ${lst[lst.length - 1]['msg_body']}';
      notificationService.initialize();
      notificationService.instantNotification(
          int.parse(lst[lst.length - 1]['id']), sender, msg);
    } else {
      GlobalVars.chatCount = 0;
      notificationService.cancelNotification();
    }
  }
}
