import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rider_cc/variables/GlobalVars.dart';
import 'package:rider_cc/variables/branding_color.dart';
import 'package:rider_cc/variables/caption.dart';
import 'dart:async';

import 'package:provider/provider.dart';
// import 'package:http/http.dart' show Client, Request, get;



class LoadingSpinkit extends StatefulWidget {
  @override
  _LoadingSpinkitState createState() => _LoadingSpinkitState();
}

class _LoadingSpinkitState extends State<LoadingSpinkit> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: loadingContent(context),
      ),
    );
  }

  loadingContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 50, bottom: 16, right: 5, left: 5),
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent,
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  // Provider.of<Caption>(context).cap,
                  context.watch<Caption>().cap,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
                SpinKitCircle(
                  color: brandingColor,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
      ],
    );
  }
}

load(String caption) {
  // GlobalVariables.statusCaption = 'Creating/Updating Database...';
  // context.read().changeCap('Creating/Updating Database...');
  Provider.of<Caption>(GlobalVars.context!, listen: false)
      .changeCap('$caption');
  GlobalVars.spinProgress = 0;

  if (GlobalVars.loadSpinkit == true) {
    showDialog(
        barrierDismissible: false,
        context: GlobalVars.context!,
        builder: (context) => LoadingSpinkit());
  }
  // GlobalVariables.viewPolicy = true;
}

unloadSpinkit() async {
  GlobalVars.loadSpinkit = false;
  print('Unload Spinkit');

    GlobalVars.tableProcessing = 'Unloading Spinkit . . .';

  // setState(() {
  //   GlobalVariables.tableProcessing = 'Unloading Spinkit . . .';
  // });
  Navigator.pop(GlobalVars.context!);
  // viewSampleTable();
  // updateItemImage();
}