import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workin_servive/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'CVUploadScreen.dart';
import 'ConfirmPassScreen.dart';


class SignUp_VerficationScreen extends StatefulWidget {
  @override
  _SignUp_VerficationScreenState createState() => _SignUp_VerficationScreenState();
}




class _SignUp_VerficationScreenState extends State<SignUp_VerficationScreen> {


  TextEditingController _digit1 = TextEditingController();
  TextEditingController _digit2 = TextEditingController();
  TextEditingController _digit3 = TextEditingController();
  TextEditingController _digit4 = TextEditingController();
  TextEditingController _digit5 = TextEditingController();
  TextEditingController _digit6 = TextEditingController();

  @override
  void dispose() {
    _digit1.dispose();
    _digit2.dispose();
    _digit3.dispose();
    _digit4.dispose();
    _digit5.dispose();
    _digit6.dispose();

    super.dispose();
  }

  bool _isloading=false;

  String? get _digit1Validation {
    // at any time, we can get the text from _controller.value.text
    final text = _digit1.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return '__';
    }
    // return null if the text is valid
    return null;
  }
  String? get _digit2Validation {
    // at any time, we can get the text from _controller.value.text
    final text = _digit2.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return '__';
    }
    // return null if the text is valid
    return null;
  }
  String? get _digit3Validation {
    // at any time, we can get the text from _controller.value.text
    final text = _digit3.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return '__';
    }
    // return null if the text is valid
    return null;
  }
  String? get _digit4Validation {
    // at any time, we can get the text from _controller.value.text
    final text = _digit4.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return '__';
    }
    // return null if the text is valid
    return null;
  }
  String? get _digit5Validation {
    // at any time, we can get the text from _controller.value.text
    final text = _digit5.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return '__';
    }
    // return null if the text is valid
    return null;
  }
  String? get _digit6Validation {
    // at any time, we can get the text from _controller.value.text
    final text = _digit6.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return '__';
    }
    // return null if the text is valid
    return null;
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                "Verify your Email",
                style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "We've sent you a verification code",
                style:
                GoogleFonts.nunito(fontSize: 18, color: Colors.grey[400]),
              ),
              Text(
                "please check your mail",
                style:
                GoogleFonts.nunito(fontSize: 18, color: Colors.grey[400]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        textFieldOTP( _digit1Validation ,_digit1,context, first: true, last: false),
                        textFieldOTP( _digit2Validation,_digit2,context, first: false, last: false),
                        textFieldOTP( _digit3Validation,_digit3,context, first: false, last: false),
                        textFieldOTP( _digit4Validation,_digit4,context, first: false, last: false),
                        textFieldOTP( _digit5Validation,_digit5,context, first: false, last: false),
                        textFieldOTP( _digit6Validation,_digit6,context, first: false, last: true),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: 285,
                color: primarycolor,
                height: 50,
                onPressed: () async {
                  await SendVerification(_digit1.text, _digit2.text, _digit3.text, _digit4.text, _digit5.text, _digit6.text);
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("Continue",
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ), //Google fonts
              ),
              SizedBox(
                height: 3,
              ),
              FlatButton(
                  highlightColor: Colors.white,
                  onPressed: () async{
                    await SendVerification(_digit1.text, _digit2.text, _digit3.text, _digit4.text, _digit5.text, _digit6.text);
                  },
                  child: Text(" Resend new code",
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: primarydarkcolor,
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFieldOTP(errorText, TextEditingController Controller, context,
      {bool? first, last}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 0.5,
        child: TextField(
          controller: Controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            errorText: errorText,
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: primarycolor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> SendVerification(String digit1, String digit2,String digit3,String digit4,String digit5,String digit6,) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('----------->the token1 :${token}');
    String code=digit1+digit2+digit3+digit4+digit5+digit6;
    print('----------->the code:${code}');
    if (_digit1Validation == null && _digit2Validation == null &&_digit3Validation == null &&_digit4Validation == null &&_digit5Validation == null &&_digit6Validation == null  ) {
      setState(() {
        _isloading = true;
      });
      final String url =
          'https://workinn.herokuapp.com/api/account/user_verification';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Token ${token}',
        },
        body: jsonEncode(<String, dynamic>{
          "verification_code":code,
        }),
      );
      print(jsonDecode(response.body));
      setState(() {
        _isloading = false;
      });
      if (jsonDecode(response.body)['response'] == 'success') {
        await prefs.setString('token', jsonDecode(response.body)['token'] );
        await prefs.setString('mail', jsonDecode(response.body)['email'] );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  CvUploadScreen()),);
      }
      else if (jsonDecode(response.body)['response'] == 'error') {
        print('${jsonDecode(response.body)['error_msg'] }');
        AlertDialog alert = AlertDialog(
          backgroundColor: Colors.white,
          title: Text('${jsonDecode(response.body)['error_msg'] }',
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
        print('------> Nothing Happened');
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
