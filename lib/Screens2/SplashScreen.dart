


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workin_servive/controllers/companySignup.dart';


import '../Screens1/companyProfileScreen_private.dart';
import '../Screens1/home_Screen.dart';
import '../controllers/homescreen_getjobs.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => new _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  // String islogd="";
  // Future <String> isLoged()async{
  //   final prefs= await SharedPreferences.getInstance();
  //   islogd=prefs.getString('logedmail')!;
  //   print("-------------> The Email of logged: $islogd ");
  //   if(islogd==""){
  //     return '';
  //   }else{
  //     return islogd;
  //   }
  // }

  _delay()async{
    final prefs= await SharedPreferences.getInstance();
    if(prefs.getString('isCompany').toString()=='true'){
      await Future.delayed(Duration(seconds: 1),(){});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => companyPrivateProfile()),);
    }else{
      await Future.delayed(Duration(seconds: 1),(){});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => realHomeScreen()),);
    }

    }

  //}
  // Future<void>fetchHomedetails()async{
  //   _delay();
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => realHomeScreen()),);
  // }

  // Future<Widget> loadFromFuture() async {
  //
  //   // <fetch data from server. ex. login>
  //
  //   return Future.value(new AfterSplash());
  // }

  void initState(){
    super.initState();
    _delay();
    // fetchHomedetails();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.blueGrey[800],
       body: Center(
         child:Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Image.asset('assets/images/white workin.png'),

         ],
         ),
       ),
     );
    // new SplashScreen(
    //     navigateAfterFuture: fetchHomedetails(),
    //     title: new Text('Work In',
    //       style: new TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 20.0
    //       ),),
    //     image: Image.asset('assets/images/Artboard 3.png'),
    //     backgroundColor: Colors.blueGrey[800],
    //     styleTextUnderTheLoader: new TextStyle(),
    //     photoSize: 100.0,
    //     onClick: ()=>print("Welcome"),
    //     loaderColor: Colors.white,
    // );
  }
}