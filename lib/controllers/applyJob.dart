
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;

class jobApply with ChangeNotifier{
  // {id: 95, logo: , job_title: junior, job_category: IT, job_type: fulltime,
  // description: Software development, requirements: -senior
  // I/flutter ( 9368): -developer, education_level: Bachelor, experience: 4-6, career_level: Junior,
  // salary: 18000EGP/Month,
  // isConfidential: false, created_at: 2022-06-01T20:52:07.740527Z, company: 102, response: success}


  String response='';
  String _jobtitle='';
  String _jobcategory='';
  String _jobtype='';
  String _description='';
  String _requirements='';
  String _education='';
  String _experience='';
  String _careerLevel='';
  String _salary='';
  String _createdAt='';
  String _logo='';
  String _mail='';
  int id=0;

  String get theResponse{
    return response;
  }
  String get title{
    return _jobtitle;
  }
  String get type{
    return _jobtype;
  }
  String get category{
    return _jobcategory;
  }
  String get description{
    return _description;
  }
  String get requirements{
    return _requirements;
  }
  String get education{
    return _education;
  }
  String get experience{
    return _experience;
  }
  String get careerLevel{
    return _careerLevel;
  }
  String get createdAt{
    return _createdAt;
  }
  String get salary{
    return _salary;
  }
  String get logo{
    return _logo;
  }
  String get mail{
    return _mail;
  }


  Future<void>See(int jobId)async{
    final url='https://workinn.herokuapp.com/api/jobs/job_detail/$jobId';
    try{
      final res=await(http.get(Uri.parse(url),headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },));
      final responseData=json.decode(res.body);
      print(responseData);
      response=responseData['response'];
      print(response);
      _jobtitle=responseData['job_title'];
      print(_jobtitle);
      _jobtype=responseData['job_type'];
      print(_jobtype);
      _jobcategory=responseData['job_category'];
      print(_jobcategory);
      _description=responseData['description'];
      print(_description);
      _requirements=responseData['requirements'];
      print(_requirements);
      _education=responseData['education_level'];
      print(_education);
      _experience=responseData['experience'];
      print(_experience);
      _careerLevel=responseData['career_level'];
      print(_careerLevel);
      _salary=responseData['salary'];
      print(_salary);
      _logo=responseData['logo'];
      print(_logo);
      _mail=responseData['company_email'];
      print(_mail);


    }catch(e){
      print(e);
      notifyListeners();
    }
  }
}












// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart'as http;
//
// class jobAplly with ChangeNotifier{
//
//
//   String response='';
//   String get theResponse{
//     return response;
//   }
//
//
//
//   Future<void>postApply(int jobId)async{
//     final url='https://workinn.herokuapp.com/api/jobs/job_apply/${jobId}';
//     try{
//       final res=await(http.post(Uri.parse(url),headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Token e9b6d496fd681c631daac67f03d028b8115c761d',
//       },));
//       final responseData=json.decode(res.body);
//       print(responseData);
//       response=responseData['response'];
//       print(response);
//
//     }catch(e){
//       print(e);
//       // notifyListeners();
//     }
//   }
// }
