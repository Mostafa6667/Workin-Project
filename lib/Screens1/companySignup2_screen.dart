import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_code_picker.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens2/companyInfoScreen.dart';
import '../constants.dart';
import '../controllers/companySignup.dart';
import '../controllers/companySignup2.dart';


class companySignupTwo extends StatefulWidget {
  const companySignupTwo({Key? key}) : super(key: key);

  @override
  _companySignupTwoState createState() => _companySignupTwoState();
}

class _companySignupTwoState extends State<companySignupTwo>  with SingleTickerProviderStateMixin{
  final GlobalKey<FormState> _formkey = GlobalKey();
  var _isLoading = false;
  String? error;
  String? responsedata;
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _phoneNumController=TextEditingController();
  TextEditingController _compNameController=TextEditingController();
  var _countrypick;

  _fNameValidation(){
    if(RegExp('^[a-zA-Z]').hasMatch(_fNameController.text)){
      return false;
    }else{
      return true;
    }
  }
  _lNameValidation(){
    if(RegExp('^[a-zA-Z]').hasMatch(_lNameController.text)){
      return false;
    }else{
      return true;
    }
  }
  _titleValidation(){
    if(RegExp('^[a-zA-Z]').hasMatch(_titleController.text)){
      return false;
    }else{
      return true;
    }
  }
  _phoneNumValidation(){
    if(RegExp('^(?:[+0]9)?[0-9]{10}').hasMatch(_phoneNumController.text)){
      return false;
    }else{
      return true;
    }
  }
  _companyNameValidation(){
    if(RegExp('^[A-Za-z0-9]').hasMatch(_compNameController.text)){
      return false;
    }else{
      return true;
    }
  }
  Future<void> _submit() async {
    var prefs=await SharedPreferences.getInstance();
    final firstname = _fNameController.text;
    final lastname = _lNameController.text;
    final jobTitle = _titleController.text;
    final mobNumber = _phoneNumController.text;
    final compname= _compNameController.text;
    final email=prefs.getString('mail');



    if (!_formkey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formkey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<companyAuth2>(context, listen: false)
          .companySignup2(email!,firstname,lastname,jobTitle,mobNumber,compname);
    } catch(e) {
      throw e;
    }

    responsedata=prefs.getString('rescompdata');
    error=prefs.getString('comperror');
    if(responsedata=='Success'){
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Onboard(),));

    }
    print(responsedata);
    prefs.remove('rescompdata');

    print(error);
    prefs.remove('comperror');
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(

        child: Form(
          key: _formkey,
          child: Container(
            height:MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text('Last Step',style: GoogleFonts.nunito(fontSize: 36),)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text('Please provide us with some information to start employing',style: GoogleFonts.nunito(fontSize: 11),)
                            ],
                          ),
                          SizedBox(height: 20,),
                          Text('${error!='That company name is already in use.'?'':'Company Name Exists'}',style: GoogleFonts.nunito(fontSize: 16,color: Colors.red),),
                          SizedBox(height: 20,),
                          Row(
                            children: [


                              Text(
                                'First Name',
                                style: GoogleFonts.nunito(fontSize: 18),
                              ),
                              SizedBox(width: 96,),
                              Text(
                                'Last Name',
                                style: GoogleFonts.nunito(fontSize: 18),
                              )
                            ],
                          ),
                          Row(
                            children: [

                              Container(
                                width: 166,
                                child: TextFormField (
                                  keyboardType: TextInputType.name,
                                  controller: _fNameController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Type your first Name';
                                    }else if(_fNameValidation()){
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
                                    hintText: 'First Name',
                                  ),
                                ),
                              ),
                              SizedBox(width: 18,),
                              Container(
                                width: 166,
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: _lNameController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Type your last Name';
                                    }else if(_lNameValidation()){
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
                                      hintText: 'Last Name'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [

                              Text(
                                'Your Title',
                                style: GoogleFonts.nunito(fontSize: 18),
                              )
                            ],
                          ),
                          Row(
                            children: [

                              Container(
                                width: 350,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _titleController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Type your title';
                                    }
                                    else if(_titleValidation()){
                                      return 'only characters here';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled:true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: primarycolor)),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: primarycolor),
                                    ),
                                    hintStyle: GoogleFonts.nunito(fontSize: 18),
                                    hintText: 'HR,Recruiter,CEO,etc...',
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [

                              Text(
                                'Phone Number',
                                style: GoogleFonts.nunito(fontSize: 18),
                              )
                            ],
                          ),
                          Row(
                            children: [

                              Container(
                                width: 100,
                                height: 65,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(width: 1,color: primarycolor),
                                    borderRadius:BorderRadius.circular(5.0)
                                ),

                                child: CountryCodePicker(
                                  initialSelection:'EG' ,

                                  onChanged: (value) {
                                    _countrypick=value;
                                  },
                                ),
                              ),
                              Container(
                                width: 250,

                                child: TextFormField(
                                  controller: _phoneNumController,
                                  keyboardType: TextInputType.phone,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Type your number';
                                    }
                                    else if(_phoneNumValidation()){
                                      return 'only numbers here';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled:true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: primarycolor)),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: primarycolor),
                                    ),
                                    hintStyle: GoogleFonts.nunito(fontSize: 18),
                                    hintText: 'Phone Number',
                                  ),
                                ),
                              ),


                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [

                              Text(
                                'Company Name',
                                style: GoogleFonts.nunito(fontSize: 18),
                              )
                            ],
                          ),
                          Row(
                            children: [

                              Container(
                                width: 350,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller:_compNameController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Type your company name';
                                    }
                                    else if(_companyNameValidation()){
                                      return 'only characters or numbers';
                                    }
                                    return null;
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
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          if (_isLoading) CircularProgressIndicator(),
                          Container(
                            width: 285,
                            child: ElevatedButton(
                                onPressed: () {
                                  _submit();

                                },
                                style: ElevatedButton.styleFrom(
                                    primary: primarycolor,
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0),
                                    ),
                                    minimumSize: Size(0, 50)),
                                child: Text('Create Company account',
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white))),
                          ),


                        ],
                      ),
                    ))
              ],
            ),
          ),

        ),
      ),
    );
  }
}