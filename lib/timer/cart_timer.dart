// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:thesis101/models/customercart.dart';
// import 'package:thesis101/services/api.dart';
// import 'package:thesis101/globalvars.dart';
// class CartCountTimer {
//   void initializeTimer(BuildContext context) {
//     startCartCount(context);
//   }
//
//   startCartCount(BuildContext context) {
//     print('Setting to 5 seconds');
//     print('Check Cart Count starts');
//     GlobalVariables.timerCartCount =
//         Timer.periodic(Duration(seconds: 1), (Timer t) => cartCount(context));
//   }
//
//   cancelCartCount() {
//     if (GlobalVariables.timerCartCount != null) {
//       print('Cancelling Cart Count');
//       GlobalVariables.timerCartCount?.cancel();
//     }
//   }
//
//   cartCount(BuildContext context) async {
//     var res = await getCartItemCount(context);
//     // print('CART DETAIILS: $res');
//     Cart.cartItemCount = int.parse(res[0]['itemcount'].toString() != null ? res[0]['itemcount'].toString() : '0');
//   }
// }
