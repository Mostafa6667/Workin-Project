

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Screens1/companyProfileScreen_private.dart';
import '../constants.dart';
import '../controllers/companyPrivateReview.dart';
import '../controllers/companyPublicProfile.dart';
import '../controllers/company_getJobs.dart';

class EmployingScreen extends StatefulWidget {
  const EmployingScreen({Key? key}) : super(key: key);

  @override
  _EmployingScreenState createState() => _EmployingScreenState();
}

class _EmployingScreenState extends State<EmployingScreen> {

  bool _isloading = false;

  String? _JobCategorySelectedValue;
  String? _JobTypeSelectedValue;
  String? _yearsOfExperienceNeededSelectedValue;
  String? _CurrentEducationLevelSelectedValue;
  TextEditingController _jobDescription = TextEditingController();
  TextEditingController _salary = TextEditingController();
  TextEditingController _jobRequirements = TextEditingController();
  TextEditingController _jobTitle = TextEditingController();

  late FocusNode _jobDescriptionFocusNode;
  late FocusNode _salaryFocusNode;
  late FocusNode _jobRequirementsFocusNode;
  late FocusNode _jobTitleFocusNode;


  bool checkBoxValue = false;
  bool isConfidential = false;

  @override
  void dispose(){
    _jobDescription.dispose();
    _salary.dispose();
    _jobRequirements.dispose();
    _jobTitle.dispose();
    _jobDescriptionFocusNode.dispose();
    _salaryFocusNode.dispose();
    _jobRequirementsFocusNode.dispose();
    _jobTitleFocusNode.dispose();
    super.dispose();

  }
  var _textJobDescription='';
  var _textSalary='';
  var _textJobRequirements='';
  var _textJobTitle='';





  List<String> listOfJobCategory = ['IT/Software Development', 'Marketing', 'Advertising','Engineering','Management','Art and Design'];
  List<String> listOfJobType = ['Full Time', 'Part Time', 'Internship', 'Shift Based','Work from home','Volunteering'];
  List<String> listOfYearsOfExperienceNeeded = ['0', '1-3', '4-6', 'Above 6'];
  List<String> listOfCurrentEducationLevel = ['Student','graduate','Bachelor', 'UnderGrad', 'Masters', 'PHD'];

  String? get _JobDescriptionValidation {

    final text = _jobDescription.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }
  String? get _JobRequirementsValidation {

    final text = _jobRequirements.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }
  String? get _SalaryValidation {

    final text = _salary.value.text;
    if (text.isEmpty && checkBoxValue==false) {
      return 'Make it Confidential or Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }

  @override
  void initState() {
    super.initState();
    _jobDescriptionFocusNode = FocusNode();
    _salaryFocusNode=FocusNode();
    _jobRequirementsFocusNode=FocusNode();
    _jobTitleFocusNode=FocusNode();
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
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black54,
                  ),
                ),
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

  Widget inputFile({label, subtitle, obscureText = false , TextInputType , hintText, required TextEditingController controller,errorText,onChangedText,focusNode})
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
        SizedBox(height: 2,),
        Text(
        subtitle,
        style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color:Colors.black38,
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
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black54,
                  ),
              ),
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
  Widget inputFile2({label, obscureText = false , TextInputType , hintText, required TextEditingController controller,onChangedText})
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
          controller: controller,
          keyboardType: TextInputType,
          obscureText: obscureText,
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
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
                  borderSide: BorderSide(width:3,color: Colors.grey),
              )
          ),
          onChanged: (label)=> setState(()=> onChangedText),
        ),
        SizedBox(height: 10,)
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).accentColor,
          ),),),)
        :Scaffold(
      body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text('Employ now',
                style: GoogleFonts.nunito(fontSize: 35,fontWeight: FontWeight.bold),),
            ],
          ),
          SizedBox(height: 20,),
          maxLineInputFile( label: "Job description",hintText: "Write a description about your job opportunity" , controller: _jobDescription, errorText: _JobDescriptionValidation , onChangedText:  _textJobDescription,focusNode: _jobDescriptionFocusNode ),
          SizedBox(height: 10,),
          Text('Job details',
          style: GoogleFonts.nunito(fontSize: 25,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Row(
            children: [

              Text(
                'Job Category',
                style: GoogleFonts.nunito(fontSize: 18),
              )
            ],
          ),
          Row(
            children: [
              Container(width: 370,height: 50,
                child: DropdownButtonFormField(
                  value: _JobCategorySelectedValue,
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
                    _JobCategorySelectedValue=value!;
                  },
                  onSaved: (String? value) {
                    _JobCategorySelectedValue=value!;
                  },
                  items: listOfJobCategory.map((String val){
                    return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          inputFile2(label: "Job title" ,TextInputType: TextInputType.text, hintText: "Student,Junior,Senior,etc..." ,controller: _jobTitle, onChangedText:_textJobTitle,),
          SizedBox(height: 10,),
          Row(
            children: [
              Text(
                'Years of experience needed',
                style: GoogleFonts.nunito(fontSize: 18),
              )
            ],
          ),
          Row(
            children: [
              Container(width: 370,height: 50,
                child: DropdownButtonFormField(
                  value: _yearsOfExperienceNeededSelectedValue,
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
                    _yearsOfExperienceNeededSelectedValue=value!;
                  },
                  onSaved: (String? value) {
                    _yearsOfExperienceNeededSelectedValue=value!;
                  },
                  items: listOfYearsOfExperienceNeeded.map((String val){
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
                'Job Type',
                style: GoogleFonts.nunito(fontSize: 18),
              )
            ],
          ),
          Row(
            children: [
              Container(width: 370,height: 50,
                child: DropdownButtonFormField(
                  value: _JobTypeSelectedValue,
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
                    _JobTypeSelectedValue=value!;
                  },
                  onSaved: (String? value) {
                    _JobTypeSelectedValue=value!;
                  },
                  items: listOfJobType.map((String val){
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
                'Current education level',
                style: GoogleFonts.nunito(fontSize: 18),
              )
            ],
          ),
          Row(
            children: [
              Container(width: 370,height: 50,
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
          inputFile(label: "Salary" ,subtitle: "Entering it help us suggest for you candidates" ,TextInputType: TextInputType.number, hintText: "5000" ,controller: _salary,errorText: _SalaryValidation , onChangedText:_textSalary ,focusNode: _salaryFocusNode),
          SizedBox(height: 10,),
          FormField<bool>(
            builder: (state) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Container(
                        width: 14,height: 14,
                        color: Colors.white,
                        child: Checkbox(
                            activeColor: Colors.black,
                            value: checkBoxValue,
                            onChanged: (value) {
                              setState(() {
                                checkBoxValue = value!;
                                state.didChange(value);
                              });
                            }),
                      ),
                      SizedBox(width: 10,),
                      Text('Make it confidential',style: GoogleFonts.nunito(fontSize: 14),),
                    ],
                  ),
                  Text(
                    state.errorText ?? '',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                    ),
                  )
                ],
              );
            },
            validator: (value) {
              if (!checkBoxValue) {
                setState(() {
                  isConfidential=false;
                });
              } else {
                setState(() {
                  isConfidential=true;
                });
              }
            },
          ),
          SizedBox(height: 10,),
          maxLineInputFile( label: "Job requirements",hintText: "-job requirements\n-skills\n-tools\n" , controller: _jobRequirements, errorText: _JobRequirementsValidation , onChangedText:  _textJobRequirements,focusNode: _jobRequirementsFocusNode ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: 285,
                color: primarycolor,
                height: 50,
                onPressed: () async {
                  await register( _JobCategorySelectedValue.toString(),_jobTitle.text,_JobTypeSelectedValue.toString(),_jobDescription.text,
                    _salary.text,_jobRequirements.text, _yearsOfExperienceNeededSelectedValue.toString(),_CurrentEducationLevelSelectedValue.toString(),isConfidential.toString() );
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),

                ),
                child: Text(
                    "Post", style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )
                ),

              ),
            ],
          ),
        ],
      ),),
      ),
    );
  }


  String? token;
  String? mail;

  Future<void>fetchcompdetailsprv(String mail)async{


    await Provider.of<companyDetailView>(context,listen: false).fetchDetails(mail);



  }
  Future<void>fetchcompdetails2prv(String mail)async{
     Provider.of<companyReviews>(context,listen: false).delete();
    await Provider.of<companyReviews>(context,listen: false).fetchReviews(mail);



  }
  Future<void>fetchcompjobsprv(String mail)async{
    Provider.of<companyJobs>(context,listen: false).delete();
    await Provider.of<companyJobs>(context,listen: false).fetchjobs(mail);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => companyPrivateProfile()),);


  }


  Future<void> register(jobCategory,jobTitle,jobType,jobDescription, salary, jobRequirements, yearsOfExperienceNeededSelectedValue, currentEducationLevelSelectedValue, isconfidential ) async {
    if (_JobDescriptionValidation == null && _JobRequirementsValidation == null && _SalaryValidation == null ) {
      setState(() {
        _isloading = true;
      });
      final prefs= await SharedPreferences.getInstance();
      token=prefs.getString('token');
      print("Token of Employing:$token");
      mail=prefs.getString('mail');
      print("Email of Employing:$mail");
      final String url =
          'https://workinn.herokuapp.com/api/jobs/create_job';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ${token}',
        },
        body: jsonEncode(<String, String>{
          "job_category": jobCategory,
          "job_title": jobTitle,
          "experience": yearsOfExperienceNeededSelectedValue,
          "job_type": jobType,
          "description": jobDescription,
          "requirements": jobRequirements,
          "education_level": currentEducationLevelSelectedValue,
          "salary": salary,
          "isConfidential": isconfidential,
        }),
      );
      print(jsonDecode(response.body));
      setState(() {
        _isloading = false;
      });
      if (jsonDecode(response.body)['response'] == 'Success') {
        print(jsonDecode(response.body));
        fetchcompdetailsprv(mail!);
        fetchcompdetails2prv(mail!);
        fetchcompjobsprv(mail!);
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
  }

}
