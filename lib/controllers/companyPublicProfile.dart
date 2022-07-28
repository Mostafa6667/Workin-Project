import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class companyDetailView with ChangeNotifier {


  String _email = '';
  String _name = '';
  String _headquarter = '';
  String _compinfo = '';
  String _website = '';
  String _industry = '';
  String _location = '';
  String _type = '';
  String _size = '';
  int _founded = 0;
  String _logo = '';
  String _specialities = '';
  String? thelogo;
  int id=0;

  String get email{
    return _email;
  }
  String get name{
    return _name;
  }
  String get headquarter{
    return _headquarter;
  }
  String get compinfo{
    return _compinfo;
  }
  String get website{
    return _website;
  }
  String get industry{
    return _industry;
  }
  String get location{
    return _location;
  }
  String get type{
    return _type;
  }
  String get size{
    return _size;
  }
  String get founded{
    return _founded.toString();
  }
  String get logo{
    return _logo;
  }
  String get specialities{
    return _specialities;
  }

  Future<void> fetchDetails(String mail) async {
    final url = 'https://workinn.herokuapp.com/api/company/$mail';
    try{
      final res=await(http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      ));
      final responsedata=json.decode(res.body);
      print(responsedata);
      _email = responsedata['email'];
      print(_email);
      _name=responsedata['company_name'];
      print(_name);
      _headquarter=responsedata['headquarters'];
      print(_headquarter);
      _compinfo = responsedata['company_info'];
      print(_compinfo);
      _website=responsedata['website'];
      print(_website);
      _industry=responsedata['company_industries'];
      print(_industry);
      _location=responsedata['location'];
      print(_location);
      _type=responsedata['company_type'];
      print(_type);
      _size=responsedata['size_of_company'];
      print(_size);
      _founded=responsedata['founded_at'];
      print(_founded);
      _logo=responsedata['logo'];
      print(_logo);
      _specialities=responsedata['specialities'];
      print(_specialities);
    }catch(e){
      print(e);
      notifyListeners();
    }
  }
  Future<void>deletelogo()async{
    _logo='';
  }

}