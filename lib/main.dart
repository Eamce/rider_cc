import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rider_cc/Colors/Hex_Color.dart';
import 'package:rider_cc/login/login.dart';
import 'package:rider_cc/services/api.dart';
import 'package:rider_cc/variables/branding_color.dart';
import 'package:rider_cc/variables/caption.dart';
import 'package:rider_cc/variables/images.dart';
import 'package:back_pressed/back_pressed.dart';
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Caption()),

  ], child: MyApp()));
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
        home:   OnBackPressed(
          perform: (){
            Splash();
          //perform any action on back pressed
        },
          child: Splash(),
        ),

        //Splash(),
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
        color: HexColor("#770737").withOpacity(0.9),
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
                    style: TextStyle(color: Colors.white70))),
            Container(
              width: 115,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
         Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
      }
    }

  perform(){}


}
