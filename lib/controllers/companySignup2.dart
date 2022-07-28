import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workin_servive/models/http_exception.dart';
class companyAuth2 with ChangeNotifier {
  Future<void> companySignup2(String email,String fname, String lname ,String title , String mobNumm ,String compName) async {
    final url = 'https://workinn.herokuapp.com/api/company/register/2';
    try {
      final res = await(http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      }, body: json.encode({
        'email':email,
        'firstname': fname,
        'lastname':lname,
        'job_title':title,
        'mobile_number':mobNumm,
        'company_name':compName,
      })));
      final prefs=await SharedPreferences.getInstance();
      final responsedata = json.decode(res.body);
      prefs.setString('rescompdata', responsedata['response']);
      print(responsedata);
      final errormessage=responsedata['error_message'];
      prefs.setString('comperror',errormessage);


    } catch (e) {
      print(e);
    }
  }
}