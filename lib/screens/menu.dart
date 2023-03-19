
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider_cc/screens/account.dart';
import 'package:rider_cc/screens/history.dart';
import 'package:rider_cc/screens/orders.dart';
import 'package:rider_cc/screens/transactions.dart';
import 'package:rider_cc/variables/GlobalVars.dart';
import 'package:rider_cc/variables/branding_color.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();

}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    var smallestDimension = MediaQuery.of(context).size.shortestSide;
    GlobalVars.axisCount = smallestDimension < 600 ? 2 : 3;
    GlobalVars.menuContext = context;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      // onTap: handleUserInteraction,
      // onPanDown: handleUserInteraction,
      child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            extendBody: true,
            body: _screens[GlobalVars.menuCurrentIndex],
            bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                color: Colors.red,
                notchMargin: 4,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: BottomNavigationBar(
                  unselectedIconTheme: IconThemeData(color: Colors.blueGrey[900]),
                  selectedIconTheme: IconThemeData(color: brandingColor),
                  selectedFontSize: 12,
                  unselectedFontSize: 12,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: GlobalVars.menuCurrentIndex,
                  onTap: onTapped,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.square_list_fill), label: 'Orders'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.list_bullet), label: 'Transactions'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.bag), label: 'History'),
                    BottomNavigationBarItem(
                        icon: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(CupertinoIcons.person),
                            GlobalVars.chatCount > 0
                                ? Positioned(
                              right: -8,
                              top: -8,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: brandingColor,
                                    shape: BoxShape.circle),
                                height: 18.0,
                                width: 18.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.5),
                                  child: FittedBox(
                                    child: Text(
                                      "${GlobalVars.chatCount}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )
                                : SizedBox(),
                          ],
                        ),
                        label: 'Account'),
                  ],
                )
            ),
          )
      ),
    );
  }

  // Timer? cart_timer;
  List<Widget>_screens = [
    Orders(),
    // // Container(),
     Transaction(),
     History(),
     Account(),
  ];

  @override
  void initState() {
    // cart_timer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   if (mounted) setState(() {});
    // });
    // checkLogin();
    super.initState();
  }

  // Sessiontimer sessionTimer = Sessiontimer();
  // void handleUserInteraction([_]) {
  //   // if (GlobalVariables.logcustomerCode.isNotEmpty) {
  //   //   sessionTimer.initializeTimer(context);
  //   // }
  //   if (User.id.isNotEmpty) {
  //     sessionTimer.initializeTimer(context);
  //   }
  //
  // }
  void onTapped(int index) {
    GlobalVars.menuCurrentIndex = index;
    setState(() {});
  }
  @override
  void dispose() {
    super.dispose();
 //   if (cart_timer != null) cart_timer!.cancel();
  }
  // Future checkLogin()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool status=prefs.getBool('isLoggedIn') ?? false;
  //   if(status){
  //     GlobalVariables.isLoggedin =  true;
  //     User.id       =  prefs.getString('users_id').toString();
  //     User.address  =  prefs.getString('users_address').toString();
  //     User.email    =  prefs.getString('users_email').toString();
  //     User.mobile   =  prefs.getString('users_mobile').toString();
  //     User.password =  prefs.getString('users_password').toString();
  //     User.username =  prefs.getString('users_username').toString();
  //     print('NI TRUE');
  //   }else{
  //     GlobalVariables.isLoggedin =  false;
  //     print('NI FALSE');
  //   }
  // }
}