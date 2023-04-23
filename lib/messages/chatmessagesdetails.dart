import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rider_cc/screens/history.dart';
import 'package:rider_cc/screens/menu.dart';
import 'package:rider_cc/services/api.dart';
import 'package:rider_cc/services/apichat.dart';
import 'package:rider_cc/timer/session.dart';
import 'package:rider_cc/variables/GlobalVars.dart';
import 'package:rider_cc/variables/branding_color.dart';


class ChatMessagesDetail extends StatefulWidget {
  // final String sender;
  // final String refno;
  // final String active;
  const ChatMessagesDetail({Key? key}) : super(key: key);

  @override
  _ChatMessagesDetailState createState() => _ChatMessagesDetailState();
}

class _ChatMessagesDetailState extends State<ChatMessagesDetail> {
  final msgController = TextEditingController();
  bool sending = false;
  final _snackbarCopiedtoClipboard = SnackBar(
    duration: Duration(milliseconds: 500),
    content: Text('Copied to clipboard.'),
    behavior: SnackBarBehavior.floating,
  );

  @override
  void initState() {
    super.initState();
    GlobalVars.replyHolder = '';
  }

  @override
  void dispose() {
    super.dispose();
    msgController.dispose();
  }

  Sessiontimer sessionTimer = Sessiontimer();
  void handleUserInteraction([_]) {
    sessionTimer.initializeTimer(context);
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
            backgroundColor: Colors.white,
            titleSpacing: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () =>
                  // Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => Menu())),
            ),
            title: Text("Rider's Name [Rider]", //[${History.getTrans_no}]
                style: TextStyle(color: Colors.blueGrey[900])),
          ),
          body: Center(
            child: StreamBuilder<List>(
              stream: getChatHeadDetails(Duration(seconds: 1), 'trans_no'),
              builder: (context, stream) {
              //  print('STREAM: ${stream.data}');
                if (stream.connectionState == ConnectionState.done) {
                  return Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 20,
                  );
                }
                if (stream.hasData) {
                  return Column(
                    children: [
                      Expanded(
                        child: Scrollbar(
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                            onNotification: (overscroll) {
                              overscroll.disallowIndicator();
                              return false;
                            },
                            child: ListView(
                              reverse: true,
                              children: List.generate(
                                stream.data!.length,
                                    (index) {
                                  // GlobalVariables.isMsgActive =
                                  //     stream.data![index].seen;
                                  return InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onLongPress: () {
                                      Clipboard.setData(ClipboardData(
                                          text: stream.data![index].msgbody));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                          _snackbarCopiedtoClipboard);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          right: 8.0,
                                          top: 15.0,
                                          bottom: 8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                            stream.data![index].sender ==
                                                'customer'
                                                ? MainAxisAlignment.end
                                                : MainAxisAlignment.start,
                                            children: [
                                              stream.data![index].sender ==
                                                  'rider'
                                                  ? Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Icon(
                                                  CupertinoIcons
                                                      .person_alt,
                                                  color: stream
                                                      .data![
                                                  index]
                                                      .sender ==
                                                      'rider'
                                                      ? Colors.blue[200]
                                                      : Colors
                                                      .orange[200],
                                                ),
                                              )
                                                  : Icon(
                                                CupertinoIcons.person_alt,
                                                color: Colors.transparent,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment: stream
                                                      .data![index]
                                                      .sender ==
                                                      'customer'
                                                      ? CrossAxisAlignment.end
                                                      : CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        '${stream.data![index].sender == 'customer' ? 'YOU' : stream.data![index].sender.toString().toUpperCase()}: ${DateFormat("MMM dd, yyyy hh:mm a").format(DateTime.parse(stream.data![index].msgdatetime))}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize:
                                                            ScreenUtil()
                                                                .setSp(8),
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: stream
                                                            .data![index].sender == 'customer'
                                                            ?  brandingColor //Colors.deepOrange[200]
                                                            : Colors
                                                            .blue[200],
                                                        borderRadius:
                                                            stream
                                                                .data![
                                                            index]
                                                                .sender ==
                                                                'rider'
                                                            ? BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(
                                                              20),
                                                          topRight: Radius
                                                              .circular(
                                                              20),
                                                          bottomRight:
                                                          Radius
                                                              .circular(
                                                              20),
                                                        )
                                                            : BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(
                                                              20),
                                                          topRight: Radius
                                                              .circular(
                                                              20),
                                                          bottomLeft: Radius
                                                              .circular(
                                                              20),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                        child: Text(
                                                          "${stream.data![index].msgbody}",
                                                          style: TextStyle(
                                                            fontSize:
                                                            ScreenUtil()
                                                                .setSp(14),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              stream.data![index].sender ==
                                                  'customer'
                                                  ? Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Icon(
                                                  CupertinoIcons
                                                      .person_alt,
                                                  color: brandingColor,
                                                  //Colors.deepOrange[200],
                                                ),
                                              )
                                                  : Icon(
                                                CupertinoIcons.person_alt,
                                                color: Colors.transparent,
                                              ),
                                            ],
                                          ),
                                          index < 1 &&
                                              GlobalVars
                                                  .replyHolder.isNotEmpty
                                              ? Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 8.0,
                                                top: 23.0,
                                                bottom: 8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          right: 8.0),
                                                      child: Icon(
                                                        CupertinoIcons
                                                            .person_alt,
                                                        color: Colors
                                                            .transparent,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        decoration:
                                                        BoxDecoration(
                                                           color: brandingColor,
                                                           //Colors
                                                          //     .deepOrange[
                                                          // 200],
                                                          borderRadius:
                                                          BorderRadius
                                                              .only(
                                                            topLeft: Radius
                                                                .circular(
                                                                20),
                                                            topRight: Radius
                                                                .circular(
                                                                20),
                                                            bottomLeft: Radius
                                                                .circular(
                                                                20),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(
                                                              8.0),
                                                          child: Text(
                                                              "${GlobalVars.replyHolder}"),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 8.0),
                                                      child: Icon(
                                                        CupertinoIcons
                                                            .circle,
                                                        size: 15,
                                                        color: Colors
                                                            .deepOrange[
                                                        200],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                              : SizedBox()
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      // widget.active == 'active'
                      //     ?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 100.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: NotificationListener<
                                        OverscrollIndicatorNotification>(
                                      onNotification: (overscroll) {
                                        overscroll.disallowIndicator();
                                        return false;
                                      },
                                      child: Scrollbar(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          reverse: true,
                                          child: TextFormField(
                                            controller: msgController,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Enter message',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: sending
                                          ? CircularProgressIndicator()
                                          : Icon(
                                        CupertinoIcons
                                            .paperplane_fill,
                                       //  Icons.send_rounded,
                                        size: size.height / 25,
                                        color: brandingColor,
                                      ),
                                    ),
                                    onTap: () async {
                                      sending = true;
                                      if (mounted) setState(() {});
                                      check();
                                      // if (GlobalVariables.isMsgActive ==
                                      //     'active') {
                                      //   if (msgController
                                      //       .text.isNotEmpty &&
                                      //       !sending) {
                                      //     sending = true;
                                      //     if (mounted) setState(() {});
                                      //     check();
                                      //   }
                                      // }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                          //: SizedBox(),
                    ],
                  );
                } else {
                  return
                  //   Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius:
                  //         BorderRadius.all(Radius.circular(5))),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: ConstrainedBox(
                  //         constraints: BoxConstraints(
                  //           maxHeight: 100.0,
                  //         ),
                  //         child: Row(
                  //           children: [
                  //             Expanded(
                  //               child: NotificationListener<
                  //                   OverscrollIndicatorNotification>(
                  //                 onNotification: (overscroll) {
                  //                   overscroll.disallowIndicator();
                  //                   return false;
                  //                 },
                  //                 child: Scrollbar(
                  //                   child: SingleChildScrollView(
                  //                     scrollDirection: Axis.vertical,
                  //                     reverse: true,
                  //                     child: TextFormField(
                  //                       controller: msgController,
                  //                       maxLines: null,
                  //                       decoration: InputDecoration(
                  //                         border: InputBorder.none,
                  //                         hintText: 'Reply here...',
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             // InkWell(
                  //             //   child: Padding(
                  //             //     padding: const EdgeInsets.all(8.0),
                  //             //     child: sending
                  //             //         ? CircularProgressIndicator()
                  //             //         : Icon(
                  //             //       CupertinoIcons
                  //             //           .paperplane_fill,
                  //             //       // Icons.send,
                  //             //       size: size.height / 25,
                  //             //       color:
                  //             //       Colors.deepOrange[200],
                  //             //     ),
                  //             //   ),
                  //             //   onTap: () async {
                  //             //     if (GlobalVariables.isMsgActive ==
                  //             //         'active') {
                  //             //       if (msgController
                  //             //           .text.isNotEmpty &&
                  //             //           !sending) {
                  //             //         sending = true;
                  //             //         if (mounted) setState(() {});
                  //             //         check();
                  //             //       }
                  //             //     } else {
                  //             //       customModal(
                  //             //           context,
                  //             //           Icon(
                  //             //               CupertinoIcons
                  //             //                   .exclamationmark_circle,
                  //             //               size: 50,
                  //             //               color: Colors.red),
                  //             //           Text(
                  //             //               "You can't reply to this group chat (Ref#:${widget.refno}) because it was already closed.",
                  //             //               textAlign:
                  //             //               TextAlign.center),
                  //             //           true,
                  //             //           Icon(
                  //             //             CupertinoIcons
                  //             //                 .checkmark_alt,
                  //             //             size: 25,
                  //             //             color: Colors.greenAccent,
                  //             //           ),
                  //             //           '',
                  //             //               () {});
                  //             //     }
                  //             //   },
                  //             // ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );
                  CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  check() async {
    var con = await checkConnection(context);
    if (con == 'Connected') {
      await insertChatReply(context, 'trans_no', msgController.text);
      GlobalVars.replyHolder = msgController.text;
      msgController.clear();
      sending = false;
      if (mounted) setState(() {});
    }
  }
}
