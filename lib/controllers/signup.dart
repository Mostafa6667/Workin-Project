// import 'dart:convert';
// import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//





import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Auth with ChangeNotifier {

  String token='';
  String error='';
  String get thetoken{
    return token;
  }

  // String _error='';
  // String get error{
  //   return _error;
  // }
  Future<void> SignUp(
      String email, String fName, String lName, String password) async {
    final url = 'https://workinn.herokuapp.com/api/account/register/';
    try{
      final res=await(http.post(Uri.parse(url),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },body: json.encode({
        'email':email,
        'firstname':fName,
        'lastname':lName,
        'password':password
      })));
      final prefs= await SharedPreferences.getInstance();
      prefs.setString('mail', email);
      final responsedata=json.decode(res.body);
      prefs.setString('resuserdata', responsedata['response']);
      print(responsedata);
      if(responsedata['response']!='success') {
        prefs.setString('usererror', responsedata['error_message']);
      }else {
        token = responsedata['token'];
        prefs.setString('token', responsedata['token']);
        prefs.setString('isCompany', responsedata['is_company'].toString());
      }

      // token=responsedata['token'];

    }catch(e){
      print(e);
    }
    notifyListeners();
  }

}















// import '../models/http_exception.dart';
//
// class Auth with ChangeNotifier {
//   String token='';
//   String get thetoken{
//     return token;
//   }
//   Future<void> SignUp(
//       String email, String fName, String lName, String password) async {
//     final url = 'https://workinn.herokuapp.com/api/account/register/';
//     try{
//       final res=await(http.post(Uri.parse(url),headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//       },body: json.encode({
//         'email':email,
//         'firstname':fName,
//         'lastname':lName,
//         'password':password,
//       })));
//       final prefs= await SharedPreferences.getInstance();
//       prefs.setString('mail', email);
//       final responsedata=json.decode(res.body);
//       prefs.setString('resuserdata', responsedata['response']);
//       print(responsedata);
//       token= responsedata['token'];
//       prefs.setString('token',responsedata['token']);
//       prefs.setString('isCompany',responsedata['is_company'].toString());
//
//       final errormessage=responsedata['error_message'];
//       prefs.setString('usererror',errormessage);
//
//     }catch(e){
//       print(e);
//     }
//   }
//
// }