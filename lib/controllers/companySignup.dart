
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class companyAuth with ChangeNotifier {
  bool isCompany=false;
  String mail='';
  String token='';
  String get Email{
    return mail;
  }
  bool get IsCompany{
    return isCompany;
  }
  String get thetoken{
    return token;
  }
  Future<void> companySignup(String email, String password) async {
    final url = 'https://workinn.herokuapp.com/api/company/register/';
    try {
      final res = await(http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }, body: json.encode({
        'email': email,
        'password': password
      })));
      final prefs= await SharedPreferences.getInstance();
      prefs.setString('mail', email);
      final responsedata=json.decode(res.body);
      prefs.setString('compresdata', responsedata['response']);
      print(responsedata);
      if(responsedata['response']!='Success') {
        prefs.setString('comperror', responsedata['error_message']);
      }else {
        // token = responsedata['token'];
        prefs.setString('token',responsedata['token']);

        prefs.setString('isCompany', responsedata['is_company'].toString());
      }


    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

}


// import 'dart:convert';
// import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class companyAuth with ChangeNotifier {
//   bool isCompany=false;
//   String mail='';
//   String? token;
//   String get Email{
//     return mail;
//   }
//   bool get IsCompany{
//     return isCompany;
//   }
//   Future<void> companySignup(String email, String password) async {
//     final url = 'https://workinn.herokuapp.com/api/company/register/';
//     try {
//       final res = await(http.post(Uri.parse(url), headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//       }, body: json.encode({
//         'email': email,
//         'password': password
//       })));
//       final prefs= await SharedPreferences.getInstance();
//       prefs.setString('mail', email);
//       final responsedata = json.decode(res.body);
//       prefs.setString('resdata', responsedata['response']);
//       print(responsedata);
//
//       mail=responsedata.jsonDecode['email'];
//       isCompany=responsedata.jsonDecode['is_company'];
//       prefs.setString('isCompany', responsedata.jsonDecode['is_company'].toString());
//       prefs.setString('token', responsedata.jsonDecode['token']);
//
//       String nothing='';
//       final errormessage=responsedata['error_message'];
//
//       prefs.setString('noerror',nothing);
//
//       prefs.setString('error',errormessage);
//
//     } catch (e) {
//       print(e);
//     }
//   }
//
// }