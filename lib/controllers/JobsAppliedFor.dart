import 'dart:convert';
import 'dart:async';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

// jobs: [{logo: https://res.cloudinary.com/djakrzmd0/image/upload/v1652985350/l5sl9lschw57g3348hcu.jpg,
// created_at: 2022-05-21T18:06:15.677763Z,
// applicantscount: 0,
// company: 54,
// name: workout,
// id: 69,
// job_type: Full-time,
// job_title: Junior Solution Developer}, {logo: https://res.cloudinary.com/djakrzmd0/image/upload/v1652985350/l5sl9lschw57g3348hcu.jpg, created_at: 2022-05-21T22:08:32.199693Z, applicantscount: 0, company: 54, name: workout, id: 83, job_type: Full-time, job_title: iOS Developer}], response: success}

class jobsAppliedForView with ChangeNotifier {



  // int _count=0;
  //
  //
  // int _applicantsCount = 0;
  // String _jobType = '';
  // String _companyName = '';
  // String _location = '';
  // String _JobTitle = '';
  // String _date="";
  // String _token='';
  //
  //
  //
  // List<int> applicantsCount=[];
  // List<String> jobType=[];
  // List<String> companyName=[];
  // List<String> locations=[];
  // List<String> JobTitle=[];
  // List<String> theDate=[];
  //
  // var parsedDate;
  //
  //
  // int get togetcount{
  //   return _count;
  // }
  //
  //
  //
  // List <int> get ToGetApplicantsCount{
  //   return applicantsCount;
  // }
  //
  // List <String> get ToGetJobType{
  //   return jobType;
  // }
  //
  //
  // List <String> get ToGetCompanyName{
  //   return companyName;
  // }
  //
  // List <String> get ToGetLocation{
  //   return locations;
  // }
  //
  // List <String> get ToGetJobTitle{
  //   return JobTitle;
  // }
  //
  // List <String> get ToGetDate{
  //   return theDate;
  // }

  int _count=0;
  String _token='';
  int _applicantsCount = 0;
  String _jobType = '';
  String _companyName = '';
  String _location = '';
  String _JobTitle = '';
  String _date="";
  String _mail='';



  List<int> applicantsCount=[];
  List<String> jobType=[];
  List<String> companyName=[];
  List<String> locations=[];
  List<String> JobTitle=[];
  List<String> theDate=[];
  List<String> mails=[];

  var parsedDate;


  int get togetcount{
    return _count;
  }



  List <int> get ToGetApplicantsCount{
    return applicantsCount;
  }

  List <String> get ToGetJobType{
    return jobType;
  }


  List <String> get ToGetCompanyName{
    return companyName;
  }

  List <String> get ToGetLocation{
    return locations;
  }

  List <String> get ToGetJobTitle{
    return JobTitle;
  }

  List <String> get ToGetDate{
    return theDate;
  }
  List <String> get ToGetmail{
    return mails;
  }




  Future<void> fetchJobsAppliedForView() async {
    final prefs=await SharedPreferences.getInstance();
    _token=prefs.getString('token')!;
    final url = 'https://workinn.herokuapp.com/api/jobs/user_jobs';
    try {
      final res = await(http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $_token',
      },
      ));
      final responsedata = json.decode(res.body);
      print(responsedata);

      List Applicants = responsedata['jobs'];
      _count = Applicants.length;
      print("count: ${_count}");


      for (var i = 0; i < Applicants.length; i++) {
        _applicantsCount = (responsedata["jobs"][i]['applicantscount']);
        applicantsCount.add(_applicantsCount);
        print("applicantsCount: ${applicantsCount}");

        _jobType = (responsedata["jobs"][i]['job_type']);
        jobType.add(_jobType);
        print("jobType: ${jobType}");

        _companyName = (responsedata["jobs"][i]['name']);
        companyName.add(_companyName);
        print("companyName: ${companyName}");

        // _location = (responsedata["jobs"][i]['location']);
        // locations.add(_location);
        // print("location: ${locations}");

        _JobTitle = (responsedata["jobs"][i]['job_title']);
        JobTitle.add(_JobTitle);
        print("job_title: ${JobTitle}");

        _date=(responsedata["jobs"][i]['created_at']);
        parsedDate=DateTime.parse(_date);
        theDate.add(Jiffy(parsedDate).fromNow());
        print("Date: ${theDate}");

        _mail=(responsedata['jobs'][i]['company_email']);
        mails.add(_mail);
        print(mails);


      }
    }catch(e){
      print(e);
      notifyListeners();
    }
  }

}