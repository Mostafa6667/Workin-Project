import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:jiffy/jiffy.dart';

// {id: 69, applicants: [{email: ana@aho.shok,
// firstname: ana,
// lastname: aho,
// applied_at: 2022-05-27T20:03:00.346943Z,
// picture: ,
// location: Egypt, Cairo,
// job_title_looking_for: Flutter developer
// }, {email: m@e.com, firstname: firstname, lastname: lastname, applied_at: 2022-05-27T20:31:04.899330Z, picture: , location: a, a, job_title_looking_for: it}], logo: https://res.cloudinary.com/djakrzmd0/image/upload/v1652985350/l5sl9lschw57g3348hcu.jpg, job_title: Junior Solution Developer, job_category: IT, job_type: Full-time, education_level: graduate, experience: 1, career_level: Junior, salary: Confidential salary, isConfidential: true, created_at: 2022-05-21T18:06:15.677763Z, applicantscount: 0, company: 54, response: success}


class AppliedUserView with ChangeNotifier {


  String _companyLogo = '';
  String _jobTitle = '';
  String _jobType = '';
  String _jobSalary = '';
  String _applicantsCount = '';
  int _count=0;
  int _id=0;
  String _token='';
  String _firstName = '';
  String _lastName = '';
  String _picture = '';
  String _location = '';
  String _userJobTitle = '';
  String _date="";
  String _email="";
  List<String> firstNames=[];
  List<String> lastNames=[];
  List<String> pictures=[];
  List<String> locations=[];
  List<String> userJobTitles=[];
  List<String> theDate=[];
  List<String> email=[];
  var parsedDate;







  String get companyLogo{
    return _companyLogo;
  }
  String get jobtitle{
    return _jobTitle;
  }
  String get jobType{
    return _jobType;
  }
  String get jobSalary{
    return _jobSalary;
  }
  String get applicantsCount{
    return _applicantsCount;
  }

  int get count{
    return _count;
  }

  String get ToGetids{
    return _id.toString();
  }



  List <String> get ToGetFirstName{
    return firstNames;
  }

  List <String> get ToGetLastName{
    return lastNames;
  }

  List <String> get ToGetPicture{
    return pictures;
  }

  List <String> get ToGetLocation{
    return locations;
  }

  List <String> get ToGetuserJobTitle{
    return userJobTitles;
  }

  List <String> get ToGetDate{
    return theDate;
  }

  List <String> get ToGetEmail{
    return email;
  }



  Future<void> fetchAppliedUsers(int id) async {
    final prefs=await SharedPreferences.getInstance();
    _token=prefs.getString('token')!;
    final url = 'https://workinn.herokuapp.com/api/jobs/company_job_detail/$id';
    try{
      final res=await(http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token',
      },
      ));
      final responsedata=json.decode(res.body);
      print(responsedata);
      _companyLogo=responsedata['logo'];
      print(_companyLogo);
      _jobTitle=responsedata['job_title'];
      print(_jobTitle);
      _jobType = responsedata['job_type'];
      print(_jobType);
      _jobSalary=responsedata['salary'];
      print(_jobSalary);
      _applicantsCount = responsedata['applicantscount'].toString();
      print(_applicantsCount);
      _id=responsedata['id'];
      print(_id);


      List Applicants=responsedata['applicants'];
      _count=Applicants.length;
      print("The Date: $theDate");
      print("count: $_count");
      for(var i=0; i<Applicants.length;i++){
        _firstName=(responsedata["applicants"][i]['firstname']);
        firstNames.add(_firstName);
        print("FirstName: $firstNames");

        _lastName=(responsedata["applicants"][i]['lastname']);
        lastNames.add(_lastName);
        print("LastName: $lastNames");

        _picture=(responsedata["applicants"][i]['picture']);
        pictures.add(_picture);
        print("picture: $pictures");

        _location=(responsedata["applicants"][i]['location']);
        locations.add(_location);
        print("location: $locations");

        _userJobTitle=(responsedata["applicants"][i]['job_title_looking_for']);
        userJobTitles.add(_userJobTitle);
        print("job_title_looking_for: $userJobTitles");

        _date=(responsedata["applicants"][i]['applied_at']);
        parsedDate=DateTime.parse(_date);
        theDate.add(Jiffy(parsedDate).fromNow());
        print("Date: $theDate");

        _email=(responsedata["applicants"][i]['email']);
        email.add(_email);
        print("User Email: $email");


      }

    }catch(e){
      print(e);
      notifyListeners();
    }
  }
  Future<void> applyAppliedUserDecision(String email,String operation,String id) async {
    final prefs=await SharedPreferences.getInstance();
    _token=prefs.getString('token')!;
    final url = 'https://workinn.herokuapp.com/api/jobs/SendEmail/';
    try {
      final res = await(http.post(Uri.parse(url),
        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token',
      },body: jsonEncode(<String, String>{
          "job": id.toString(),
          "email": email,
          "operation": operation,
        }),
      ));
      final prefs= await SharedPreferences.getInstance();
      final responsedata = json.decode(res.body);
      prefs.setString('resdata', responsedata['response']);
      print(responsedata);

    } catch (e) {
      print(e);
    }
  }

}