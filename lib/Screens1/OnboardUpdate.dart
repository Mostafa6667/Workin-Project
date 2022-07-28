

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../controllers/companyPrivateReview.dart';
import '../controllers/companyPublicProfile.dart';
import '../controllers/company_getJobs.dart';
import 'companyProfileScreen_private.dart';

class OnboardUpdate extends StatefulWidget {
  @override
  _OnboardUpdateState createState() => _OnboardUpdateState();
}

class _OnboardUpdateState extends State<OnboardUpdate> {
  String Email='';

  String? _FoundedSelectedValue;
  String? _HeadquarterSelectedValue;
  String? _CompanyIndustrySelectedValue;
  String? _CompanySizeSelectedValue;
  String? _SpecialtiesSelectedValue;
  String? _TypeSelectedValue;



  List<String> listOfFounded = ['1', '2', '3', '4', '5'];
  List<String> listOfSpecialties = ['Software Development', 'Architecture', 'Logistics','Media','Insurance'];
  List<String> listOfCompanyIndustry = ['Technology', 'Architecture', 'Translation', 'Design', 'Media and Advertising','Medicine'];
  List<String> listOfCompanySize = ['Small Business', 'Mid Market enterprise', 'Enterprise'];
  List<String> listOfType = ['Private company', 'Public Company', 'Non Profit Organization'];
  List<String> listOfHeadquarter = ['Cairo', 'Alex', 'Damita', 'Pour Said', 'Elminia','Silicon Valley','New York','Chicago','Tokyo','Seattle','Paris','London','Osaka',];



  final controller = PageController();

  TextEditingController _website = TextEditingController();
  TextEditingController _companyInfo = TextEditingController();
  TextEditingController _location= TextEditingController();
  TextEditingController _founded= TextEditingController();


  @override
  void dispose(){
    controller.dispose();
    _website.dispose();
    _companyInfo.dispose();
    _location.dispose();


    super.dispose();
  }
  var _textWebsite='';
  var _textCompanyInfo='';
  var _textLocation='';
  var _textFounded='';


  String? get _WebsiteValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _website.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // if(!RegExp(r"\n# $&:\n\t").hasMatch(_website.text)){
    //   return 'Enter a valid email';
    // }
    // return null if the text is valid
    return null;
  }
  String? get _CompanyInfoValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _companyInfo.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }
  String? get _LocationValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _location.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }
  String? get _foundedValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _founded.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }



  Widget inputFile({label, obscureText = false , TextInputType , hintText, required TextEditingController controller,errorText,onChangedText})
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
              errorText: errorText,
              hintText: hintText,
              hintStyle: GoogleFonts.nunito(fontSize: 18 ),
              contentPadding: EdgeInsets.symmetric(vertical: 0,
                  horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
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
  Widget maxLineInputFile({label, obscureText = false , TextInputType , hintText, required TextEditingController controller,errorText,onChangedText})
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
                hintText: hintText,
                hintStyle: GoogleFonts.nunito(fontSize: 18 ),
                hintMaxLines: 3,
                contentPadding: EdgeInsets.symmetric(vertical: 10,
                    horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Color(0xc4c4c4),
        centerTitle: true,
        title: Column(
            children:[
              Text("Company info",
                style: GoogleFonts.nunito(fontSize: 30, fontWeight: FontWeight.bold , color: Colors.black),),
              Text("These information help candidates to know your company",
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
      body: Container(
        child: PageView(
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
                      inputFile(label: "Website",TextInputType: TextInputType.emailAddress , hintText:'www.example.com',controller: _website,errorText: _WebsiteValidation,onChangedText: _textWebsite ),
                      SizedBox(height: 10,),
                      inputFile(label: "Founded",TextInputType: TextInputType.number , hintText:'1980',controller: _founded,errorText: _foundedValidation,onChangedText: _textFounded ),

                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            'Headquarter',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _HeadquarterSelectedValue,
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
                                _HeadquarterSelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _HeadquarterSelectedValue=value!;
                              },
                              items: listOfHeadquarter.map((String val){
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
                            'Company Industry',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _CompanyIndustrySelectedValue,
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
                                _CompanyIndustrySelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _CompanyIndustrySelectedValue=value!;
                              },
                              items: listOfCompanyIndustry.map((String val){
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
                            'Company Size',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _CompanySizeSelectedValue,
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
                                _CompanySizeSelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _CompanySizeSelectedValue=value!;
                              },
                              items: listOfCompanySize.map((String val){
                                return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      SmoothPageIndicator (
                          controller:controller,
                          count:2
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
                      maxLineInputFile(label: "Company Info" ,TextInputType: TextInputType.multiline , hintText:'Write a brief description about your company',controller: _companyInfo,errorText: _CompanyInfoValidation,onChangedText: _textCompanyInfo ),
                      SizedBox(height: 10,),
                      Row(
                        children: [

                          Text(
                            'Specialties',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _SpecialtiesSelectedValue,
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
                                _SpecialtiesSelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _SpecialtiesSelectedValue=value!;
                              },
                              items: listOfSpecialties.map((String val){
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
                            'Type',
                            style: GoogleFonts.nunito(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(width: 350,height: 50,
                            child: DropdownButtonFormField(
                              value: _TypeSelectedValue,
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
                                _TypeSelectedValue=value!;
                              },
                              onSaved: (String? value) {
                                _TypeSelectedValue=value!;
                              },
                              items: listOfType.map((String val){
                                return DropdownMenuItem(value:val,child:Text(val,overflow: TextOverflow.visible,) );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      inputFile(label: "Location" , hintText:'2438 6th Ave, Ketchikan,Alaska USA',controller: _location,errorText: _LocationValidation,onChangedText: _textLocation ),
                      SizedBox(height: 20,),
                      SmoothPageIndicator (
                          controller:controller,
                          count:2
                      ),
                      SizedBox(height: 10,),

                      MaterialButton(
                        minWidth: 285,
                        color: primarycolor,
                        height: 50,
                        onPressed: () async {
                          final prefs=await SharedPreferences.getInstance();
                          Email=prefs.getString('compmail')!;
                          await saveCompanyInfo( _website.text, _companyInfo.text, _location.text, _founded.text, _HeadquarterSelectedValue, _CompanyIndustrySelectedValue, _CompanySizeSelectedValue,_SpecialtiesSelectedValue, _TypeSelectedValue,Email);
                          await Provider.of<companyDetailView>(context,listen: false).fetchDetails(Email);
                          await Provider.of<companyReviews>(context,listen: false).fetchReviews(Email);
                          await Provider.of<companyJobs>(context,listen: false).fetchjobs(Email);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => companyPrivateProfile(),));
                        },
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Text(
                            "Save", style: GoogleFonts.nunito(
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

    );
  }

  Future<void> saveCompanyInfo(String website,String companyInfo,String location,foundedSelectedValue,headquarterSelectedValue,companyIndustrySelectedValue,companySizeSelectedValue,specialtiesSelectedValue,typeSelectedValue,String mail ) async {
    if (_WebsiteValidation == null && _LocationValidation == null && _CompanyInfoValidation == null) {
      setState(() {
        // _isloading = true;
      });

      final String url =
          'https://workinn.herokuapp.com/api/company/Profile_setup/';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email":mail,
          "website": website,
          "founded_at": foundedSelectedValue,
          "headquarters": headquarterSelectedValue,
          "company_industries": companyIndustrySelectedValue,
          "size_of_company": companySizeSelectedValue,
          "company_info": companyInfo,
          "specialities": specialtiesSelectedValue, //Specialities
          "company_type": typeSelectedValue,
          "location": location,
        }),
      );
      print(jsonDecode(response.body));
      setState(() {
        // _isloading = false;
      });
      if (jsonDecode(response.body)['response'] == 'Success') {
        print("<---------------response is success--------------------->");
        print(jsonDecode(response.body)['response']);
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