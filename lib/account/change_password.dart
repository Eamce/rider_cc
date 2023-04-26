import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rider_cc/screens/menu.dart';
import 'package:rider_cc/services/api.dart';
import 'package:rider_cc/timer/session.dart';
import 'package:rider_cc/tools/custom_modal.dart';
import 'package:rider_cc/variables/GlobalVars.dart';
import 'package:rider_cc/variables/branding_color.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  bool? connectionChecking;
  String? connectionChecingStatus;

  final newPassController = TextEditingController();
  final newConfirmPassController = TextEditingController();
  final oldPassController = TextEditingController();
  String appBarTitle ='';
  String customTitle = '';
  bool? showNewPassword;
  bool? showOldPassword;
  bool? showNewConfirmPassword;
  bool isVisible = false;
  bool hasMinLength = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;
  Sessiontimer sessionTimer = Sessiontimer();
  // CartCountTimer cartCountTimer = CartCountTimer();
  // ChatCountTimer chatCountTimer = ChatCountTimer();
  void handleUserInteraction([_]) {
    sessionTimer.initializeTimer(context);
  }

  @override
  void initState() {
    showNewPassword = true;
    showOldPassword = true;
    showNewConfirmPassword = true;
    if( GlobalVars.isLoggedin ){
      appBarTitle = 'Change Password';
      isVisible = true;
    }else{
      appBarTitle = 'Reset Password';
      isVisible = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: handleUserInteraction,
      onPanDown: handleUserInteraction,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: brandingColor,
            titleSpacing: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('$appBarTitle',
                style: TextStyle(color: Colors.white)),
            bottom: PreferredSize(  
                child: connectionChecking == true
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    connectionChecingStatus != ''
                        ? Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0),
                      child: Text(
                        connectionChecingStatus!,
                        style: TextStyle(
                            color: Colors.redAccent, fontSize: 10),
                      ),
                    )
                        : SizedBox(),
                    LinearProgressIndicator(),
                  ],
                )
                    : SizedBox(),
                preferredSize: Size.fromHeight(4.0)),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: isVisible,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                            Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Old Password",
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: " *Required",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: TextFormField(
                                    controller: oldPassController,
                                    obscureText: showOldPassword!,
                                    textCapitalization: TextCapitalization.words,
                                    style: TextStyle(
                                      color: Colors.blueGrey[900],
                                    ),
                                    decoration: InputDecoration(
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: oldPassController.text.isNotEmpty
                                                ? Icon(
                                                CupertinoIcons.xmark_circle_fill,
                                                color: Colors.redAccent)
                                                : SizedBox(),
                                            onPressed: () {
                                              oldPassController.clear();
                                              // hasMinLength = false;
                                              // hasUppercase = false;
                                              // hasLowercase = false;
                                              // hasDigits = false;
                                              // hasSpecialCharacters = false;
                                              if (mounted) setState(() {});
                                            },
                                          ),
                                          IconButton(
                                            icon: !showOldPassword!
                                                ? Icon(CupertinoIcons.eye_fill,
                                                color: Colors.blueGrey[900])
                                                : Icon(CupertinoIcons.eye_slash_fill,
                                                color: Colors.blueGrey[900]),
                                            onPressed: () {
                                              showOldPassword = !showOldPassword!;
                                              if (mounted) setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                      hintStyle: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black54),
                                      hintText: "Enter old password",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(3)),
                                    ),
                                    onChanged: (value) {
                                      // hasMinLength = value.length > 7;
                                      // hasUppercase =
                                      //     value.contains(new RegExp(r'[A-Z]'));
                                      // hasLowercase =
                                      //     value.contains(new RegExp(r'[a-z]'));
                                      // hasDigits =
                                      //     value.contains(new RegExp(r'[0-9]'));
                                      // hasSpecialCharacters = value.contains(
                                      //     new RegExp(r'[!@#$%^&*(),.?":{}|<>\-\_]'));
                                      if (mounted) setState(() {});
                                    },
                                  ),
                                ),
                             ]
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "New Password",
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: " *Required",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextFormField(
                              controller: newPassController,
                              obscureText: showNewPassword!,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                color: Colors.blueGrey[900],
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: newPassController.text.isNotEmpty
                                          ? Icon(
                                          CupertinoIcons.xmark_circle_fill,
                                          color: Colors.redAccent)
                                          : SizedBox(),
                                      onPressed: () {
                                          newPassController.clear();
                                        // hasMinLength = false;
                                        // hasUppercase = false;
                                        // hasLowercase = false;
                                        // hasDigits = false;
                                        // hasSpecialCharacters = false;
                                        if (mounted) setState(() {});
                                      },
                                    ),
                                    IconButton(
                                      icon: !showNewPassword!
                                          ? Icon(CupertinoIcons.eye_fill,
                                          color: Colors.blueGrey[900])
                                          : Icon(CupertinoIcons.eye_slash_fill,
                                          color: Colors.blueGrey[900]),
                                      onPressed: () {
                                        showNewPassword = !showNewPassword!;
                                        if (mounted) setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                                hintText: "Enter new password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              onChanged: (value) {
                                // hasMinLength = value.length > 7;
                                // hasUppercase =
                                //     value.contains(new RegExp(r'[A-Z]'));
                                // hasLowercase =
                                //     value.contains(new RegExp(r'[a-z]'));
                                // hasDigits =
                                //     value.contains(new RegExp(r'[0-9]'));
                                // hasSpecialCharacters = value.contains(
                                //     new RegExp(r'[!@#$%^&*(),.?":{}|<>\-\_]'));
                                if (mounted) setState(() {});
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 8.0, right: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Confirm Password",
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text: " *Required",
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TextFormField(
                              controller: newConfirmPassController,
                              obscureText: showNewConfirmPassword!,
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                color: Colors.blueGrey[900],
                              ),
                              decoration: InputDecoration(
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: newConfirmPassController
                                          .text.isNotEmpty
                                          ? Icon(
                                          CupertinoIcons.xmark_circle_fill,
                                          color: Colors.redAccent)
                                          : SizedBox(),
                                      onPressed: () {
                                        newConfirmPassController.clear();
                                        if (mounted) setState(() {});
                                      },
                                    ),
                                    IconButton(
                                      icon: !showNewConfirmPassword!
                                          ? Icon(CupertinoIcons.eye_fill,
                                          color: Colors.blueGrey[900])
                                          : Icon(CupertinoIcons.eye_slash_fill,
                                          color: Colors.blueGrey[900]),
                                      onPressed: () {
                                        showNewConfirmPassword =
                                        !showNewConfirmPassword!;
                                        if (mounted) setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black54),
                                hintText: "Enter confirm password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3)),
                              ),
                              onChanged: (value) {
                                if (mounted) setState(() {});
                              },
                            ),
                          ),
                          Visibility(
                            visible: isVisible,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Row(
                                children: [
                                  Spacer(),
                                  TextButton(
                                    style: ButtonStyle(
                                        overlayColor:
                                        MaterialStateColor.resolveWith(
                                                (states) =>
                                            Colors.transparent)),
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    onPressed: () {
                                      // Navigator.push(
                                      //     context,
                                      //     PageTransition(
                                      //         type: PageTransitionType
                                      //             .rightToLeft,
                                      //         child: NumberVerification()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // ParallaxContainer(
                          //     child: TextButton(
                          //       onPressed: () => print('Next'),
                          //       child: Text(
                          //         'Next',
                          //         style: TextStyle(
                          //           color: Colors.black,
                          //           fontSize: 20.0,
                          //           fontFamily: 'Segoe UI',
                          //         ),
                          //       ),
                          //     ),
                          //     position: 20.0
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 20.0, top: 8.0),
                            child: MaterialButton(
                              minWidth: size.width,
                              color: brandingColor,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              onPressed: () async {
                                if (checkEmptyRequiredField() == false) {
                                  if (isPasswordCompliant() == false) {
                                    if (checkIfEqual() == true) {
                                      saveChanges();
                                    } else {
                                      customModal(
                                          context,
                                          Icon(
                                              CupertinoIcons
                                                  .exclamationmark_circle,
                                              size: 50,
                                              color: Colors.red),
                                          Text("Password do not match.",
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
                                  } else {
                                    customModal(
                                        context,
                                        Icon(
                                            CupertinoIcons
                                                .exclamationmark_circle,
                                            size: 50,
                                            color: Colors.red),
                                        Text(
                                            "The password does not meet the password policy requirements.",
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
                                } else {
                                  customModal(
                                      context,
                                      Icon(
                                          CupertinoIcons.exclamationmark_circle,
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Password must:"),
                                  Text("* Have a minimum of 8 characters",
                                      style: TextStyle(
                                        color: hasMinLength
                                            ? Colors.green
                                            : Colors.redAccent,
                                      )),
                                  Text("* Include atleast 1 uppercase",
                                      style: TextStyle(
                                        color: hasUppercase
                                            ? Colors.green
                                            : Colors.redAccent,
                                      )),
                                  Text("* Include atleast 1 lowercase",
                                      style: TextStyle(
                                        color: hasLowercase
                                            ? Colors.green
                                            : Colors.redAccent,
                                      )),
                                  Text("* Include atleast 1 digit",
                                      style: TextStyle(
                                        color: hasDigits
                                            ? Colors.green
                                            : Colors.redAccent,
                                      )),
                                  Text(
                                      '* Include atleast 1 special character: !@#\$%^&*(),.?":{}|<>-_',
                                      style: TextStyle(
                                        color: hasSpecialCharacters
                                            ? Colors.green
                                            : Colors.redAccent,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool? checkEmptyRequiredField() {
    if (newPassController.text.isEmpty ||
        newConfirmPassController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool? isPasswordCompliant() {
    // if (hasDigits &
    // hasUppercase &
    // hasLowercase &
    // hasSpecialCharacters &
    // hasMinLength) {
    //   return false;
    // } else {
    //   return true;
    // }
    return false;
  }

  bool? checkIfEqual() {
    if (newPassController.text == newConfirmPassController.text) {
      return true;
    } else {
      return false;
    }
  }

  saveChanges() async {
    showDialog<String>(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
    );
    connectionChecking = true;
    connectionChecingStatus = 'Saving password';
    if (mounted) setState(() {});

    var con = await checkConnection(context);
    Navigator.pop(context);
    if (con == 'Connected') {
       var res; //= await changePass(
      //     context, User.id.toString(), newPassController.text);
      if (res != "passwordused" && res != null) {
        connectionChecking = false;
        connectionChecingStatus = '';
        if (mounted) setState(() {});
        customModal(
            context,
            Icon(CupertinoIcons.exclamationmark_circle,
                size: 50, color: Colors.red),
            Text("Password successfully changed.", textAlign: TextAlign.center),
            false,
            Icon(
              CupertinoIcons.checkmark_alt,
              size: 25,
              color: Colors.greenAccent,
            ),
            'Okay', () {
          // GlobalVariables.forgotcustomerCode = '';
          // GlobalVariables.forgotcustomerMobile = '';
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => Menu(),
            ),
                (Route route) =>
            false, //if you want to disable back feature set to false1
          );
        });
      } else if (res == "passwordused") {
        connectionChecking = false;
        connectionChecingStatus = '';
        if (mounted) setState(() {});
        if(GlobalVars.isLoggedin){
          customTitle = 'You cannot change your password using your current password. Try a different one.';
        }else{
          customTitle = 'You cannot change your password using your current password. Try a different one.';
        }
        customModal(
            context,
            Icon(CupertinoIcons.exclamationmark_circle,
                size: 50, color: Colors.red),
            Text('$customTitle',
                textAlign: TextAlign.center),
            true,
            Icon(
              CupertinoIcons.checkmark_alt,
              size: 25,
              color: Colors.greenAccent,
            ),
            'Okay',
                () {});
      } else {
        connectionChecking = false;
        connectionChecingStatus = '';
        if (mounted) setState(() {});
      }
    }
  }
}
