import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Utils {
  static StreamTransformer transformer<T>(
          T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final users = snaps.map((json) => fromJson(json)).toList();

          sink.add(users);
        },
      );

  static DateTime toDateTime(Timestamp value) {
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static dynamic fromDateTimeToText(DateTime date) {
    if (date == null) return null;
    return DateFormat('jm').format(date);
    // return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  static dynamic lastMessageDateTime(DateTime date) {
    if (date == null) return null;
    DateFormat formatted = new DateFormat('M/d/y');
    if(formatted.format(date) == formatted.format(DateTime.now())){
      return DateFormat('jm').format(date);
    }
    return formatted.format(date);
  }
}
