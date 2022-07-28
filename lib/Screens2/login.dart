import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens1/companyProfileScreen_private.dart';
import '../Screens1/home_Screen.dart';
import '../Screens1/signup_screen.dart';
import '../controllers/companyPrivateReview.dart';
import '../controllers/companyPublicProfile.dart';
import '../controllers/company_getJobs.dart';
import '../controllers/homescreen_getjobs.dart';
import 'ForgotPasswordScreen.dart';
import 'package:workin_servive/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool _isloading = false;
  var _showPassword=false;


  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  late FocusNode _emailFocusNode;
  late FocusNode _passFocusNode;

  @override
  void dispose(){
    _email.dispose();
    _pass.dispose();

    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  var _textEmail='';
  var _textPassword='';


  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passFocusNode=FocusNode();
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

  void _showPass(){
    setState(() {
      _showPassword=!_showPassword;
    });
  }

  Widget? iconShow(bool show){
   if(show==true){
     return GestureDetector(
         onTap: _showPass,
         child: Icon(Icons.remove_red_eye));
   }
  }

  Widget inputFile({label, obscureText = false , TextInputType , hintText, required TextEditingController controller,errorText,onChangedText, show,focusNode})
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
            suffixIcon: iconShow(show),
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
              ),

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
                    SizedBox(height: 20),
                    Text("Login",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20,),
                      inputFile(label: "Email",TextInputType: TextInputType.emailAddress , hintText:'You@example.com',controller: _email,errorText: _EmailValidation,onChangedText: _textEmail, show: false,focusNode: _emailFocusNode ),
                      SizedBox(height: 10,),
                      inputFile(label: "Password", obscureText: !_showPassword , hintText: 'Password',controller: _pass, errorText: _PasswordValidation,onChangedText: _textPassword , show: true,focusNode: _passFocusNode),
                      Container(
                        alignment: Alignment.topRight,
                      child: FlatButton(
                          highlightColor:Colors.white ,
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ForgotPass()),);
                          },
                          child:  Text("Forgot Your Password ?",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.nunito(fontSize: 12 , color: primarydarkcolor),
                          )
                        )
                      ),

                      SizedBox(height:25),
                      MaterialButton(
                        minWidth: 285,
                        color: primarycolor,
                        height: 50,
                        onPressed: () async {
                          await register( _email.text,
                              _pass.text,);
                          },
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Text(
                          "Login", style: GoogleFonts.nunito(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("No account?", style: GoogleFonts.nunito(
                      fontSize: 18,)),
                    FlatButton(
                        highlightColor:Colors.white ,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                    },
                        child:  Text(" Sign up", style: GoogleFonts.nunito(
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

  String? isCompany;
  String? mail;
  String? token;

  String get Email{
    return mail!;
  }
  String get Token{
    return token!;
  }
  String get IsCompany{
    return isCompany!;
  }

  Future<void> register(String email, String password, ) async {

    Future<void>fetchcompdetailsprv(mail)async{
      await Provider.of<companyDetailView>(context,listen: false).fetchDetails(email);
    }
    Future<void>fetchcompdetails2prv(mail)async{
      await Provider.of<companyReviews>(context,listen: false).delete();
      await Provider.of<companyReviews>(context,listen: false).fetchReviews(email);
    }
    Future<void>fetchcompjobsprv(mail)async{
      await Provider.of<companyJobs>(context,listen: false).fetchjobs(email);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => companyPrivateProfile()),);
    }

    String islogd="";
    Future<void>fetchHomedetails()async{
      final prefs= await SharedPreferences.getInstance();
      islogd=prefs.getString('mail')!;
      await Provider.of<homeView>(context,listen: false).fetchhomeDetails('','',islogd);
      print("-------------> The Email of logged: $islogd ");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => realHomeScreen()),);
    }
    if (_EmailValidation == null && _PasswordValidation == null ) {
      setState(() {
        _isloading = true;
      });
      final String url =
          'https://workinn.herokuapp.com/api/account/login/';
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }),
      );
      print(jsonDecode(response.body));
      setState(() {
        _isloading = false;
      });
      if (jsonDecode(response.body)['response'] == 'success') {
    //     {response: success,
    // pk: 102, email: company@dodo.com,
    // token: 52a2026e2189cdd040d9916621b4c50271ecc3cf,
    // is_verified: false,
    // is_company: true,
    // firstname: dodo,
    // lastname: comp,
    // profile_created: false}
        final prefs= await SharedPreferences.getInstance();
        prefs.setString('mail', jsonDecode(response.body)['email']);
        prefs.setString('token', jsonDecode(response.body)['token']);
        prefs.setString('isCompany', jsonDecode(response.body)['is_company'].toString());
        mail=jsonDecode(response.body)['email'];
        isCompany=jsonDecode(response.body)['is_company'].toString();
        token=jsonDecode(response.body)['token'];
        if(isCompany=='true'){
          fetchcompdetailsprv(mail);
          fetchcompdetails2prv(mail);
          fetchcompjobsprv(mail);
        }else if(isCompany=='false'){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => realHomeScreen()),);
        }else{}
      }
      else if (jsonDecode(response.body)['response'] == 'Error') {
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
    }
  }

}


// we will be creating a widget for text field


