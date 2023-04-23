import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rider_cc/models/CustomerOrder.dart';
import 'package:rider_cc/screens/menu.dart';
import 'package:rider_cc/services/api.dart';
import 'package:rider_cc/services/server.dart';
import 'package:rider_cc/variables/branding_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rider_cc/variables/stringExtension.dart';
class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}
class _OrderDetailsState extends State<OrderDetails> {
  bool? connectionChecking;
  String? connectionChecingStatus;
  bool done = false;
  int noOfItems = 0;
  bool updating = false;
  NumberFormat nF = NumberFormat.currency(locale: 'en', symbol: '₱ ');
  final ButtonStyle style = ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 11.0));
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async =>false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: brandingColor,
          titleSpacing: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
           onPressed: (){
             Navigator.pop(context);
             Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()),);
           },
          ),
          title: Text("List of Orders",
              style: TextStyle(color: Colors.white)),
        ),
      body: SafeArea(
        child: Column(
          children: [
            done ? CustomerOrder.customerOrders.length> 0
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
                    itemCount: CustomerOrder.customerOrders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 3.0, right: 3.0, top: 3.0),
                        child: Container(
                          color: Colors.white10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: size.height / 10,
                                width: size.height / 10,
                                color: Colors.white10,
                                child: CachedNetworkImage(
                                  imageUrl: Server.image_url +
                                      CustomerOrder.customerOrders[index]['product_image'],
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error,
                                          color: Colors.grey[200]),
                                ),
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
                                            CustomerOrder.customerOrders[index]['users_username'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                            CustomerOrder.customerOrders[index]['users_address'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text( 'Quantity: '+
                                            CustomerOrder.customerOrders[index]['users_mobile'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text('Total Amount: '
                                            '${CustomerOrder.customerOrders[index]['total_amt'].toString().toCurrencyFormat}',
                                            style: TextStyle(color: brandingColor),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                             // Spacer(),
                              ElevatedButton(
                                style: style,
                                onPressed: () {
                                },
                                  child: Text('Accept Order'),
                              // child:  Icon(CupertinoIcons.check_mark),
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

      ),
      ) ,
    );

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
          Text("No orders to take"),
        ],
      ),
    );
  }

  check() async {
    var con = await checkConnection(context);
    if (con == 'Connected') {
      var orderDetails = await getCustomerOrder(context);
      print('CART: $orderDetails');
      if (orderDetails != null) {
        CustomerOrder.customerOrders = orderDetails;
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