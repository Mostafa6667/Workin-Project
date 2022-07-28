import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:workin_servive/constants.dart';

import '../Screens1/home_Screen.dart';
import '../Screens1/userPrivateProfile_Screen.dart';
import '../controllers/userPrivateInfo.dart';
import 'CVUploadScreen.dart';

class UserCompanyInfo extends StatefulWidget {
  @override
  _UserCompanyInfoState createState() => _UserCompanyInfoState();
}

class Skill {
  final String skillChoosen;

  const Skill(this.skillChoosen,);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Skill &&
              runtimeType == other.runtimeType &&
              skillChoosen == other.skillChoosen;

  @override
  int get hashCode => skillChoosen.hashCode;

  @override
  String toString() {
    return skillChoosen;
  }
}

class _UserCompanyInfoState extends State<UserCompanyInfo> {

  final GlobalKey<FormState> _formkey = GlobalKey();


  String? _CurrentEducationLevelSelectedValue;
  String? _FieldOfStudySelectedValue;
  String? _CareerLevelSelectedValue;
  String? _JobTypeInterestedSelectedValue;
  String? _JobCareersInterestedSelectedValue;
  String? _JobTitleLookingSelectedValue;
  String? _MinSalarySelectedValue;
  String? _LanguageSelectedValue;
  String? _ProficiencySelectedValue;



  List<String> listOfCurrentEducationLevel = ['Student', 'Bachelor', 'UnderGrad', 'Masters', 'PHD'];
  List<String> listOfFieldOfStudy = ['Computer Science', 'Engineering', 'Fine Arts', 'Arts',''];
  List<String> listOfCareerLevel = ['Student', 'EntryLevel', 'Junior', 'Senior', 'Management'];
  List<String> listOfJobTypeInterested = ['Full time', 'Half time', 'Internship', 'Shift based', 'Work from home','Volunteering'];
  List<String> listOfJobCareersInterested = ['Software Engineering', 'Architecture', 'Translation', 'Design','Marketing','Advertising'];
  //Note: the Api will get Job Title Looking For as a String
  List<String> listOfJobTitleLookingFor = ['Frontend Developer', 'Backend Developer', 'Graphic Designer ', 'UI/UX' ,'Script Translator', 'RealTime Translator',''];
  //Note: the Api willn't get Min Salary
  List<String> listOfMinSalary = ['EGP/Month'];
  List<String> listOfLanguages = ['Dutch', 'French', 'English', 'Arabic'];
  //Note: the Api will get LanguageLevel as a String
  List<String> listOfLanguageLevel = ['Good', 'V.Good', 'Excellent', 'Fluent'];
  List<dynamic> toGetSkills=[];

  dynamic get SkillsforApi{
    if(Provider.of<postfile>(context,listen: false).skillslistfinished.isEmpty){
      print("..................................................................>Skills List Finished is empty:${Provider.of<postfile>(context,listen: false).skillslistfinished}");
      return toGetSkills.join(',');
  }else{
      print("..................................................................>Skills List Finished isn't empty:${Provider.of<postfile>(context,listen: false).skillslistfinished}");
      toGetSkills.add(Provider.of<postfile>(context,listen: false).firstSkill);
      toGetSkills.add(Provider.of<postfile>(context,listen: false).secondSkill);
      toGetSkills.add(Provider.of<postfile>(context,listen: false).thirdSkill);
      toGetSkills.add(Provider.of<postfile>(context,listen: false).fourthSkill);
      return toGetSkills;

  }
}


  final controller = PageController();

  TextEditingController _gpa = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _university= TextEditingController();
  TextEditingController _yearOfGraduation= TextEditingController();
  TextEditingController _aboutInfo= TextEditingController();
  TextEditingController _yearsOfExperience= TextEditingController();

  late FocusNode _gpaFocusNode;
  late FocusNode _salaryControllerFocusNode;
  late FocusNode _universityFocusNode;
  late FocusNode _yearOfGraduationFocusNode;
  late FocusNode _aboutInfoFocusNode;
  late FocusNode _yearsOfExperienceFocusNode;



  @override
  void dispose(){
    controller.dispose();
    _gpa.dispose();
    _salaryController.dispose();
    _university.dispose();
    _yearOfGraduation.dispose();
    _aboutInfo.dispose();

    _gpaFocusNode.dispose();
    _salaryControllerFocusNode.dispose();
    _universityFocusNode.dispose();
    _yearOfGraduationFocusNode.dispose();
    _aboutInfoFocusNode.dispose();
    _yearsOfExperienceFocusNode.dispose();

    super.dispose();
  }
  var _textGPA='';
  var _textSalary='';
  var _textUniversity='';
  var _textYearOfGraduation='';
  var _textAboutInfo='';
  var _textyearsOfExperience='';



  @override
  void initState() {
     //set the initial value of text field
    _university.text=Provider.of<postfile>(context,listen: false).university==""?"":Provider.of<postfile>(context,listen: false).university;
    _yearOfGraduation.text=Provider.of<postfile>(context,listen: false).yearOfGrad==""?"":Provider.of<postfile>(context,listen: false).yearOfGrad;
    _gpa.text=Provider.of<postfile>(context,listen: false).gpa==""?"":Provider.of<postfile>(context,listen: false).gpa;
    _LanguageSelectedValue=Provider.of<postfile>(context,listen: false).language==""?"English":Provider.of<postfile>(context,listen: false).language;
    _CurrentEducationLevelSelectedValue=Provider.of<postfile>(context,listen: false).educationLevel==""?"Bachelor":Provider.of<postfile>(context,listen: false).educationLevel;
    _FieldOfStudySelectedValue=Provider.of<postfile>(context,listen: false).studyFields==""?'':Provider.of<postfile>(context,listen: false).studyFields;
    _JobTitleLookingSelectedValue=Provider.of<postfile>(context,listen: false).jobTitle==""?"":Provider.of<postfile>(context,listen: false).jobTitle;

    super.initState();
    _gpaFocusNode=FocusNode();
    _salaryControllerFocusNode=FocusNode();
    _universityFocusNode=FocusNode();
    _yearOfGraduationFocusNode=FocusNode();
    _aboutInfoFocusNode=FocusNode();
    _yearsOfExperienceFocusNode=FocusNode();


  }




  String? get _GPAValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _gpa.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }
  String? get _UniversityValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _university.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }
  String? get _YearOfGraduationValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _yearOfGraduation.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }
  String? get _YearsOfExperienceValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _yearsOfExperience.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }
  _salaryNumValidation(){
    if(RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$').hasMatch(_salaryController.text)){
      return false;
    }else{
      return true;
    }
  }





  Widget inputFile({label, obscureText = false , TextInputType , hintText, required TextEditingController controller,errorText,onChangedText,focusNode})
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color:Colors.black87
          ),

        ),
        SizedBox(height: 5,),
        TextField(
          focusNode: focusNode,
          controller: controller,
          keyboardType: TextInputType,
          obscureText: obscureText,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              errorText: errorText,
              errorStyle: focusNode.hasFocus?null:TextStyle(fontSize: 0, height: 0),
              hintText: hintText,
              hintStyle: GoogleFonts.nunito(fontSize: 18 ),
              contentPadding: EdgeInsets.symmetric(vertical: 0,
                  horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),

              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
              )
          ),
          onChanged: (label)=> setState(()=> onChangedText),
        ),
        SizedBox(height: 10,)
      ],
    );
  }

  Widget maxLineInputFile({label, obscureText = false , TextInputType , hintText, required TextEditingController controller,errorText,onChangedText,focusNode})
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color:Colors.black87
          ),

        ),
        SizedBox(height: 5,),
        SizedBox(
          height: 150,
          child: TextField(
            focusNode: focusNode,
            textAlignVertical: TextAlignVertical.top,
            expands: true,
            maxLines: null,
            maxLength: 300,
            controller: controller,
            keyboardType: TextInputType,
            obscureText: obscureText,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                errorText: errorText,
                errorStyle: focusNode.hasFocus?null:TextStyle(fontSize: 0, height: 0),
                hintText: hintText,
                hintStyle: GoogleFonts.nunito(fontSize: 18 ),
                hintMaxLines: 3,
                contentPadding: EdgeInsets.symmetric(vertical: 10,
                    horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black54,
                  ),

                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                )
            ),
            onChanged: (label)=> setState(()=> onChangedText),
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }


  @override
  Widget build(BuildContext context) {


    const mockResults = <Skill> [
      Skill('Problem solving'),
      Skill('Photoshop'),
      Skill('C++'),
      Skill('Python'),
      Skill('Software Development'),
      Skill('Software Engineering'),
      Skill('Java'),
      Skill('Problem Solving'),
      Skill('Machine Learning'),
      Skill('Android (Operating System)'),
      Skill('Writing'),
      Skill('Github'),
      Skill('Dynamic Web Pages'),
      Skill('Leadership'),
      Skill('Communication'),
      Skill('Entrepreneurship'),
      Skill('Graphical User Interface'),
      Skill('Computer Systems'),
      Skill('Teaching'),
    ];




    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Color(0xc4c4c4),
        centerTitle: true,
        title: Column(
            children:[
              Text("Career info ",
                style: GoogleFonts.nunito(fontSize: 30, fontWeight: FontWeight.bold , color: Colors.black),),
              Text(" These will help us to match you with your best opportunity",
                style: GoogleFonts.nunito(fontSize: 13, color: Colors.black,
                ),
              ),
            ]

        ),
        /*bottom: PreferredSize(
            child: Text("These information help candidates to know your company",
              style: GoogleFonts.nunito(),),
            preferredSize: null),*/

        /*flexibleSpace: FlexibleSpaceBar(
          title: Column(
            children: [

              SizedBox(
                height: 10,
              ),
              SizedBox(height: 40,),
              Text(
                "Company info",
                style: GoogleFonts.nunito(fontSize: 30, fontWeight: FontWeight.bold ),
              ),

              SizedBox(height: 5,),
              Text(
                "These information help candidates to know your company",
                style: GoogleFonts.nunito(fontSize: 15,),
              ),

            ],

          ),
        ),*/

      ) ,
      body: Form(
        key: _formkey,
        child:  Container(
         child:PageView(
          controller: controller,
          children: [
            //First Page
            Container(
              color: Color(0xc4c4c4),
              child: SingleChildScrollView(
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        children: [

                          Text(
                            'Current education level',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _CurrentEducationLevelSelectedValue,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled:true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: primarycolor)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primarycolor),
                                ),
                              ),
                              onChanged: (String? value) {
                                _CurrentEducationLevelSelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _CurrentEducationLevelSelectedValue=value!;
                              },
                              items: listOfCurrentEducationLevel.map((String val){
                                return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Field of study',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _FieldOfStudySelectedValue,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled:true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: primarycolor)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primarycolor),
                                ),
                              ),
                              onChanged: (String? value) {
                                _FieldOfStudySelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _FieldOfStudySelectedValue=value!;
                              },
                              items: listOfFieldOfStudy.map((String val){
                                return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                     /* Row(
                        children: [
                          Text(
                            'University',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _UniversitySelectedValue,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled:true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: primarycolor)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primarycolor),
                                ),
                              ),
                              onChanged: (String? value) {
                                _UniversitySelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _UniversitySelectedValue=value!;
                              },
                              items: listOfValue.map((String val){
                                return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),*/
                      inputFile(controller: _university,label: 'University',onChangedText: _textUniversity,focusNode: _universityFocusNode ),
                      SizedBox(height: 10,),
                      /*Row(
                        children: [
                          Text(
                            'Year of graduation',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _YearOfGraduationSelectedValue,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled:true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: primarycolor)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primarycolor),
                                ),
                              ),
                              onChanged: (String? value) {
                                _YearOfGraduationSelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _YearOfGraduationSelectedValue=value!;
                              },
                              items: listOfValue.map((String val){
                                return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),*/
                      inputFile(controller: _yearOfGraduation,label: 'Year of graduation',TextInputType: TextInputType.number,onChangedText: _textYearOfGraduation,focusNode: _yearOfGraduationFocusNode ),
                      SizedBox(height: 10,),
                      inputFile(label: "GPA",TextInputType: TextInputType.number ,controller: _gpa,errorText: _GPAValidation,onChangedText: _textGPA,focusNode: _gpaFocusNode ),
                      SizedBox(height: 10,),
                      inputFile(label: "Years of Experience",TextInputType: TextInputType.number ,controller: _yearsOfExperience,errorText: _YearsOfExperienceValidation,onChangedText: _textyearsOfExperience,focusNode: _yearsOfExperienceFocusNode ),
                      SizedBox(height: 20,),
                      SmoothPageIndicator (
                          controller:controller,
                          count:3
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Second Page
            Container(
              color: Color(0xc4c4c4),
              child: SingleChildScrollView(
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        children: [

                          Text(
                            'Career level',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _CareerLevelSelectedValue,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled:true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: primarycolor)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primarycolor),
                                ),
                              ),
                              onChanged: (String? value) {
                                _CareerLevelSelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _CareerLevelSelectedValue=value!;
                              },
                              items: listOfCareerLevel.map((String val){
                                return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Job Type interested in',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _JobTypeInterestedSelectedValue,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled:true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: primarycolor)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primarycolor),
                                ),
                              ),
                              onChanged: (String? value) {
                                _JobTypeInterestedSelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _JobTypeInterestedSelectedValue=value!;
                              },
                              items: listOfJobTypeInterested.map((String val){
                                return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Job Careers interested in ',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _JobCareersInterestedSelectedValue,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled:true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: primarycolor)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primarycolor),
                                ),
                              ),
                              onChanged: (String? value) {
                                _JobCareersInterestedSelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _JobCareersInterestedSelectedValue=value!;
                              },
                              items: listOfJobCareersInterested.map((String val){
                                return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Job Title Looking for',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _JobTitleLookingSelectedValue,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "can't empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled:true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: primarycolor)),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: primarycolor),
                                ),
                              ),
                              onChanged: (String? value) {
                                _JobTitleLookingSelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _JobTitleLookingSelectedValue=value!;
                              },
                              items: listOfJobTitleLookingFor.map((String val){
                                return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text('Min salary',style: GoogleFonts.nunito(fontSize: 18),),

                              Container(
                                width: MediaQuery.of(context).size.width*0.3,
                                height: 50,
                                child: TextFormField(

                                  keyboardType: TextInputType.number,
                                  controller: _salaryController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Type your min. salary';
                                    }else if(_salaryNumValidation()){
                                      return'only characters here';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: primarycolor)),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: primarycolor),
                                    ),
                                    hintStyle: GoogleFonts.nunito(fontSize: 18),
                                    hintText: '5000',
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.05,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 22,),
                              Container(
                                width: MediaQuery.of(context).size.width*0.49,
                                child: Row(
                                  children: [
                                    Container(width: 190,height: 55,
                                      child: DropdownButtonFormField(
                                        value: _MinSalarySelectedValue,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return "can't empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "EGP/Month",
                                          fillColor: Colors.white,
                                          filled:true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: primarycolor)),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(color: primarycolor),
                                          ),
                                        ),
                                        onChanged: (String? value) {
                                          _MinSalarySelectedValue=value!;
                                        },
                                        onSaved: (String? value) {
                                          _MinSalarySelectedValue=value!;
                                        },
                                        items: listOfMinSalary.map((String val){
                                          return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      SmoothPageIndicator (
                          controller:controller,
                          count:3
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ),

            //Thired Page
            Container(
              color: Color(0xc4c4c4),
              child: SingleChildScrollView(
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      ChipsInput(

                        decoration: InputDecoration(
                          labelText: "Skills",
                          labelStyle: GoogleFonts.nunito(fontSize: 18),


                        ),
              initialValue:[
              Skill("${Provider.of<postfile>(context,listen: false).firstSkill}"),
              Skill("${Provider.of<postfile>(context,listen: false).secondSkill}"),
              Skill("${Provider.of<postfile>(context,listen: false).thirdSkill}"),
              Skill("${Provider.of<postfile>(context,listen: false).fourthSkill}"),
              ] ,//Provider.of<postfile>(context,listen: false).skillslistfinished

                        maxChips: 5,
                        findSuggestions: (String query) {
                          if (query.length != 0) {
                            var lowercaseQuery = query.toLowerCase();
                            return mockResults.where((profile) {
                              return profile.skillChoosen.toLowerCase().contains(query.toLowerCase());
                            }).toList(growable: false)
                              ..sort((a, b) => a.skillChoosen
                                  .toLowerCase()
                                  .indexOf(lowercaseQuery)
                                  .compareTo(b.skillChoosen.toLowerCase().indexOf(lowercaseQuery)));
                          } else {
                            return const <Skill>[];
                          }
                        },
                        onChanged: (data) {
                         // data.add(Provider.of<postfile>(context,listen: false).skillslistfinished);
                          print("the data: $data");
                          //<..................................................................................................................................................>
                          toGetSkills=data;//Provider.of<postfile>(context,listen: false).skillslistfinished==null||Provider.of<postfile>(context,listen: false).skillslistfinished==[]?data:Provider.of<postfile>(context,listen: false).skillslistfinished
                          print("the list of Skills: $toGetSkills");
                          print("the String of Skills: ${toGetSkills.join(',')}");

                        },
                        chipBuilder: (context, state, dynamic profile) {
                          return InputChip(
                            key: ObjectKey(profile),
                            label: Text(profile.skillChoosen),
                            onDeleted: () => state.deleteChip(profile),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          );
                        },
                        suggestionBuilder: (context, state, dynamic profile) {
                          return ListTile(
                            key: ObjectKey(profile),
                            title: Text(profile.skillChoosen),
                            onTap: () => state.selectSuggestion(profile),
                          );
                        },
                      ),
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:[
                      Text('Language',style: GoogleFonts.nunito(fontSize: 18),),],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 22,),
                               Row(
                                  children: [
                                    Container(width: 150,height: 55,
                                      child: DropdownButtonFormField(
                                        value: _LanguageSelectedValue,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return "can't empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Language",
                                          fillColor: Colors.white,
                                          filled:true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: primarycolor)),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(color: primarycolor),
                                          ),
                                        ),
                                        onChanged: (String? value) {
                                          _LanguageSelectedValue=value!;
                                        },
                                        onSaved: (String? value) {
                                          _LanguageSelectedValue=value!;
                                        },
                                        items: listOfLanguages.map((String val){
                                          return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),

                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.06,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 22,),
                                Row(
                                  children: [
                                    Container(width: 170,height: 55,
                                      child: DropdownButtonFormField(
                                        value: _ProficiencySelectedValue,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return "can't empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Proficiency",
                                          fillColor: Colors.white,
                                          filled:true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: primarycolor)),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(color: primarycolor),
                                          ),
                                        ),
                                        onChanged: (String? value) {
                                          _ProficiencySelectedValue=value!;
                                        },
                                        onSaved: (String? value) {
                                          _ProficiencySelectedValue=value!;
                                        },
                                        items: listOfLanguageLevel.map((String val){
                                          return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      maxLineInputFile(label: "About" ,TextInputType: TextInputType.multiline , hintText:'Write your info & Email(optional)',controller: _aboutInfo,onChangedText: _textAboutInfo,focusNode: _aboutInfoFocusNode ),
                      SizedBox(height: 40,),
                      SmoothPageIndicator (
                          controller:controller,
                          count:3
                      ),
                      SizedBox(height: 15,),

                      MaterialButton(
                        minWidth: 285,
                        color: primarycolor,
                        height: 50,
                        onPressed: () async {
                          SharedPreferences prefs =await SharedPreferences.getInstance();
                          /* if (!_formkey.currentState!.validate()) {
                            return;
                          }
                          FocusScope.of(context).unfocus();
                          _formkey.currentState!.save();
                          //setState(() {
                            //_isLoading = true;
                          //});*/
                           await saveCareerInfo( prefs.getString('mail')!,_gpa.text, int.parse(_salaryController.text), _university.text, _yearOfGraduation.text,_aboutInfo.text ,_yearsOfExperience.text,_CurrentEducationLevelSelectedValue,_FieldOfStudySelectedValue,_CareerLevelSelectedValue,_JobTypeInterestedSelectedValue,_JobCareersInterestedSelectedValue,_JobTitleLookingSelectedValue,_LanguageSelectedValue,_ProficiencySelectedValue,SkillsforApi.toString());
                        },
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Text(
                            "Start your career", style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                        ),

                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),

    );
  }

  Future<void>fetchuserinfo(String email)async{

    await Provider.of<userDetailView>(context,listen: false).fetchUserDetails(email);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => userPrivateProfile()),);
  }

  Future<void> saveCareerInfo(String email,String gpa, int salaryController, String university, String yearOfGraduation,String aboutInfo ,String yearsOfExperience,currentEducationLevelSelectedValue,  fieldOfStudySelectedValue,  careerLevelSelectedValue,  jobTypeInterestedSelectedValue,  jobCareersInterestedSelectedValue,  jobTitleLookingSelectedValue,  languageSelectedValue,  proficiencySelectedValue, skills ) async {
    if (_GPAValidation == null  && _UniversityValidation == null && _YearOfGraduationValidation == null) {
      print("------> Sending to the API");
      print("------->the Skills: ${skills}");
      // setState(() {
      //   // _isloading = true;
      // });
      final String url =
          'https://workinn.herokuapp.com/api/account/user_profile_update/';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email":email,
          "education_level": currentEducationLevelSelectedValue,
          "study_fields": fieldOfStudySelectedValue,
          "career_level": careerLevelSelectedValue,
          "job_types": jobTypeInterestedSelectedValue,
          "careers_intrests": jobCareersInterestedSelectedValue,
          "job_title_looking_for": jobTitleLookingSelectedValue,
          "languages": languageSelectedValue,
          "language_level": proficiencySelectedValue,
          "gpa": gpa,
          "min_salary": salaryController,
          "uni": university,
          "yearofgrad": yearOfGraduation,
          "about":aboutInfo,
          "years_of_experience": yearsOfExperience,
          "skills":skills,
        }),
      );
      print(jsonDecode(response.body));
      // setState(() {
      //   // _isloading = false;
      // });
      if (jsonDecode(response.body)['response'] == 'Success') {
        print("<---------------response is success--------------------->");
        print(jsonDecode(response.body)['response']);
          SharedPreferences prefs =await SharedPreferences.getInstance();
          fetchuserinfo(prefs.getString('mail')!);
        Navigator.push(context, MaterialPageRoute(builder: (context) => realHomeScreen(),));
      }
      else if (jsonDecode(response.body)['response'] == 'error') {
        print("<---------------response is error--------------------->");
        print(jsonDecode(response.body)['response']);
        print(jsonDecode(response.body)['error_msg']);

      }
      else{
        print("<---------------nothing happened--------------------->");

      }

    }
  }


}
