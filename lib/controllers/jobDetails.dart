

import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';



class jobDetailView with ChangeNotifier {



  String _jobTitle = '';
  String _jobType = '';
  String _jobDetails = '';
  String _jobRequirements = '';
  String _jobSalary = '';
  String _companyLogo = '';
  int _yearOfGrad = 0;
  List<String>skill=[];
  int _count=0;
  String _token='';



  String get jobtitle{
    return _jobTitle;
  }
  String get jobType{
    return _jobType;
  }
  String get jobDetail{
    return _jobDetails;
  }
  String get jobRequirements{
    return _jobRequirements;
  }
  String get jobSalary{
    return _jobSalary;
  }
  String get companyLogo{
    return _companyLogo;
  }

  int get yearofgrad{
    return _yearOfGrad;
  }
  int get count{
    return _count;
  }



  Future<void> fetchJobDetails() async {
    final url = 'https://workinn.herokuapp.com/api/jobs/job_detail/83';
    try{
      final res=await(http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      ));
      final responsedata=json.decode(res.body);
      print(responsedata);
      _jobType = responsedata['job_type'];
      print(_jobType);
      _jobTitle=responsedata['job_title'];
      print(_jobTitle);
      _jobDetails = responsedata['description'];
      print(_jobDetails);
      _jobRequirements=responsedata['requirements'];
      print(_jobRequirements);
      _jobSalary=responsedata['salary'];
      print(_jobSalary);
      _companyLogo=responsedata['logo'];
      print(_companyLogo);
      // _educationLevel=responsedata['education_level'];
      // print(_educationLevel);
      // _major=responsedata['study_fields'];
      // print(_major);
      // _yearOfGrad=responsedata['yearofgrad'];
      // print(_yearOfGrad);
      // _languages=responsedata['languages'];
      // print(_languages);
      // _languageLevel=responsedata['language_level'];
      // print(_languageLevel);
      // _gpa=responsedata['gpa'];
      // print(_gpa);
      // _skills=responsedata['skills'];
      // skill=skills.split(",");
      // _count=skill.length;
      // print(skill);
    }catch(e){
      print(e);
      notifyListeners();
    }
  }
  Future<void> applyJobDetails(int id) async {
    final prefs=await SharedPreferences.getInstance();
    _token=prefs.getString('token')!;
    final url = 'https://workinn.herokuapp.com/api/jobs/job_apply/$id';
    try {
      final res = await(http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token',
      },));
      final prefs= await SharedPreferences.getInstance();
      final responsedata = json.decode(res.body);
      prefs.setString('resdata', responsedata['response']);
      print(responsedata);

    } catch (e) {
      print(e);
    }
  }

}


















// import 'dart:convert';
// import 'dart:async';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:core';
//
//
//
// class jobDetailView with ChangeNotifier {
//
//
//
//   String _jobTitle = '';
//   String _jobType = '';
//   String _jobDetails = '';
//   String _jobRequirements = '';
//   String _jobSalary = '';
//   String _companyLogo = '';
//   int _yearOfGrad = 0;
//   List<String>skill=[];
//   int _count=0;
//
//
//
//   String get jobtitle{
//     return _jobTitle;
//   }
//   String get jobType{
//     return _jobType;
//   }
//   String get jobDetail{
//     return _jobDetails;
//   }
//   String get jobRequirements{
//     return _jobRequirements;
//   }
//   String get jobSalary{
//     return _jobSalary;
//   }
//   String get companyLogo{
//     return _companyLogo;
//   }
//
//   int get yearofgrad{
//     return _yearOfGrad;
//   }
//   int get count{
//     return _count;
//   }
//
//
//
//   Future<void> fetchJobDetails() async {
//     final url = 'https://workinn.herokuapp.com/api/jobs/job_detail/83';
//     try{
//       final res=await(http.get(Uri.parse(url),headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       ));
//       final responsedata=json.decode(res.body);
//       print(responsedata);
//       _jobType = responsedata['job_type'];
//        print(_jobType);
//        _jobTitle=responsedata['job_title'];
//        print(_jobTitle);
//        _jobDetails = responsedata['description'];
//        print(_jobDetails);
//        _jobRequirements=responsedata['requirements'];
//        print(_jobRequirements);
//       _jobSalary=responsedata['salary'];
//       print(_jobSalary);
//       _companyLogo=responsedata['logo'];
//       print(_companyLogo);
//       // _educationLevel=responsedata['education_level'];
//       // print(_educationLevel);
//       // _major=responsedata['study_fields'];
//       // print(_major);
//       // _yearOfGrad=responsedata['yearofgrad'];
//       // print(_yearOfGrad);
//       // _languages=responsedata['languages'];
//       // print(_languages);
//       // _languageLevel=responsedata['language_level'];
//       // print(_languageLevel);
//       // _gpa=responsedata['gpa'];
//       // print(_gpa);
//       // _skills=responsedata['skills'];
//       // skill=skills.split(",");
//       // _count=skill.length;
//       // print(skill);
//     }catch(e){
//       print(e);
//       notifyListeners();
//     }
//   }
//   Future<void> applyJobDetails() async {
//     final url = 'https://workinn.herokuapp.com/api/jobs/job_apply/83';
//     try {
//       final res = await(http.post(Uri.parse(url), headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Token e9b6d496fd681c631daac67f03d028b8115c761d',
//       },));
//       final prefs= await SharedPreferences.getInstance();
//       final responsedata = json.decode(res.body);
//       prefs.setString('resdata', responsedata['response']);
//       print(responsedata);
//
//     } catch (e) {
//       print(e);
//     }
//   }
//
// }