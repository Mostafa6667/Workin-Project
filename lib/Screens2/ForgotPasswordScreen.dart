import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workin_servive/Screens2/verification_screen.dart';
import 'package:workin_servive/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login.dart';


class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  bool _isloading = false;


  TextEditingController _email = TextEditingController();

  late FocusNode _emailFocusNode;

  @override
  void dispose(){
    _email.dispose();

    _emailFocusNode.dispose();
    super.dispose();
  }

  var _textEmail='';


  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();

  }

  String? get _EmailValidation {
    // at any time, we can get the text from _controller.value.text
    final text = _email.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email.text)){
      return 'Enter a valid email';
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

                    Container(
                      height: 100,
                      width: 250,
                      child: Image.asset('assets/images/Artboard 3.png'),
                    ),
                    SizedBox(height: 25),
                    Text("Don't worry, We got your back ",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50,),
                      inputFile(label: "Email",TextInputType: TextInputType.emailAddress , hintText:'You@example.com',controller: _email,errorText: _EmailValidation,onChangedText: _textEmail,focusNode: _emailFocusNode ),
                      SizedBox(height:25),
                      MaterialButton(
                        minWidth: 285,
                        color: primarycolor,
                        height: 50,
                        onPressed: () async {
                          await EmailVerification( _email.text,);
                        },
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Text(
                            "Send verification code", style: GoogleFonts.nunito(
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
                          color: primarydarkcolor,
                        ))),
                    /* Text(" Sign up", style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: primaryDarkColor,
                    ))*/
                  ],
                ),


              ],
            ))
          ],
        ),
      ),
    );
  }

  Future<void> EmailVerification(email) async {
    if (_EmailValidation == null  ) {
      setState(() {
        _isloading = true;
      });
      final String url =
          'https://workinn.herokuapp.com/api/account/reset_password_mail/';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
        }),
      );
      setState(() {
        _isloading = false;
      });
      print('---->${jsonDecode(response.body)}');
      if (jsonDecode(response.body)['response'] == 'success') {
        print('---->${jsonDecode(response.body)}');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', jsonDecode(response.body)['token'] );
        await prefs.setString('email', jsonDecode(response.body)['email'] );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  VerficationScreen()),);
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
        print('---->Nothing happened');

      }


    }
  }

}


// we will be creating a widget for text field


