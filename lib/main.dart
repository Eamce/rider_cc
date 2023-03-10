import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rider_cc/services/api.dart';
import 'package:rider_cc/variables/branding_color.dart';
import 'package:rider_cc/variables/images.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, child) => MaterialApp(
        title: 'Cake Station',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: brandingColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.black.withOpacity(0)),
        ),
        // onGenerateRoute: Routers.onGenerateRoute,
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    // initPlatformStateCheckRooted();
    Timer(Duration(seconds: 5), () {
      checkFirstSeen();
    });
    // isLoggedin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.asset(
                  Images.logo,
                  width: 85,
                ),
              ),
            ),
            Container(
                child: Text("Loading please wait....",
                    style: TextStyle(color: Colors.black))),
            Container(
              width: 115,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }



  Future checkFirstSeen() async {
      var con = await checkConnection(context);
      // print(con);
      if (con == 'Connected') {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()),);
      }
    }

}
