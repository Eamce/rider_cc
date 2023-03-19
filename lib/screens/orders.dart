import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rider_cc/models/CustomerOrder.dart';
import 'package:rider_cc/models/transactionlist.dart';
import 'package:rider_cc/screens/orderdetails.dart';
import 'package:rider_cc/screens/transactions.dart';
import 'package:rider_cc/services/api.dart';
import 'package:rider_cc/services/server.dart';
import 'package:rider_cc/variables/branding_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rider_cc/variables/stringExtension.dart';
class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}
class _OrdersState extends State<Orders> {
  bool done = false;
  int noOfItems = 0;
  bool updating = false;
  NumberFormat nF = NumberFormat.currency(locale: 'en', symbol: '₱ ');
  final ButtonStyle style = ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 11.0));
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var appBarSize = AppBar().preferredSize.height;
    var safePadding = MediaQuery.of(context).padding.top;
    var bottomPadding = MediaQuery.of(context).padding.bottom;
    return RefreshIndicator(
    onRefresh: () async {  check(); },
    child:
      Container(
      child: Column(
        children: [
          Container(height: safePadding, color: brandingColor),
          Container(
            color: brandingColor,
            alignment: Alignment.center,
            height: appBarSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TransactionList.gettransactions.length > 0 ? SizedBox() : Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Text(
                    "List of Transactions",
                    style: TextStyle(
                        color: Colors.white, fontSize: ScreenUtil().setSp(15)),
                  ),
                ),
                TransactionList.gettransactions.length > 0 ? SizedBox() : Spacer(),
              ],
            ),
          ),
          done ?TransactionList.gettransactions.length> 0
              ? Expanded(
            child:
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: Scrollbar(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: TransactionList.gettransactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 3.0, top: 3.0),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: size.height / 13,
                              width: size.height / 25,
                              color: Colors.white,
                              child: Icon(CupertinoIcons.list_dash),
                            ),
                            Expanded(
                              child: Container(
                                // height: size.height / 15,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                          TransactionList.gettransactions[index]['transaction_no'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                       //     Spacer(),
                            ElevatedButton(
                              style: style,
                              onPressed: () {
                                TransactionList.getTransaction_no = TransactionList.gettransactions[index]['transaction_no'];
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetails()),);
                              },
                              child: Text('View Order Details'),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
              : nothing()
              : loadingCart(),
        ],
      ),
      ));

  }

  Widget loadingCart() {
    return Column(
      children: [
        Center(child: CircularProgressIndicator()),
      ],
    );
  }

  Widget nothing() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.list_bullet_below_rectangle),
          Text("No transactions"),
        ],
      ),
    );
  }

  check() async {
    var con = await checkConnection(context);
    if (con == 'Connected') {
      var transactions = await getTransactions(context);
      print('CART: $transactions');
      if (transactions != null) {
        TransactionList.gettransactions = transactions;
        done = true;
        if (mounted) setState(() {});
      } else {
        done = true;
        if (mounted) setState(() {});
      }
    }
  }

  @override
  void initState() {
    check();
    super.initState();
  }
}