import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ForgotPasswordScreen.dart';
import 'package:workin_servive/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'login.dart';


class ConfirmPassScreen extends StatefulWidget {
  @override
  _ConfirmPassScreenState createState() => _ConfirmPassScreenState();
}

class _ConfirmPassScreenState extends State<ConfirmPassScreen> {
  bool _isloading = false;

  TextEditingController _pass = TextEditingController();
  TextEditingController _confirmPass = TextEditingController();

  late FocusNode _passFocusNode;
  late FocusNode _confirmPassFocusNode;

  @override
  void dispose(){
    _pass.dispose();
    _confirmPass.dispose();

    super.dispose();
    _passFocusNode.dispose();
    _confirmPassFocusNode.dispose();
  }

  var _textPassword='';
  var _textConfirmPassword='';

  @override
  void initState() {
    super.initState();
    _passFocusNode = FocusNode();
    _confirmPassFocusNode=FocusNode();
  }

  String? get _PasswordValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _pass.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }
  String? get _ConfirmPasswordValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _confirmPass.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }else if (text!= _pass.value.text){
      return'The password doesn\'t match';
    }
    // return null if the text is valid
    return null;
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
        : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(height: 70),

                    CircleAvatar(
                      radius: 61,
                    ),
                  ],
                ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Row(
                       mainAxisSize: MainAxisSize.max,
                       children: <Widget>[
                         SizedBox(width:100000),
                       ],
                       ),
                     SizedBox(height: 20),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
                       child: Text("Reset password",
                         style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
                       child: Text("Please choose your new password",
                         style: TextStyle(fontSize: 14, color: Colors.grey),),
                     ),
                   ],


                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      inputFile(label: "Password", obscureText: true , hintText: 'Password',controller: _pass, errorText: _PasswordValidation,onChangedText: _textPassword,focusNode: _passFocusNode ),
                      SizedBox(height: 10,),
                      inputFile(label: "Confirm Password", obscureText: true , hintText: 'Confirm Password',controller: _confirmPass, errorText: _PasswordValidation,onChangedText: _textConfirmPassword,focusNode: _confirmPassFocusNode ),

                      SizedBox(height:25),
                      MaterialButton(
                        minWidth: 285,
                        color: primarycolor,
                        height: 50,
                        onPressed: () async {
                          await ConfirmNewPassword( _pass.text,
                            _confirmPass.text,);
                        },
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Text(
                            "Save your new password", style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                        ),

                      ),
                    ],

                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    FlatButton(
                        highlightColor:Colors.white ,
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child:  Text(" Back to login", style: GoogleFonts.nunito(
                          fontSize: 18,
                          color: primarydarkcolor,)
                        )
                    ),
                  ],
                ),


              ],
            ))
          ],
        ),
      ),
    );
  }

  Future<void> ConfirmNewPassword(String pass, String confirmPass,) async {
    final prefs = await SharedPreferences.getInstance();
    String? token2 = prefs.getString('token2');
    String ?email2 = prefs.getString('email2');
    if ( _PasswordValidation==null && _ConfirmPasswordValidation==null ) {
      setState(() {
        _isloading = true;
      });
      final String url =
          'https://workinn.herokuapp.com/api/account/reset_password_check/${token2}/';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email2,
          "password":pass,
          "password2":confirmPass,
        }),
      );
      print(jsonDecode(response.body));
      setState(() {
        _isloading = false;
      });
      if (jsonDecode(response.body)['response'] == 'success') {
        print(jsonDecode(response.body));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  LogInScreen()),);
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


// we will be creating a widget for text field


