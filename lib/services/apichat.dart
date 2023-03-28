import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider_cc/chatmodels/chatDetailModel.dart';
import 'package:rider_cc/chatmodels/chatHeadModel.dart';
import 'package:rider_cc/services/server.dart';
import 'package:rider_cc/tools/custom_modal.dart';
import 'package:rider_cc/variables/GlobalVars.dart';
import 'package:rider_cc/variables/riders.dart';



Future<List<ChatHead>> getChatHead(int offset) async {
  List<ChatHead> chatHeadList = [];
  var url = Uri.parse(Server.url + "getChatHead");
  final response = await http.post(url, headers: {
    "Accept": "Application/json"
  }, body: {
    'accountcode': Rider.id,
    'offset': offset.toString(),
  });
  var convertedDataToJson = jsonDecode(response.body);
  for (var chat in convertedDataToJson) {
    chatHeadList.add(ChatHead.fromJson(chat));
  }
  chatHeadList.sort((a, b) => b.newmsgdatetime.compareTo(a.newmsgdatetime));
  return chatHeadList;
}

Stream<List<ChatHead>> getChatHeads(Duration refreshTime, int offset) async* {
  while (true) {
    await Future.delayed(refreshTime);
    yield await getChatHead(offset);
  }
}

Future<List<ChatDetail>> getChatHeadDetail(String trans_no) async {
  List<ChatDetail> chatDetailList = [];
  var url = Uri.parse(Server.url + "getChatHeadDetails");
  final response = await http.post(url, headers: {
    "Accept": "Application/json"
  }, body: {
    'trans_no': trans_no,
  });
  // var convertedDataToJson = jsonDecode(response.body);
  var convertedDataToJson = jsonDecode(response.body);
  //print('convertedDataToJson $convertedDataToJson');
  for (var chat in convertedDataToJson) {
    //print('chat ${ChatDetail.fromJson(chat)}');
    chatDetailList.add(ChatDetail.fromJson(chat));
  }
  GlobalVars.replyHolder = '';
  //print('CHAT DETAIL LIST: $chatDetailList');
  return chatDetailList;
}

Stream<List<ChatDetail>> getChatHeadDetails(
    Duration refreshTime, String trans_no) async* {
  while (true) {
    await Future.delayed(refreshTime);
    yield await getChatHeadDetail(trans_no);
  }
}

Future insertChatReply(BuildContext context, String trans_no, String msg) async {
  try {
    var url = Uri.parse(Server.url + "insertChatReply");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'sender_id': Rider.id,
      'trans_no': trans_no,
      'msg': msg,
      'sender': 'customer',
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(response.body);
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text(
              "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
              () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      customModal(
          context,
          Icon(CupertinoIcons.exclamationmark_circle,
              size: 50, color: Colors.red),
          Text("Error: ${response.statusCode}. Internal server error.",
              textAlign: TextAlign.center),
          true,
          Icon(
            CupertinoIcons.checkmark_alt,
            size: 25,
            color: Colors.greenAccent,
          ),
          '',
              () {});
    }
  } on TimeoutException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
            () {});
  } on SocketException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text(
            "Connection timed out. Please check internet connection or proxy server configurations.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
            () {});
  } on HttpException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("An HTTP error eccured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
            () {});
  } on FormatException {
    customModal(
        context,
        Icon(CupertinoIcons.exclamationmark_circle,
            size: 50, color: Colors.red),
        Text("Format exception error occured. Please try again later.",
            textAlign: TextAlign.center),
        true,
        Icon(
          CupertinoIcons.checkmark_alt,
          size: 25,
          color: Colors.greenAccent,
        ),
        'Okay',
            () {});
  }
}

Future getChatCount(BuildContext context) async {
  try {
    var url = Uri.parse(Server.url + "mapiv2/getChatCount");
    final response = await http.post(url, headers: {
      "Accept": "Application/json"
    }, body: {
      'accountcode': Rider.id,
    });
    if (response.statusCode == 200) {
      var convertedDataToJson = jsonDecode(response.body);
      return convertedDataToJson;
    } else if (response.statusCode >= 400 || response.statusCode <= 499) {
      // customModal(
      //     context,
      //     Icon(CupertinoIcons.exclamationmark_circle,
      //         size: 50, color: Colors.red),
      //     Text(
      //         "Error: ${response.statusCode}. Your client has issued a malformed or illegal request.",
      //         textAlign: TextAlign.center),
      //     true,
      //     Icon(
      //       CupertinoIcons.checkmark_alt,
      //       size: 25,
      //       color: Colors.greenAccent,
      //     ),
      //     '',
      //     () {});
    } else if (response.statusCode >= 500 || response.statusCode <= 599) {
      // customModal(
      //     context,
      //     Icon(CupertinoIcons.exclamationmark_circle,
      //         size: 50, color: Colors.red),
      //     Text("Error: ${response.statusCode}. Internal server error.",
      //         textAlign: TextAlign.center),
      //     true,
      //     Icon(
      //       CupertinoIcons.checkmark_alt,
      //       size: 25,
      //       color: Colors.greenAccent,
      //     ),
      //     '',
      //     () {});
    }
  } on TimeoutException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text(
    //         "Connection timed out. Please check internet connection or proxy server configurations.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on SocketException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text(
    //         "Connection timed out. Please check internet connection or proxy server configurations.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on HttpException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text("An HTTP error eccured. Please try again later.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  } on FormatException {
    // customModal(
    //     context,
    //     Icon(CupertinoIcons.exclamationmark_circle,
    //         size: 50, color: Colors.red),
    //     Text("Format exception error occured. Please try again later.",
    //         textAlign: TextAlign.center),
    //     true,
    //     Icon(
    //       CupertinoIcons.checkmark_alt,
    //       size: 25,
    //       color: Colors.greenAccent,
    //     ),
    //     'Okay',
    //     () {});
  }
}