


import 'dart:convert';
import 'dart:async';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class homeView with ChangeNotifier {

  int _applicantscount=0;
  int _count=0;
  String _createdAt='';
  String _mail='';
  int _companyId=0;
  int _jobId=0;
  String _compname='';
  String _jobtype='';
  String _jobtitle='';
  String _logo='';
  String _location='';
  List<int>applicantcounts=[];
  List<int>compids=[];
  List<int>jobids=[];
  List<String>companame=[];
  List<String>jobtypes=[];
  List<String>jobtitles=[];
  List<String>logos=[];
  List<String>created=[];
  List<String>locations=[];
  List<String>mails=[];
  String theDate='';
  var parsedDate;
  int get count{
    return _count;
  }
  List<String> get jobtitle{
    return jobtitles;
  }
  List<String> get jobtype{
    return jobtypes;
  }
  List<String> get compname{
    return companame;
  }
  List<String> get logo{
    return logos;
  }
  List<String> get createdat{
    return created;
  }
  List<int> get applicantscount{
    return applicantcounts;
  }
  List<int> get compidis{
    return compids;
  }
  List<int> get jobidis{
    return jobids;
  }
  List<String> get location{
    return locations;
  }
  List<String> get mail{
    return mails;
  }




  Future<void> fetchhomeDetails(String cat,String car,String mail) async {
    final url = 'https://workinn.herokuapp.com/api/jobs/home_screen/?email=$mail&category=$cat&career_level=$car';
    try{
      final res=await(http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      ));
      final responsedata=json.decode(res.body);
      print(responsedata);
      List id =responsedata['jobs'];
      _count=id.length;
      print(_count);
      for(var i=0;i<id.length;i++){
        _createdAt=(responsedata['jobs'][i]['created_at']);
        parsedDate=DateTime.parse(_createdAt);
        theDate=Jiffy(parsedDate).fromNow();
        created.add(theDate);
        print(created);
        _applicantscount=(responsedata['jobs'][i]['applicantscount']);
        applicantcounts.add(_applicantscount);
        print(applicantcounts);
        _logo=(responsedata['jobs'][i]['logo']);
        logos.add(_logo);
        print(logos);
        _jobtype=(responsedata['jobs'][i]['job_type']);
        jobtypes.add(_jobtype);
        print(jobtypes);
        _jobtitle=(responsedata['jobs'][i]['job_title']);
        jobtitles.add(_jobtitle);
        print(jobtitles);
        _companyId=(responsedata['jobs'][i]['company']);
        compids.add(_companyId);
        print(compids);
        _jobId=(responsedata['jobs'][i]['id']);
        jobids.add(_jobId);
        print(jobids);
        _compname=(responsedata['jobs'][i]['name']);
        companame.add(_compname);
        print(companame);
        _location=(responsedata['jobs'][i]['location']);
        locations.add(_location);
        print(locations);
        _mail=(responsedata['jobs'][i]['company_email']);
        mails.add(_mail);
        print(mails);

      }

    }catch(e){
      print(e);
      notifyListeners();
    }
  }
  Future<void> deletelist()async{
    jobtitle.clear();
    jobtype.clear();
    compname.clear();
    logo.clear();
    createdat.clear();
    applicantscount.clear();
    compidis.clear();
    jobidis.clear();
    location.clear();
    mail.clear();
    notifyListeners();
  }

}

// import 'dart:convert';
// import 'dart:async';
// import 'package:jiffy/jiffy.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
//
//
// class homeView with ChangeNotifier {
//
//   int _applicantscount=0;
//   int _count=0;
//   String _createdAt='';
//   int _companyId=0;
//   int _jobId=0;
//   String _compname='';
//   String _jobtype='';
//   String _jobtitle='';
//   String _logo='';
//   List<int>applicantcounts=[];
//   List<int>compids=[];
//   List<int>jobids=[];
//   List<String>companame=[];
//   List<String>jobtypes=[];
//   List<String>jobtitles=[];
//   List<String>logos=[];
//   List<String>created=[];
//   String theDate='';
//   var parsedDate;
//   int get count{
//     return _count;
//   }
//   List<String> get jobtitle{
//     return jobtitles;
//   }
//   List<String> get jobtype{
//     return jobtypes;
//   }
//   List<String> get compname{
//     return companame;
//   }
//   List<String> get logo{
//     return logos;
//   }
//   List<String> get createdat{
//     return created;
//   }
//   List<int> get applicantscount{
//     return applicantcounts;
//   }
//   List<int> get compidis{
//     return compids;
//   }
//   List<int> get jobidis{
//     return jobids;
//   }
//
//
//
//
//   Future<void> fetchhomeDetails(String cat,String car,String mail) async {
//     final url = 'https://workinn.herokuapp.com/api/jobs/home_screen/?email=$mail&category=$cat&career_level=$car';
//     try{
//       final res=await(http.get(Uri.parse(url),headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       ));
//       final responsedata=json.decode(res.body);
//       print(responsedata);
//       List id =responsedata['jobs'];
//       _count=id.length;
//       print(_count);
//       for(var i=0;i<id.length;i++){
//         _createdAt=(responsedata['jobs'][i]['created_at']);
//         parsedDate=DateTime.parse(_createdAt);
//         theDate=Jiffy(parsedDate).fromNow();
//         created.add(theDate);
//         print(created);
//         _applicantscount=(responsedata['jobs'][i]['applicantscount']);
//         applicantcounts.add(_applicantscount);
//         print(applicantcounts);
//         _logo=(responsedata['jobs'][i]['logo']);
//         logos.add(_logo);
//         print(logos);
//         _jobtype=(responsedata['jobs'][i]['job_type']);
//         jobtypes.add(_jobtype);
//         print(jobtypes);
//         _jobtitle=(responsedata['jobs'][i]['job_title']);
//         jobtitles.add(_jobtitle);
//         print(jobtitles);
//         _companyId=(responsedata['jobs'][i]['company']);
//         compids.add(_companyId);
//         print(compids);
//         _jobId=(responsedata['jobs'][i]['id']);
//         jobids.add(_jobId);
//         print(jobids);
//         _compname=(responsedata['jobs'][i]['name']);
//         companame.add(_compname);
//         print(companame);
//       }
//
//     }catch(e){
//       print(e);
//       notifyListeners();
//     }
//   }
//   Future<void> deletelist()async{
//     jobtitle.clear();
//     jobtype.clear();
//     compname.clear();
//     logo.clear();
//     createdat.clear();
//     applicantscount.clear();
//     compidis.clear();
//     jobidis.clear();
//     // location.clear();
//     // mail.clear();
//     notifyListeners();
//   }
//
// }