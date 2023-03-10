import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider_cc/services/server.dart';
import 'package:rider_cc/tools/custom_modal.dart';

Future checkConnection(BuildContext context) async {
  try {
    var url = Uri.parse(Server.url + "checkConnection");
    final response = await http.post(url,
        headers: {"Accept": "Application/json"},
        body: {});
    if (response.statusCode == 200) {
      return "Connected";
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