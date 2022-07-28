
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

import '../Screens1/personalInfoScreen.dart';
import '../constants.dart';

import 'package:http/http.dart' as http;

class CvUploadScreen extends StatefulWidget {
  @override
  _CvUploadScreenState createState() => _CvUploadScreenState();
}


//respsnse body:{"file":"image/upload/v1655321067/nsmxo7chy6w1ipip8xqt.pdf","response":"Success","firstname":"Mohamed","lastname":"Shabana.","fullname":"Mohamed Salaheldin Mohamed Mohamed Shabana.","phone_number":"+201005305395","email":"mohamedsalaheldinshabana@gmail.com","birthdate":"1987-06-10","langauges":"Arabic","skills":["SQL (Programming Language)","Graphical User Interface","Entrepreneurship","Microsoft Windows","Operating Systems","Computer Hardware","Web Design","C (Programming Language)","User Interface","Military Services","PHP (Scripting Language)","Qualifications","Computer Systems","Teaching","Communication","Military Service","Python (Programming Language)","Java (Programming Language)","Communications","Actions","Social Media"],"university":"Cairo University (Faculty","education_level":"Bachelor","study_fields":"Computer Science","country":"Egypt","city":"Giza","job_titles":"Frontend Developer","fieldscompleted":15}


class _CvUploadScreenState extends State<CvUploadScreen> {



  //String email = 'hey@hey.adham';
  String? fileName;
  File? fileToDisplay;
  String state = "";


  bool _isloading = false;


  void _getFile() async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf', 'img'],
      type: FileType.custom,
    );
    if (result != null) {
      //A file has been selected
       PlatformFile file = result.files.single;
      setState(() {
        fileName = file.name;
      });
       final fileBytes = result.files.first.bytes;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
     var res = await Provider.of<postfile>(context,listen: false).trialuploadfile(file.path, 'https://workinn.herokuapp.com/api/account/upload_file?email=${prefs.getString('mail')}');
       setState(() {
         state = res!;
         print("Response:"+res);
       });
    }
    String ResponseState =Provider.of<postfile>(context,listen: false).responseState;
    print(ResponseState);
    if(ResponseState.toString()=="Success"){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => personalInfoScreen()),);
    }
  }
  @override
  Widget build(BuildContext context) {
    PlatformFile? file;
    File?fileToDisplay;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Upload CV',
            style: GoogleFonts.nunito(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Divider(color: Colors.black,),
          SizedBox(height: 18,),
          Text(
            'By uploading your CV you will',
            style: GoogleFonts.nunito(fontSize: 20, color: Colors.black),
          ),
          Text(
            'complete 20%~60% of your profile',
            style: GoogleFonts.nunito(fontSize: 20, color: Colors.black),
          ),
          SizedBox(height: 20,),
          MaterialButton(
            minWidth: 285,
            color: primarycolor,
            height: 50,
            onPressed: _getFile,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),

            ),
            child: Text(
                "Upload", style: GoogleFonts.nunito(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )
            ),

          ),
          SizedBox(height: 10,),
            Text('File Chosen:$fileName'),
          //Text('FileSelected:${fileName}'),
          SizedBox(height: 20,),
          Text(
            'supported files: .doc or .pdf , max 10MB',
            style: GoogleFonts.nunito(fontSize: 18, color: Colors.black26),
          ),
          Row(children: [
            SizedBox(width:MediaQuery.of(context).size.width * 0.75, ),
            FlatButton(
                highlightColor: backgroundcolor ,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => personalInfoScreen()),);
                },
                child:  Text("Skip",
                  textAlign: TextAlign.right,
                  style: GoogleFonts.nunito(fontSize: 16 , color: primarydarkcolor),
                )
            ),
          ],),

        ],
      ),
    );
  }




  /*Future<void> uploadFile(file) async {
    if (fileName!= null ) {
      setState(() {
        _isloading = true;
      });
      final String url =
          'https://workinn.herokuapp.com/api/account/upload_file?email=hey@hey.adham';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          //HttpHeaders.authorizationHeader:'hey@hey.adham',
        },
        body: json.encode({
          "file": file,
        }),
      );
      print(jsonDecode(response.body));
      setState(() {
        _isloading = false;
      });
      if (jsonDecode(response.body)['response'] == 'success') {
        print("the response is success");
        AlertDialog alert = AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('You successfully registered',
              style: TextStyle(
                  color: Theme.of(context).accentColor, fontSize: 18)),
          content: Container(
            height: 80,
            child: Column(
              children: <Widget>[
                Divider(color: Colors.white),
                SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Theme.of(context).accentColor,
                    child: Text('OK', style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        );
        return showDialog(
            context: context,
            builder: (context) {
              return alert;
            });
      }
      else if (jsonDecode(response.body)['response'] == 'error') {
        AlertDialog alert = AlertDialog(
          backgroundColor: Colors.white,
          title: Text('${jsonDecode(response.body)['error_message'] }',
              style: TextStyle(
                  color: Theme.of(context).accentColor, fontSize: 18)),
          content: Container(
            height: 80,
            child: Column(
              children: <Widget>[
                Divider(color: Colors.white),
                SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Theme.of(context).accentColor,
                    child: Text('OK', style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        );
        return showDialog(
            context: context,
            builder: (context) {
              return alert;
            });
      }
      else{
        AlertDialog alert = AlertDialog(
          backgroundColor: Colors.white,
          title: Text('nothing happened',
              style: TextStyle(
                  color: Theme.of(context).accentColor, fontSize: 18)),
          content: Container(
            height: 80,
            child: Column(
              children: <Widget>[
                Divider(color: Colors.white),
                SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Theme.of(context).accentColor,
                    child: Text('OK', style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        );
        return showDialog(
            context: context,
            builder: (context) {
              return alert;
            });
      }

    }
  }*/
}
class postfile with ChangeNotifier{

  String _responseState="";
  String _firstName="";
  String _lastName="";
  String _mobileNumber="";
  dynamic _birthDate="";
  dynamic _country="";
  dynamic _city="";
  dynamic _area="";
  dynamic _language="";
  dynamic _university="";
  dynamic _yearOfGrad="";
  dynamic _gpa="";
  dynamic _educationLevel="";
  dynamic _studyFields="";
  dynamic _jobTitle="";
  String _1stSkill="";
  String _2ndSkill="";
  String _3rdSkill="";
  String _4thSkill="";
  List<dynamic>_skillslist=[];
  List<dynamic>_skillslistfinished=[];





  String get responseState{
    return _responseState;
  }

  String get firstName {
    return _firstName;
  }
  String get lastName {
    return _lastName;
  }
  String get mobileNumber {
    return _mobileNumber;
  }
  String get birthDate {
    return _birthDate;
  }

  String get country {
    return _country;
  }
  String get city {
    return _city;
  }
  String get area {
    return _area;
  }

  String get language {
    return _language;
  }

  String get university {
    return _university;
  }

  String get yearOfGrad {
    return _yearOfGrad;
  }

  String get gpa {
    return _gpa;
  }

  String get educationLevel {
    return _educationLevel;
  }

  String get studyFields{
    return _studyFields;
  }

  String get jobTitle{
    return _jobTitle;
  }

  String get firstSkill {
    return _1stSkill;
  }
  String get secondSkill {
    return _2ndSkill;
  }
  String get thirdSkill {
    return _3rdSkill;
  }
  String get fourthSkill {
    return _4thSkill;
  }

  List<dynamic> get skillslistfinished {
    return _skillslistfinished;
  }

  Future<String?> trialuploadfile( theFilePath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', theFilePath));
    var res = await request.send();
    final respstr= await res.stream.bytesToString();
    print('respsnse body:'+respstr);
    var Response=json.decode(respstr);
    _responseState= Response["response"];
    print(_responseState);
    _firstName= Response["firstname"];
    print(_firstName);
    _lastName= Response["lastname"];
    print(_lastName);
    _mobileNumber= Response["phone_number"];
    print(_mobileNumber);

    // if (respstr.contains("birthdate")){
    // _birthDate= Response["birthdate"];
    // print(_birthDate);}else {_birthDate="";}

    if (respstr.contains("country")){
      _country= Response["country"];
      print(_country);}else {_country="";}

    if (respstr.contains("city")){
      _city= Response["city"];
      print(_city);}else {_city="";}

    if (respstr.contains("area")){
      _area= Response["area"];
      print(_area);}else {_area="";}

    if (respstr.contains("langauges")){
      _language= Response["langauges"];
      print(_language);}else {_language="";}

    if (respstr.contains("university")){
      _university= Response["university"];
      print(_university);}else {_university="";}

    if (respstr.contains("yearofgrad")){
      _yearOfGrad= Response["yearofgrad"];
      print(_yearOfGrad);}else {_yearOfGrad="";}

    if (respstr.contains("education_level")){
      _educationLevel= Response["education_level"];
      print(_educationLevel);}else {_educationLevel="";}

    if (respstr.contains("study_fields")){
      _studyFields= Response["study_fields"];
      print(_studyFields);}else {_studyFields="";}

    if (respstr.contains("job_titles")){
      _jobTitle= Response["job_titles"];
      print(_jobTitle);}else {_jobTitle="";}

    if (respstr.contains("gpa")){
      _gpa= Response["gpa"];
      print(_gpa);}else {_gpa="";}

    _skillslist=Response["skills"];
    for(int i=0;i<4;i++){
      print(_skillslist[i]);
      _skillslistfinished.add(_skillslist[i]);
      print(_skillslistfinished);
    }
    _1stSkill=_skillslistfinished[0].toString();
    _2ndSkill=_skillslistfinished[1].toString();
    _3rdSkill=_skillslistfinished[2].toString();
    _4thSkill=_skillslistfinished[3].toString();


    notifyListeners();
    return res.reasonPhrase;

  }
}

