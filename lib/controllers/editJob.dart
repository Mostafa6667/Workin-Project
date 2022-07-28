import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
//final url='https://workinn.herokuapp.com/api/jobs/create_job';

class Edit with ChangeNotifier{


  // String response='';
  // String get theResponse{
  //   return response;
  // }
  // {id: 92, logo: , job_title: junior, job_category: IT, job_type: fulltime, description: software development, requirements: -one
  // I/flutter (  728): -two
  // I/flutter (  728): -three, education_level: Bachelor, experience: 1-3, career_level: Junior, salary: , isConfidential: false,
  // created_at: 2022-06-01T20:35:41.363128Z, company: 102, response: Success}
  String token='';
  // String _job_title='';
  // String _Job_category='';
  int _id=0;
  String _description='';
  String _requirements='';
  String _education_level='';
  String _experience='';
  String _career_level='';
  String _salary='';
  String _jobTitle='';
  String _jobType='';
  String _jobCategory='';


  String get description{
    return _description;
  }
  String get careerlevel{
    return _career_level;
  }
  String get experience{
    return _experience;
  }
  String get education{
    return _education_level;
  }
  String get salary{
    return _salary;
  }
  String get requirements{
    return _requirements;
  }
  String get jobTitle{
    return _jobTitle;
  }
  String get jobType{
    return _jobType;
  }
  String get jobCategory{
    return _jobCategory;
  }
  int get id{
    return _id;
  }



  Future<void>fetchEditJob(int jobId)async{
    final prefs=await SharedPreferences.getInstance();
    token=prefs.getString('token')!;
    final url='https://workinn.herokuapp.com/api/jobs/create_job';

    try{
      final res=await(http.put(Uri.parse(url),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',


      },body: json.encode({
        'job_id':jobId,

      })));
      final responseData=json.decode(res.body);
      print(responseData);
      _description=responseData['description'];
      print(_description);
      _career_level=responseData['career_level'];
      print(_career_level);
      _experience=responseData['experience'];
      print(_experience);
      _education_level=responseData['education_level'];
      print(_education_level);
      _requirements=responseData['requirements'];
      print(_requirements);
      _salary=responseData['salary'];
      print(salary);
      _id=responseData['id'];
      print(_id);
      _jobTitle=responseData['job_title'];
      print(_jobTitle);
      _jobType=responseData['job_type'];
      print(_jobType);
      _jobCategory=responseData['job_category'];
      print("jopCategory:$_jobCategory");






    }catch(e){
      print(e);
      notifyListeners();
    }
  }
}