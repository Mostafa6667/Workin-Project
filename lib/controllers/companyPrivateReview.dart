import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class companyReviews with ChangeNotifier {



  int _rating=0;
  int _count=0;
  String _review='';
  String _date='';
  String _user='';
  List<double>rates=[];
  List<String>users=[];
  List<String>dates=[];
  List<String>reviews=[];
  int get count{
    return _count;
  }
  List<String> get user{
    return users;
  }
  List<String> get date{
    return dates;
  }
  List<double> get rate{
    return rates;

  }
  List<String> get review{
    return reviews;
  }




  Future<dynamic> fetchReviews(String mail) async {
    final url = 'https://workinn.herokuapp.com/api/company/show_reviews/$mail';
    try {
      final res = await(http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      ));

      final responsedata = json.decode(res.body);
      print(responsedata);
      List id =responsedata['reviews'];
      _count=id.length;
      print(_count.toString());
      for(var i=0;i<id.length;i++){
        _user=(responsedata['reviews'][i]['user']);
        users.add(_user);
        print(users);
        _date=(responsedata['reviews'][i]['date']);
        dates.add(_date);
        print(dates);
        _rating=(responsedata['reviews'][i]['rating']);
        rates.add(_rating.toDouble());
        print(rates);
        _review=(responsedata['reviews'][i]['review']);
        reviews.add(_review);
        print(reviews);

      }



    } catch (e) {
      print(e);
      notifyListeners();
    }
  }
  Future<void>delete()async{
    users.clear();
    dates.clear();
    rates.clear();
    reviews.clear();
  }
}