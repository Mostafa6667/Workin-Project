import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';



class userDetailView with ChangeNotifier {


  String _fname = '';
  String _lname = '';
  String _jobTitle = '';
  String _careerlevel = '';
  String _about = '';
  String _uni = '';
  int _yearsOfExperience = 0;
  String _educationLevel = '';
  String _major = '';
  int _yearOfGrad = 0;
  String _languages = '';
  String _languageLevel = '';
  String _skills = '';
  String _gpa = '';
  String _picture = '';
  List<String>skill=[];
  int _count=0;

  String get fname{
    return _fname;
  }
  String get lname{
    return _lname;
  }
  String get jobtitle{
    return _jobTitle;
  }
  String get careerlevel{
    return _careerlevel;
  }
  String get about{
    return _about;
  }
  String get uni{
    return _uni;
  }
  int get yearsofexperience{
    return _yearsOfExperience;
  }
  String get educationlevel{
    return _educationLevel;
  }
  String get major{
    return _major;
  }
  int get yearofgrad{
    return _yearOfGrad;
  }
  int get count{
    return _count;
  }
  String get languages{
    return _languages;
  }
  String get languagelevel{
    return _languageLevel;
  }
  String get skills{
    return _skills;
  }
  String get gpa{
    return _gpa;
  }
  String get picture{
    return _picture;
  }


  Future<void> fetchUserDetails(String mail) async {
    final url = 'https://workinn.herokuapp.com/api/account/user_detail/${mail}'; //ahmed.yasser32@gmail.com
    try{
      final res=await(http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      ));
      final responsedata=json.decode(res.body);
      print(responsedata);
      _fname = responsedata['firstname'];
      print(_fname);
      _lname = responsedata['lastname'];
      print(_lname);
      _jobTitle=responsedata['job_title_looking_for'];
      print(_jobTitle);
      _careerlevel = responsedata['career_level'];
      print(_careerlevel);
      _about=responsedata['about'];
      print(_about);
      _uni=responsedata['uni'];
      print(_uni);
      _yearsOfExperience=responsedata['years_of_experience'];
       print(_yearsOfExperience);
      _educationLevel=responsedata['education_level'];
      print(_educationLevel);
      _major=responsedata['study_fields'];
      print(_major);
      _yearOfGrad=responsedata['yearofgrad'];
      print(_yearOfGrad);
      _languages=responsedata['languages'];
      print(_languages);
      _languageLevel=responsedata['language_level'];
      print(_languageLevel);
      _gpa=responsedata['gpa'];
      print(_gpa);
      _skills=responsedata['skills'];
      skill=skills.split(",");
      _count=skill.length;
      print(skill);
      _picture=responsedata['picture'];
      print(_picture);
    }catch(e){
      print(e);
      notifyListeners();
    }
  }

}