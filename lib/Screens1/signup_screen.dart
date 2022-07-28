import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';

import '../Screens2/SignUpVerify.dart';
import '../Screens2/login.dart';
import '../constants.dart';
import '../controllers/signup.dart';

import 'companySignup_screen.dart';
import 'home_Screen.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  var _isLoading = false;
  var _showPassword=false;
  String?error;
  String? responsedata;

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
  _emailValidation() {
    if (RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text)) {
      return false;
    } else {
      return true;
    }
  }
  void _showPass(){
    setState(() {
      _showPassword=!_showPassword;
    });
  }


  Future<void> _submit() async {
    final firstname = _fNameController.text;
    final lastname = _lNameController.text;
    final email = _emailController.text;
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
      await Provider.of<Auth>(context, listen: false)
          .SignUp(email, firstname, lastname, password);
    } catch(e) {
      throw e;
    }
    SharedPreferences prefs =await SharedPreferences.getInstance();
    responsedata=prefs.getString('resuserdata');

    if(responsedata=='success'){
      print(prefs.getString('token'));
      print(prefs.getString('mail'));
      print(prefs.getString('isCompany'));
      Navigator.push(context, MaterialPageRoute(
        builder: (context) =>  SignUp_VerficationScreen(),));


    }else {
      print('--$responsedata');
      error = prefs.getString('usererror');
      print('--error--$error');
      prefs.remove('usererror');
      prefs.remove('resuserdata');



      // print(error);

    }
    setState(() {
      _isLoading = false;
    });
  }
  // Future<void> _submit() async {
  //   final firstname = _fNameController.text;
  //   final lastname = _lNameController.text;
  //   final email = _emailController.text;
  //   final password = _passwordController.text;
  //
  //   if (!_formkey.currentState!.validate()) {
  //     return;
  //   }
  //   FocusScope.of(context).unfocus();
  //   _formkey.currentState!.save();
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //     await Provider.of<Auth>(context, listen: false)
  //         .SignUp(email, firstname, lastname, password);
  //   } catch(e) {
  //     throw e;
  //   }
  //   SharedPreferences prefs =await SharedPreferences.getInstance();
  //   responsedata=prefs.getString('resuserdata');
  //   error=prefs.getString('usererror');
  //   if(responsedata=='success'){
  //     Navigator.push(context, MaterialPageRoute(
  //       builder: (context) => SignUp_VerficationScreen(),));
  //   }
  //   print(responsedata);
  //   prefs.remove('resuserdata');
  //
  //   print(error);
  //   prefs.remove('usererror');
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
                Expanded(

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20.0),
                      child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              height: 100,
                              width: 250,
                              child: Image.asset('assets/images/Artboard 3.png'),
                            ),
                            Text('${error!='That email is already in use.'?'':'Email Exists'}',style: GoogleFonts.nunito(fontSize: 16,color: Colors.red),),
                            SizedBox(height: 5,),
                            Text('Create Account',
                                style: GoogleFonts.nunito(fontSize: 36)),
                            Row(
                              children: [

                                Text(
                                  'First Name',
                                  style: GoogleFonts.nunito(fontSize: 18),
                                ),
                                SizedBox(
                                  width: 102,
                                ),
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
                                  height: 55,
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
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width: 166,
                                  height: 55,
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
                                  'E-mail',
                                  style: GoogleFonts.nunito(fontSize: 18),
                                )
                              ],
                            ),
                            Row(
                              children: [

                                Container(
                                  width: 350,
                                  height: 55,
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _emailController,
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
                                      filled:true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: primarycolor)),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: primarycolor),
                                      ),
                                      hintStyle: GoogleFonts.nunito(fontSize: 18),
                                      hintText: 'you@example.com',
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
                                  'Password',
                                  style: GoogleFonts.nunito(fontSize: 18),
                                )
                              ],
                            ),
                            Row(
                              children: [

                                Container(
                                  width: 350,
                                  height: 55,
                                  child: TextFormField(
                                    obscureText: !_showPassword,
                                    controller: _passwordController,
                                    keyboardType: TextInputType.visiblePassword,
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
                              ],
                            ),
                            SizedBox(
                              height: 22,
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
                                  child: Text('Create account',
                                      style: GoogleFonts.nunito(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text(
                                  'Have an account?',
                                  style: GoogleFonts.nunito(
                                      fontSize: 18, color: Colors.black),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen(),));
                                  },
                                  child: Text(
                                    'Login...',
                                    style: GoogleFonts.nunito(
                                        fontSize: 18, color: primarydarkcolor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Flexible(
                                  flex: 7,
                                  fit: FlexFit.tight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => companySignupScreen(),));
                                      },child: Text('Start Hiring...',style: GoogleFonts.nunito(fontSize: 20,color: Colors.blue),)),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => realHomeScreen(),));
                                          },
                                          child: Text('Skip',style: GoogleFonts.nunito(fontSize: 20,color: Colors.blue),)),
                                    ],
                                  ),
                                ),
                              ],
                            )

                          ]),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

}