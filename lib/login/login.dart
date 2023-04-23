













































































import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider_cc/Animation/Fade_Animation.dart';
import 'package:rider_cc/Colors/Hex_Color.dart';
import 'package:rider_cc/account/SignUp_Screen.dart';
import 'package:rider_cc/main.dart';
import 'package:rider_cc/screens/menu.dart';
import 'package:rider_cc/services/api.dart';
import 'package:rider_cc/tools/loadspinkit.dart';
import 'package:rider_cc/variables/GlobalVars.dart';
import 'package:rider_cc/variables/riders.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rider_cc/tools/custom_modal.dart';
import 'package:rider_cc/variables/images.dart';
import 'package:back_pressed/back_pressed.dart';
enum FormData {
  Email,
  password,
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledtxt = Colors.white;
  Color deaible = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool ispasswordev = true;
  FormData? selected;

  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      OnBackPressed(
        perform: (){
          print('BACK PRESS');
        return  Splash();
          //perform any action on back pressed
        },
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.4, 0.7, 0.9],
            colors: [
              HexColor("#9F2B68").withOpacity(0.8),
              HexColor("#AA336A"),
              HexColor("#770737"),
              HexColor("#770737")
            ],
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                HexColor("#DE3163").withOpacity(0.2), BlendMode.dstATop),

             image: const AssetImage(
                 'assets/images/logo/logo2.png'
                           ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color:
                  const Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeAnimation(
                          delay: 0.8,
                          child: Image.asset(
                            Images.logo,
                            width: 85,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: const Text(
                            "Please sign in to continue",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: selected == FormData.Email
                                  ? enabled
                                  : backgroundColor,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: userController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.Email;
                                });
                              },
                              decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.person_pin,
                                  color: selected == FormData.Email
                                      ? enabledtxt
                                      : deaible,
                                  size: 20,
                                ),
                                hintText: 'Username',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Email
                                        ? enabledtxt
                                        : deaible,
                                    fontSize: 12),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.Email
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            width: 300,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: selected == FormData.password
                                    ? enabled
                                    : backgroundColor),
                            padding: const EdgeInsets.all(5.0),
                            child: TextField(
                              controller: passwordController,
                              onTap: () {
                                setState(() {
                                  selected = FormData.password;
                                });
                              },
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.lock_open_outlined,
                                    color: selected == FormData.password
                                        ? enabledtxt
                                        : deaible,
                                    size: 20,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: ispasswordev
                                        ? Icon(
                                      Icons.visibility_off,
                                      color: selected == FormData.password
                                          ? enabledtxt
                                          : deaible,
                                      size: 20,
                                    )
                                        : Icon(
                                      Icons.visibility,
                                      color: selected == FormData.password
                                          ? enabledtxt
                                          : deaible,
                                      size: 20,
                                    ),
                                    onPressed: () => setState(
                                            () => ispasswordev = !ispasswordev),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: selected == FormData.password
                                          ? enabledtxt
                                          : deaible,
                                      fontSize: 12)),
                              obscureText: ispasswordev,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                  color: selected == FormData.password
                                      ? enabledtxt
                                      : deaible,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                              onPressed: (){
                                if(checkFields()){
                                  GlobalVars.context = context;
                                  // if (mounted)
                                  checkLogin();


                                }else{
                                  customModal(
                                      context,
                                      Icon(
                                          CupertinoIcons
                                              .exclamationmark_circle,
                                          size: 50,
                                          color: Colors.red),
                                      Text(
                                          "Please fill up the required fields.",
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
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF880E4F),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 80),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(12.0)))),
                        ),
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card
                const SizedBox(
                  height: 10,
                ),
                FadeAnimation(
                  delay: 1,
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (context) {
                      //   return ForgotPasswordScreen();
                      // }));
                    }),
                    child: Text("Can't Log In?",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 0.5,
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SignupScreen();
                          }));
                        },
                        child: Text("Sign up",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
      );
  }

   bool checkFields(){
   if(userController.text.isNotEmpty &&
       passwordController.text.isNotEmpty){
     return true;
   }
   else{
     return false;
   }
  }

  Future checkLogin()async{
    load('Logging in please wait...');
    var con = await checkConnection(context);

    if(con == 'Connected'){
      var rider = await riderLogin(context, userController.text, passwordController.text);
      setState(() {
        unloadSpinkit();
      });
      print('Rider Details: $rider');
      if (rider != 'invaliduser' && rider != 'invalidpassword') {
            login(rider);
      }else if (rider == 'invaliduser'){
        customModal(
            context,
            Icon(
                CupertinoIcons
                    .exclamationmark_circle,
                size: 50,
                color: Colors.red),
            Text(
                "Invalid Credentials",
                textAlign: TextAlign.center),
            true,
            Icon(
              CupertinoIcons.checkmark_alt,
              size: 25,
              color: Colors.greenAccent,
            ),
            'Okay',
                () {});
      } else if(rider == 'invalidpassword'){
        customModal(
            context,
            Icon(
                CupertinoIcons
                    .exclamationmark_circle,
                size: 50,
                color: Colors.red),
            Text(
                "Invalid Password",
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
      GlobalVars.loadSpinkit =  true;
    }else {
      setState(() {
        unloadSpinkit();
      });
      customModal(
          context,
          Icon(
              CupertinoIcons
                  .exclamationmark_circle,
              size: 50,
              color: Colors.red),
          Text(
              "No connection! Please check your internet connection.",
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

  Future login(List rider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pop(context);
    prefs.setString('riders_id', rider[0]['users_id'].toString().trim());
    prefs.setString('riders_fullname', rider[0]['users_address'].toString().trim());
    prefs.setString('riders_email', rider[0]['users_email'].toString().trim());
    prefs.setString('riders_mobile', rider[0]['users_mobile'].toString().trim());
    prefs.setString('riders_password', rider[0]['users_password'].toString().trim());
    prefs.setString('riders_username', rider[0]['users_username'].toString().trim());
    Rider.id       =  prefs.getString('riders_id').toString();
    Rider.fullname  =  prefs.getString('riders_fullname').toString();
    Rider.email    =  prefs.getString('riders_email').toString();
    Rider.mobile   =  prefs.getString('riders_mobile').toString();
    Rider.password =  prefs.getString('riders_password').toString();
    Rider.username =  prefs.getString('riders_username').toString();
    prefs.setBool('isLoggedIn', true);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()),);
  }

}
