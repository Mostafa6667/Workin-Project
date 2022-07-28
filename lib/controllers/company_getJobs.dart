import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';



class companyJobs with ChangeNotifier {
  int _count=0;
  String _location='';
  String _name='';
  String _createdAt='';
  int _applicants=0;
  int _id=0;
  String _jobtype='';
  String _jobtitle='';
  String thedate='';
  List<String>created=[];
  List<int>applicantscount=[];
  List<int>ids=[];
  List<String>jobtype=[];
  List<String>jobtitle=[];
  List<DateTime>date=[];
  var parsedDate;


  int get count{
    return _count;
  }
  String get companyName{
    return _name;
  }
  String get companylocation{
    return _location;
  }
  List<String> get createdat{
    return created;
  }
  List<int> get applicants{
    return applicantscount;
  }
  List<int> get idis{
    return ids;
  }
  List<String> get jobtypes{
    return jobtype;
  }
  List<String> get jobtitles{
    return jobtitle;
  }






  Future<dynamic> fetchjobs(String mail) async {
    final url = 'https://workinn.herokuapp.com/api/jobs/company_jobs/$mail';
    try {
      final res = await(http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      ));

      final responsedata = json.decode(res.body);
      print(responsedata);
      _name=responsedata['company_name'];
      print(_name);
      _location=responsedata['company_location'];
      print(_location);
      List id =responsedata['jobs'];
      _count=id.length;
      print(_count.toString());
      for(var i=0;i<id.length;i++){
        _createdAt=(responsedata['jobs'][i]['created_at']);
        parsedDate=DateTime.parse(_createdAt);
        thedate=Jiffy(parsedDate).fromNow();
        created.add(thedate);
        print(created);
        _applicants=(responsedata['jobs'][i]['applicantscount']);
        applicantscount.add(_applicants);
        print(applicantscount);
        _id=(responsedata['jobs'][i]['id']);
        ids.add(_id);
        print(ids);
        _jobtype=(responsedata['jobs'][i]['job_type']);
        jobtype.add(_jobtype);
        print(jobtype);
        _jobtitle=(responsedata['jobs'][i]['job_title']);
        jobtitle.add(_jobtitle);
        print(jobtitle);

      }



    } catch (e) {
      print(e);
      notifyListeners();
    }
  }
  Future<void>delete()async{
    created.clear();
    applicantscount.clear();
    ids.clear();
    jobtype.clear();
    jobtitle.clear();
  }
}