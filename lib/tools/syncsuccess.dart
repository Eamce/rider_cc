import 'package:flutter/material.dart';
import 'package:rider_cc/login/login.dart';
import 'package:rider_cc/tools/elevated_button.dart';
import 'package:rider_cc/variables/branding_color.dart';

class UpdatedSuccessfully extends StatefulWidget {
  @override
  _UpdatedSuccessfullyState createState() => _UpdatedSuccessfullyState();
}

class _UpdatedSuccessfullyState extends State<UpdatedSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          // color: Colors.grey,
          padding: EdgeInsets.only(top: 20, bottom: 10, right: 5, left: 5),
          // margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Colors.grey[50],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 5),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // color: Colors.grey,
                            width: MediaQuery.of(context).size.width / 2,
                            margin: EdgeInsets.only(left: 10),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                    size: 72,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Registered Successfully!',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('Click ok to log in',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // color: Colors.grey,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: raisedButtonStyleWhite,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return LoginScreen();
                          }));
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(color: brandingColor),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
