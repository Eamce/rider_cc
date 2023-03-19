import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rider_cc/login/login.dart';
import 'package:rider_cc/tools/customModal.dart';
import 'package:rider_cc/variables/GlobalVars.dart';
import 'package:rider_cc/variables/branding_color.dart';
import 'package:rider_cc/variables/riders.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}
class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var appBarSize = AppBar().preferredSize.height;
    var safePadding = MediaQuery.of(context).padding.top;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(height: safePadding, color: brandingColor),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.person_alt_circle,
                            size: appBarSize + (appBarSize / 2),
                            color: Colors.blueGrey[900],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${Rider.username}",
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                              Text("${Rider.fullname}",
                                  maxLines: 2, overflow: TextOverflow.ellipsis)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Text(
                    "ACCOUNT",
                    style: TextStyle(color: Colors.blueGrey[900]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.lock_circle,
                                color: Colors.blueGrey[900]),
                            Text(" Change Password"),
                            Spacer(),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.blueGrey[900]),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.rightToLeft,
                        //         child: ChangePassword()));
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Text(
                    "ABOUT",
                    style: TextStyle(color: Colors.blueGrey[900]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.app, color: Colors.blueGrey[900]),
                          Text(" App Version"),
                          Spacer(),
                          Text(GlobalVars.appVersion),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.phone_down_circle,
                                color: Colors.blueGrey[900]),
                            Text(" Contact Us"),
                            Spacer(),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.blueGrey[900]),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.rightToLeft,
                        //         child: ContactUsScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),

            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.person_alt_circle,
                                color: Colors.blueGrey[900]),
                            Text(" Logout"),
                            Spacer(),
                            Icon(CupertinoIcons.square_arrow_left,
                                color: Colors.blueGrey[900]),
                          ],
                        ),
                      ),
                      onTap: () {
                        //logout
                        customLogicalModal(
                            context,
                            Text("Are you sure you want to logout?"),
                                () => Navigator.pop(context), ()async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          Rider.id = '';
                          GlobalVars.menuCurrentIndex = 0;
                          // GlobalVariables.cartItemCount = 0;
                          if (mounted) setState(() {});
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen(),
                            ),
                                (Route route) =>
                            false, //if you want to disable back feature set to false1
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

}