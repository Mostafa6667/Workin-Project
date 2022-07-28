
//token=e9b6d496fd681c631daac67f03d028b8115c761d
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class companyCreateReview with ChangeNotifier {
  String token='';
  Future<void> addReview(String review,int rating,String mail) async {
    final prefs=await SharedPreferences.getInstance();
    token=prefs.getString('token')!;

    final url = 'https://workinn.herokuapp.com/api/company/review/$mail';
    try {
      final res = await(http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      }, body: json.encode({
        'rating':rating,
        'review':review,



      })));
      final responsedata = json.decode(res.body);
      print(responsedata);

    } catch (e) {
      print(e);
    }
  }
}














// //token=e9b6d496fd681c631daac67f03d028b8115c761d
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class companyCreateReview with ChangeNotifier {
//   Future<void> addReview(String review,int rating) async {
//     final url = 'https://workinn.herokuapp.com/api/company/review/ana@comp.doda';
//     try {
//       final res = await(http.post(Uri.parse(url), headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Token e9b6d496fd681c631daac67f03d028b8115c761d',
//       }, body: json.encode({
//         'rating':rating,
//         'review':review,
//
//
//
//       })));
//       final responsedata = json.decode(res.body);
//       print(responsedata);
//     } catch (e) {
//       print(e);
//     }
//   }
// }