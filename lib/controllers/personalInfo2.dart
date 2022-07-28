import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class personalInfoAuth2 with ChangeNotifier {
  String response='';
  String error='';
  String get theresponse{
    return response;
  }
  String get theError{
    return error;
  }
  Future<void> personalInfo2(String email,String birthdate,String mobNumm,String gender, String nationality ,String country  ,String city,String area,) async {
    final url = 'https://workinn.herokuapp.com/api/account/user_profile_update/';
    try {
      final res = await(http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }, body: json.encode({
        'email':email,
        'birthdate':birthdate,
        'phone_number':mobNumm,
        'gender':gender,
        'nationality':nationality,
        'country':country,
        'city':city,
        'area':area,


      })));
      final responsedata = json.decode(res.body);
      print(responsedata);
      response=responsedata['response'];
      error=responsedata['error_message'];




    } catch (e) {
      print(e);
      notifyListeners();
    }
  }
}