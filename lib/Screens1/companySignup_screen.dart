import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../controllers/companySignup.dart';
import 'companySignup2_screen.dart';

class companySignupScreen extends StatefulWidget {
  const companySignupScreen({Key? key}) : super(key: key);

  @override
  _companySignupScreenState createState() => _companySignupScreenState();
}

class _companySignupScreenState extends State<companySignupScreen> with SingleTickerProviderStateMixin{
  final GlobalKey<FormState> _formkey = GlobalKey();
  bool checkBoxValue = false;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String?error;
  String?noerror;
  String? responsedata;
  var _isLoading = false;
  var _showPassword=false;

  void _showPass(){
    setState(() {
      _showPassword=!_showPassword;
    });
  }

  _emailValidation() {
    if (RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      return false;
    } else {
      return true;
    }
  }

  String?message;
  Future<dynamic> _submit() async {

    final email =emailController.text;
    final password = _passwordController.text;


    if (!_formkey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formkey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<companyAuth>(context, listen: false)
          .companySignup(email,password);
    } catch(e) {
      throw e;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    responsedata=prefs.getString('compresdata');



    if(responsedata=='Success'){
      print(prefs.getString('token'));
      print(prefs.getString('mail'));
      print('is--${prefs.getString('isCompany')}');
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => companySignupTwo(),));
    }else {
      print(responsedata);
      error=prefs.getString('comperror');
      print(error);
      prefs.remove('compresdata');
      prefs.remove('comperror');

    }

    setState(() {
      _isLoading = false;
    });
  }
  // Future<dynamic> _submit() async {
  //
  //
  //
  //
  //
  //   final email =emailController.text;
  //   final password = _passwordController.text;
  //
  //
  //   if (!_formkey.currentState!.validate()) {
  //     return;
  //   }
  //   FocusScope.of(context).unfocus();
  //   _formkey.currentState!.save();
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     await Provider.of<companyAuth>(context, listen: false)
  //         .companySignup(email,password);
  //   } catch(e) {
  //     throw e;
  //   }
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   responsedata=prefs.getString('resdata');
  //   error=prefs.getString('error');
  //   if(responsedata=='Success'){
  //     Navigator.push(context, MaterialPageRoute(
  //       builder: (context) => companySignupTwo(),));
  //     // error=prefs.getString('error');
  //     // noerror=prefs.getString('noerror');
  //
  //     // print(error);
  //   }
  //   print(responsedata);
  //   prefs.remove('resdata');
  //
  //   print(error);
  //   prefs.remove('error');
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 100,
                          width: 250,
                          child: Image.asset('assets/images/Artboard 3.png'),
                        ),
                        Text('Create Your          Company Account ',style:
                        GoogleFonts.nunito(fontSize: 36),textAlign:TextAlign.center),
                        SizedBox(height: 30,),
                        Text('${error!='That email is already in use.'?'':'Email Exists'}',style: GoogleFonts.nunito(fontSize: 16,color: Colors.red),),

                        Row(
                          children: [
                            Text('Business Email',style: GoogleFonts.nunito(fontSize: 18)),

                          ],
                        ),
                        Row(children: [

                          Container(
                            width: 350,
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Type your E-mail';
                                }
                                else if(_emailValidation()){
                                  return 'invalid E-mail';
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
                                hintText: 'you@example.com',
                              ),
                            ),
                          )
                        ],),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [

                            Text(
                              'Password',
                              style: GoogleFonts.nunito(fontSize: 18),
                            )
                          ],
                        ),
                        Row(children: [

                          Container(
                            width: 350,
                            child: TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !_showPassword,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Type your password';
                                }else if(val.length<8){
                                  return '8 characters at least';
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
                                hintText: 'Password',
                                suffixIcon: GestureDetector(
                                    onTap: _showPass,
                                    child: Icon(Icons.remove_red_eye)),
                              ),
                            ),
                          )
                        ],),
                        SizedBox(
                          height: 16,
                        ),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: 335,
                                      ),
                                    child:Text('  I accept the terms of use as company representative',style: GoogleFonts.nunito(fontSize: 14),),),
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
                              return 'You need to accept terms of use';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        if (_isLoading) CircularProgressIndicator(),
                        Container(
                          width: 285,
                          child: ElevatedButton(
                              onPressed: () async{
                                _submit();

                                // if(responsedata=='Success'){
                                //   Navigator.push(context, MaterialPageRoute(
                                //     builder: (context) => companySignupTwo(),));
                                //   // SharedPreferences pref = await SharedPreferences.getInstance();
                                //   // await pref.remove('resdata');
                                // }else{
                                //   return null;
                                // }



                                // if(_isLoading==false){
                                //   Navigator.push(context, MaterialPageRoute(
                                //     builder: (context) => companySignupTwo(),));
                                // }else {
                                //   return null;
                                // }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: primarycolor,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                  ),
                                  minimumSize: Size(0, 50)),
                              child: Text('Start Employing',
                                  style: GoogleFonts.nunito(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))),
                        ),
                      ],
                    ),
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