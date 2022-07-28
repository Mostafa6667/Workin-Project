import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

// {users: [{email: mostafa@mahmoud.com,
// firstname: mostafa,
// lastname: ux,
// picture: ,
// location: Egypt, Cairo,
// job_title_looking_for: UI/UX designer,
// score: 55}, {email: ana@aho.shok, firstname: ana, lastname: aho, picture: https://res.cloudinary.com/djakrzmd0/image/upload/v1653691169/lykamrmivvuuvkifnz6o.png, location: Egypt, Cairo, job_title_looking_for: Flutter developer, score: 50}, {email: ahmed.yasser32@gmail.com, firstname: Ahmed, lastname: Yasser, picture: , location: Egypt, Cairo, job_title_looking_for: flutter developer, score: 50}, {email: m@e.com, firstname: firstname, lastname: lastname, picture: https://res.cloudinary.com/djakrzmd0/image/upload/v1653688062/e9twlnrklpup9tbtuxr1.png, location: a, a, job_title_looking_for: it, score: 45}], response: success}



// {users: [{email: mostafa@mahmoud.com,
// firstname: mostafa,
// lastname: ux,
// picture: ,
// location: Egypt, Cairo,
// job_title_looking_for: UI/UX designer,
// score: 55}, {email: ana@aho.shok, firstname: ana, lastname: aho, picture: https://res.cloudinary.com/djakrzmd0/image/upload/v1653691169/lykamrmivvuuvkifnz6o.png, location: Egypt, Cairo, job_title_looking_for: Flutter developer, score: 50}, {email: ahmed.yasser32@gmail.com, firstname: Ahmed, lastname: Yasser, picture: , location: Egypt, Cairo, job_title_looking_for: flutter developer, score: 50}, {email: m@e.com, firstname: firstname, lastname: lastname, picture: https://res.cloudinary.com/djakrzmd0/image/upload/v1653688062/e9twlnrklpup9tbtuxr1.png, location: a, a, job_title_looking_for: it, score: 45}], response: success}

class InviteUserView with ChangeNotifier {



  int _count=0;
  String _companyLogo = '';
  String _jobTitle = '';
  String _jobType = '';
  String _jobSalary = '';
  String _token='';
  String _firstName = '';
  String _lastName = '';
  String _picture = '';
  String _location = '';
  String _userJobTitle = '';
  String _email="";
  String _id='';
  List<String> firstNames=[];
  List<String> lastNames=[];
  List<String> pictures=[];
  List<String> locations=[];
  List<String> userJobTitles=[];
  List<String> email=[];





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
  int get count{
    return _count;
  }
  String get id{
    return _id;
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

  List <String> get ToGetEmail{
    return email;
  }



  Future<void> fetchInviteUsers(int id) async {
    final prefs=await SharedPreferences.getInstance();
    _token=prefs.getString('token')!;
    final url = 'https://workinn.herokuapp.com/api/jobs/recommended_users/$id';
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
      _id=responsedata['id'].toString();
      print(_id);



      List Applicants=responsedata['users'];
      _count=Applicants.length;
      print("count: $_count");
      for(var i=0; i<Applicants.length;i++) {
        _firstName = (responsedata["users"][i]['firstname']);
        firstNames.add(_firstName);
        print("FirstName: $firstNames");

        _lastName = (responsedata["users"][i]['lastname']);
        lastNames.add(_lastName);
        print("LastName: $lastNames");

        _picture = (responsedata["users"][i]['picture']);
        pictures.add(_picture);
        print("picture: $pictures");

        _location = (responsedata["users"][i]['location']);
        locations.add(_location);
        print("location: $locations");

        _userJobTitle =
        (responsedata["users"][i]['job_title_looking_for']);
        userJobTitles.add(_userJobTitle);
        print("job_title_looking_for: $userJobTitles");

        _email = (responsedata["users"][i]['email']);
        email.add(_email);
        print("User Email: $email");
      }

    }catch(e){
      print(e);
      notifyListeners();
    }
  }
  Future<void>delete()async{
    firstNames.clear();
    lastNames.clear();
    pictures.clear();
    locations.clear();
    userJobTitles.clear();
    email.clear();
  }




  Future<void> applyInviteUserDecision(String email,String operation,String id) async {
    final prefs=await SharedPreferences.getInstance();
    _token=prefs.getString('token')!;
    final url = 'https://workinn.herokuapp.com/api/jobs/SendEmail/';
    try {
      final res = await(http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token $_token',
        },body: jsonEncode(<String, String>{
          "job": id,
          "email": email,
          "operation": operation,
        }),
      ));
      print(_token);
      final prefs= await SharedPreferences.getInstance();
      final responsedata = json.decode(res.body);
      prefs.setString('resdata', responsedata['response']);
      print(responsedata);

    } catch (e) {
      print(e);
    }
  }


}





  Future<void> applyInviteUserDecision(String email,String operation) async {
    final url = 'https://workinn.herokuapp.com/api/jobs/SendEmail/';
    try {
      final res = await(http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token 5c203472acefae9867f59ccd33bdef83d3a6e340',
        },body: jsonEncode(<String, String>{
          "job": '83',
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

