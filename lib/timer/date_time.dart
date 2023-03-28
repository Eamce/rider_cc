
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeValue{

    static List dateList = [];
    static List timeList = [];
    static List dateList2 = [];
    static int index = 0;

    static String dateSelected = '${DateFormat('EEEE, d MMM').format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))}';
    static String timeSelected = 'ASAP';
    static String dateDelivery = '';
}