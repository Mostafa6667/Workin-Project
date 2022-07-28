import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workin_servive/Screens1/personalInfo2_Screen.dart';
import 'package:workin_servive/constants.dart';
import 'dart:core';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Screens2/JobsAppliedForScreen.dart';
import '../controllers/JobsAppliedFor.dart';
import '../controllers/userPrivateInfo.dart';
import 'home_Screen.dart';

class userPrivateProfile extends StatefulWidget {
  const userPrivateProfile({Key? key}) : super(key: key);


  @override
  _userPrivateProfileState createState() => _userPrivateProfileState();
}



class _userPrivateProfileState extends State<userPrivateProfile> {
  List<String>skills=['dhushd','sgiyagf','fvysabfua'];
  List<Chip>chips=[];
  @override
  void initState() {

    for(var i in skills){
      chips.add(Chip(label: Text('Skill')));

    }
    setState(() {

    });
  }
  XFile? image ;
  File? img;
  var _isLoading = false;
  Future pickImage()async{
    final ImagePicker _picker = ImagePicker();
    image = await _picker.pickImage(source: ImageSource.gallery);
    img=File(image!.path);

    setState(() {

    });
  }
  Widget showPicked(BuildContext context){
    if(img==null&&Provider.of<userDetailView>(context,listen: false).picture==''){
      return CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          child: Icon(Icons.person,size: 45.0,color: Colors.black,));
    }else if(img!=null){
      return CircleAvatar(
        radius: 50,
        backgroundImage:FileImage(img!,),
      );
    }else{
      return uploaded(context);
    }


  }
  upload(XFile imageFile,String mail) async {
    setState(() {
      _isLoading=true;
    });
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse('https://workinn.herokuapp.com/api/account/upload_picture?email=$mail');

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('picture', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response);






    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      var res=json.decode(value);
      String picture=res['picture'];
      print(picture);


      setState(() {
        _isLoading=false;
      });


    });
  }
  Widget uploaded(BuildContext context){
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(Provider.of<userDetailView>(context,listen: false).picture,
      ),
    );
  }
  final GlobalKey<ScaffoldState> _key=GlobalKey<ScaffoldState>();


  Future<void>jobsapplied(BuildContext context)async{
    await Provider.of<jobsAppliedForView>(context,listen: false).fetchJobsAppliedForView();
    Navigator.push(context, MaterialPageRoute(builder: (context) => jobsAppliedForScreen(),));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer:Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.077,
              decoration: BoxDecoration(
                  border:Border.all(color: Colors.black)
              ),
              child: DrawerHeader(child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(onPressed: () {

                  }, child: Text('Main Menu',style: GoogleFonts.nunito(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),))
                ],
              ),decoration: BoxDecoration(
                  color: backgroundcolor
              ),padding: EdgeInsets.all(5),),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => realHomeScreen(),));
                }, child: Text('Home',style: GoogleFonts.nunito(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => personalInfoScreen2(),));

                }, child: Text('Edit Profile',style: GoogleFonts.nunito(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                TextButton(onPressed: () {
                  jobsapplied(context);
                }, child: Text('Jobs Applied For',style: GoogleFonts.nunito(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                TextButton(onPressed: () async{
                  final prefs= await SharedPreferences.getInstance();
                  prefs.setString('mail','');
                  prefs.setString('token','');
                  prefs.setString('isCompany','');
                  Navigator.of(context).pushAndRemoveUntil(
                    // the new route
                    MaterialPageRoute(
                      builder: (BuildContext context) => realHomeScreen(),
                    ),

                    // this function should return true when we're done removing routes
                    // but because we want to remove all other screens, we make it
                    // always return false
                        (Route route) => false,
                  );
                }, child: Text('Logout',style: GoogleFonts.nunito(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(padding:const EdgeInsets.all(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    IconButton(onPressed: () {
                      _key.currentState!.openDrawer();
                    }, icon: Icon(Icons.menu))
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.width*0.1,),
                GestureDetector(
                  onTap: (){
                    pickImage();
                  },
                  child: showPicked(context),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                if(_isLoading)CircularProgressIndicator(),
                ElevatedButton(onPressed: () async{
                  final prefs=await SharedPreferences.getInstance();
                  await upload(image!, prefs.getString('mail')!,);
                }, child: Text('Upload Image'),style: ElevatedButton.styleFrom(primary: primarycolor),),

                Text('${Provider.of<userDetailView>(context,listen:false).fname+' '+Provider.of<userDetailView>(context,listen:false).lname}',style: GoogleFonts.nunito(fontSize: 26,fontWeight: FontWeight.bold),),
                Text('${Provider.of<userDetailView>(context,listen:false).careerlevel+' '+Provider.of<userDetailView>(context,listen:false).jobtitle}',style: GoogleFonts.nunito(fontSize: 25,color: Colors.grey),),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ),

                Container(constraints:BoxConstraints(
                    maxHeight: double.infinity
                ),child: Text('${Provider.of<userDetailView>(context,listen:false).about}',style: GoogleFonts.nunito(fontSize: 17),textAlign: TextAlign.start,)),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Educational Background',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Flexible(
                      flex: 10,
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${Provider.of<userDetailView>(context,listen:false).uni}',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),Flexible(
                      flex: 7,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          Text('${Provider.of<userDetailView>(context,listen:false).yearofgrad.toString()}',style: GoogleFonts.nunito(fontSize: 17),),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Major:  ',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),Text('${Provider.of<userDetailView>(context,listen:false).major}',style: GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('GPA:  ',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),Text('${Provider.of<userDetailView>(context,listen:false).gpa}',style: GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.bold),)
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Level:  ',style:GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold),),Text('${Provider.of<userDetailView>(context,listen:false).educationlevel}',style: GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.bold),)
                  ],
                ),

                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Work History',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [

                    Text('Years of Experience:  ',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),Text('${Provider.of<userDetailView>(context,listen:false).yearsofexperience.toString()} years',style: GoogleFonts.nunito(fontSize: 17),)
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Skills',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10,),
                Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 5,
                    children: List<Widget>.generate(Provider.of<userDetailView>(context,listen:false).count, (index){
                      return Chip(label: Text('${Provider.of<userDetailView>(context,listen:false).skill[index]}'),backgroundColor: backgroundcolor,side:BorderSide(color: Colors.black) ,);
                    })
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Languages',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10,),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('${Provider.of<userDetailView>(context,listen:false).languages}:  ',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),Text('${Provider.of<userDetailView>(context,listen:false).languagelevel}',style: GoogleFonts.nunito(fontSize: 17),)
                  ],
                ),
                SizedBox(height: 10,),



              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class userPrivateProfile extends StatefulWidget {
//   const userPrivateProfile({Key? key}) : super(key: key);
//
//
//   @override
//   _userPrivateProfileState createState() => _userPrivateProfileState();
// }
//
//
//
// class _userPrivateProfileState extends State<userPrivateProfile> {
//   List<String>skills=['dhushd','sgiyagf','fvysabfua'];
//   List<Chip>chips=[];
//   @override
//   void initState() {
//
//     for(var i in skills){
//       chips.add(Chip(label: Text('Skill')));
//
//     }
//     setState(() {
//
//     });
//   }
//   XFile? image ;
//   File? img;
//   var _isLoading = false;
//   Future pickImage()async{
//     final ImagePicker _picker = ImagePicker();
//     image = await _picker.pickImage(source: ImageSource.gallery);
//     img=File(image!.path);
//
//     setState(() {
//
//     });
//   }
//   Widget showPicked(BuildContext context){
//     if(img==null&&Provider.of<userDetailView>(context,listen: false).picture==''){
//       return CircleAvatar(
//           radius: 50,
//           backgroundColor: Colors.grey,
//           child: Icon(Icons.person,size: 45.0,color: Colors.black,));
//     }else if(img!=null){
//       return CircleAvatar(
//         radius: 50,
//         backgroundImage:FileImage(img!,),
//       );
//     }else{
//       return uploaded(context);
//     }
//
//
//   }
//   upload(XFile imageFile,String mail) async {
//     setState(() {
//       _isLoading=true;
//     });
//     // open a bytestream
//     var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
//     // get file length
//     var length = await imageFile.length();
//
//     // string to uri
//     var uri = Uri.parse('https://workinn.herokuapp.com/api/account/upload_picture?email=$mail');
//
//     // create multipart request
//     var request = new http.MultipartRequest("POST", uri);
//
//     // multipart that takes file
//     var multipartFile = new http.MultipartFile('picture', stream, length,
//         filename: basename(imageFile.path));
//
//     // add file to multipart
//     request.files.add(multipartFile);
//
//     // send
//     var response = await request.send();
//     print(response);
//
//
//
//
//
//
//     // listen for response
//     response.stream.transform(utf8.decoder).listen((value) {
//       print(value);
//       var res=json.decode(value);
//       String picture=res['picture'];
//       print(picture);
//
//
//       setState(() {
//         _isLoading=false;
//       });
//
//
//     });
//   }
//   Widget uploaded(BuildContext context){
//     return CircleAvatar(
//       radius: 50,
//       backgroundImage: NetworkImage(Provider.of<userDetailView>(context,listen: false).picture,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(padding:const EdgeInsets.all(20),
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               children: [
//                 SizedBox(height: 20,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//
//                     GestureDetector(
//                         onTap: () {
//
//                         },
//                         child: Text('Edit Profile',style: GoogleFonts.nunito(fontSize: 20),))
//                   ],
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.width*0.1,),
//                 GestureDetector(
//                   onTap: (){
//                     pickImage();
//                   },
//                   child: showPicked(context),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height*0.01,),
//                 if(_isLoading)CircularProgressIndicator(),
//                 ElevatedButton(onPressed: () async{
//                   final prefs=await SharedPreferences.getInstance();
//                   await upload(image!, prefs.getString('usermail')!,);
//                 }, child: Text('Upload Image'),style: ElevatedButton.styleFrom(primary: primarycolor),),
//
//                 Text('${Provider.of<userDetailView>(context,listen:false).fname+' '+Provider.of<userDetailView>(context,listen:false).lname}',style: GoogleFonts.nunito(fontSize: 26,fontWeight: FontWeight.bold),),
//                 Text('${Provider.of<userDetailView>(context,listen:false).careerlevel+' '+Provider.of<userDetailView>(context,listen:false).jobtitle}',style: GoogleFonts.nunito(fontSize: 25,color: Colors.grey),),
//                 SizedBox(height: 10,),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('About',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold),),
//                   ],
//                 ),
//
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('${Provider.of<userDetailView>(context,listen:false).about}',style: GoogleFonts.nunito(fontSize: 17),textAlign: TextAlign.start,),
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Educational Background',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 Row(
//                   children: [
//                     Text('${Provider.of<userDetailView>(context,listen:false).uni}',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),SizedBox(width: MediaQuery.of(context).size.width*0.38,),Text('${Provider.of<userDetailView>(context,listen:false).yearofgrad.toString()}',style: GoogleFonts.nunito(fontSize: 17),)
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 Row(
//                   children: [
//                     Text('Major:  ',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),Text('${Provider.of<userDetailView>(context,listen:false).major}',style: GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.bold),)
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 Row(
//                   children: [
//                     Text('GPA:  ',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),Text('${Provider.of<userDetailView>(context,listen:false).gpa}',style: GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.bold),)
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 Row(
//                   children: [
//                     Text('Level:  ',style:GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold),),Text('${Provider.of<userDetailView>(context,listen:false).educationlevel}',style: GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.bold),)
//                   ],
//                 ),
//
//                 SizedBox(height: 10,),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Work History',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 Row(
//                   children: [
//
//                     Text('Years of Experience:  ',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),Text('${Provider.of<userDetailView>(context,listen:false).yearsofexperience.toString()} years',style: GoogleFonts.nunito(fontSize: 17),)
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Skills',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 Wrap(
//                     alignment: WrapAlignment.start,
//                     spacing: 5,
//                     children: List<Widget>.generate(Provider.of<userDetailView>(context,listen:false).count, (index){
//                       return Chip(label: Text('${Provider.of<userDetailView>(context,listen:false).skill[index]}'),backgroundColor: backgroundcolor,side:BorderSide(color: Colors.black) ,);
//                     })
//                 ),
//                 SizedBox(height: 10,),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Languages',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//                 SizedBox(height: 10,),
//                 Row(
//                   children: [
//                     Text('${Provider.of<userDetailView>(context,listen:false).languages}:  ',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),Text('${Provider.of<userDetailView>(context,listen:false).languagelevel}',style: GoogleFonts.nunito(fontSize: 17),)
//                   ],
//                 ),
//                 SizedBox(height: 10,),
//
//
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }