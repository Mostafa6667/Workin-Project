import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workin_servive/constants.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Screens2/AppliedUserScreen.dart';
import '../Screens2/EmployingScreen.dart';
import '../Screens2/InviteUsersScreen.dart';
import '../controllers/AppliedUser.dart';
import '../controllers/InviteUsers.dart';
import '../controllers/companyPrivateReview.dart';
import '../controllers/companyPublicProfile.dart';
import '../controllers/company_getJobs.dart';
import '../controllers/editJob.dart';

import 'OnboardUpdate.dart';
import 'employingScreenUpdate.dart';
import 'home_Screen.dart';

class companyPrivateProfile extends StatefulWidget {
  const companyPrivateProfile({Key? key}) : super(key: key);


  @override
  _companyPrivateProfileState createState() => _companyPrivateProfileState();
}

class _companyPrivateProfileState extends State<companyPrivateProfile> {


  double? rating;
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
    if(img==null&&Provider.of<companyDetailView>(context,listen: false).logo==''){
      return Container(
          color: backgroundcolor,
          width: MediaQuery.of(context).size.width*0.25,
          height: MediaQuery.of(context).size.width*0.25,
          child: Icon(Icons.laptop_windows_sharp,size: 45.0,color: Colors.black,)
      );
    }else if(img!=null){
      return Container(

          child: Image.file(img!,width: MediaQuery.of(context).size.width*0.2,
            height: MediaQuery.of(context).size.width*0.2,
            fit: BoxFit.cover,)
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
    var uri = Uri.parse('https://workinn.herokuapp.com/api/company/upload_logo?email=$mail');

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('logo', stream, length,
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
      String logo=res['logo'];
      print(logo);





      setState(() {
        _isLoading=false;
      });


    });
  }
  Widget uploaded(BuildContext context){
    return Container(
      child: Image.network(Provider.of<companyDetailView>(context,listen: false).logo,
        width: MediaQuery.of(context).size.width*0.2,height: MediaQuery.of(context).size.width*0.2,
        fit: BoxFit.cover,),
    );
  }


  final GlobalKey<ScaffoldState> _thekey = GlobalKey<ScaffoldState>();
  int id=0;
  Future<void>getEdit(int jobid,BuildContext context)async{
    await Provider.of<Edit>(context,listen: false).fetchEditJob(jobid);
    Navigator.push(context, MaterialPageRoute(builder: (context) => EmployingScreenUpdate(),));
  }
  int huntid=0;
  Future<void>hunt(int id,BuildContext context)async{
    await Provider.of<InviteUserView>(context,listen: false).delete();
    await Provider.of<InviteUserView>(context,listen: false).fetchInviteUsers(id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => inviteUsersScreen(),));

  }
  int appliedid=0;
  Future<void>applied(int id,BuildContext context)async{
    await Provider.of<AppliedUserView>(context,listen: false).fetchAppliedUsers(id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => appliedUsersScreen(),));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _thekey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            _thekey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        automaticallyImplyLeading: false,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              flex: 5,
              fit: FlexFit.loose,
              child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
            Text('${Provider.of<companyDetailView>(context,listen: false).name}',style: GoogleFonts.nunito(fontSize: 25,color: Colors.white),),
            ])),
            Flexible(
              flex: 5,
              child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 15,),
                GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: showPicked(context)
                ),

                ElevatedButton(onPressed: ()async {
                  final prefs=await SharedPreferences.getInstance();
                  await upload(image!,prefs.getString('mail')!);
                  // Image.network(thelogo!);
                }, child: Text('Upload Image',style: TextStyle(color: Colors.black),),style: ElevatedButton.styleFrom(primary:Colors.white,minimumSize: Size(70, 20)),)
              ],
            )),
            if(_isLoading)CircularProgressIndicator(),
            SizedBox(width: MediaQuery.of(context).size.width*0.1,),

          ],
        ) ,
        backgroundColor: primarycolor,
        toolbarHeight: MediaQuery.of(context).size.height*0.18,
      ),
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
                    color: backgroundcolor,
                ),padding: EdgeInsets.all(5),),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
        body: DefaultTabController(
          length:3,
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.1),
                child: Material(
                  color: backgroundcolor,
                  child: TabBar(
                    labelColor: primarycolor,
                    indicatorColor: primarycolor,
                    tabs: [
                      Tab(text: 'About'),
                      Tab(text: 'Reviews'),
                      Tab(text: 'Jobs'),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child:TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height*0.01),
                              Row(
                                children: [
                                  Text(
                                    'Website',
                                    style: GoogleFonts.nunito(fontSize: 18,decoration: TextDecoration.underline),
                                  ),


                                ],
                              ),
                              Container(
                                height: 30,
                                child: Text('${Provider.of<companyDetailView>(context, listen: false).website}',style: GoogleFonts.nunito(fontSize: 20),),

                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.001),
                              Row(
                                children: [
                                  Text(
                                    'company info',
                                    style: GoogleFonts.nunito(fontSize: 18,decoration: TextDecoration.underline),
                                  ),


                                ],
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxHeight: double.infinity
                                ),
                                child: Text('${Provider.of<companyDetailView>(context, listen: false).compinfo}',style:GoogleFonts.nunito(fontSize: 20) ,),

                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.01),
                              Row(
                                children: [
                                  Text(
                                    'Industry (field)',
                                    style: GoogleFonts.nunito(fontSize: 18,decoration: TextDecoration.underline),
                                  ),


                                ],
                              ),
                              Container(
                                  height: 30,
                                  child: Text('${Provider.of<companyDetailView>(context, listen: false).industry}',style: GoogleFonts.nunito(fontSize: 20,color: Colors.black),)
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.01),
                              Row(
                                children: [
                                  Text(
                                    'Location',
                                    style: GoogleFonts.nunito(fontSize: 18,decoration: TextDecoration.underline),
                                  ),


                                ],
                              ),
                              Container(
                                  constraints: BoxConstraints(
                                      maxHeight: double.infinity
                                  ),
                                  child: Text('${Provider.of<companyDetailView>(context, listen: false).location}',style: GoogleFonts.nunito(fontSize: 20),)
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.01),
                              Row(
                                children: [
                                  Text(
                                    'Other information',
                                    style: GoogleFonts.nunito(fontSize: 18,decoration: TextDecoration.underline),
                                  ),


                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.001),
                              Text('Type:  ${Provider.of<companyDetailView>(context, listen: false).type}',style: GoogleFonts.nunito(fontSize: 20),),
                              Text('Size:  ${Provider.of<companyDetailView>(context, listen: false).size}',style: GoogleFonts.nunito(fontSize: 20),),
                              Text('Founded:  ${Provider.of<companyDetailView>(context, listen: false).founded}',style: GoogleFonts.nunito(fontSize: 20),),
                              Text('Headquarter:  ${Provider.of<companyDetailView>(context, listen: false).headquarter}',style: GoogleFonts.nunito(fontSize: 20),),

                              Container(
                                  constraints: BoxConstraints(
                                      maxHeight: double.infinity
                                  ),
                                  child: Text('Specialities:  ${Provider.of<companyDetailView>(context, listen: false).specialities}',style: GoogleFonts.nunito(fontSize: 20),)),

                              SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                              Center(
                                child: ElevatedButton(onPressed:  () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardUpdate(),));
                                },style: ElevatedButton.styleFrom(primary: primarycolor), child: Text('Edit Profile',style: GoogleFonts.nunito(fontSize: 16,color: Colors.white),)
                                ),
                              )


                            ],
                          ),
                        ),
                      ),



                      ListView.builder(
                        itemCount: Provider.of<companyReviews>(context,listen: false).count,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              child: ListTile(
                                tileColor: backgroundcolor,
                                title: Container(
                                  constraints: BoxConstraints(maxHeight: double.infinity),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(color: Colors.black)
                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${Provider.of<companyReviews>(context,listen:false).user[index]}'),
                                            Text('${Provider.of<companyReviews>(context,listen:false).date[index]}'),
                                            RatingBarIndicator(
                                              itemBuilder: (context, _) {
                                                return Icon(Icons.star,color: Colors.amber,);

                                              },
                                              itemCount: 5,
                                              itemSize: 20,

                                              rating:Provider.of<companyReviews>(context,listen:false).rate[index],
                                            ),
                                            // RatingBar.builder(
                                            //
                                            //   itemSize: 15.0,
                                            //     initialRating: 0,
                                            //     minRating: 0,
                                            //     direction: Axis.horizontal,
                                            //     itemCount: 5,
                                            //
                                            //     itemBuilder: (context, _) =>Icon(
                                            //       Icons.star,
                                            //       color: Colors.amber,) ,
                                            //     onRatingUpdate: (rating){
                                            //       print(rating);
                                            //     }),
                                            Container(width:245,constraints: BoxConstraints(maxHeight: double.infinity),child: Text('${Provider.of<companyReviews>(context,listen:false).review[index]}',maxLines: 3,overflow: TextOverflow.ellipsis,)),


                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },),


                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0,left: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EmployingScreen(),));
                                }, child: Container(

                                width: 120,
                                child: Row(
                                  children: [
                                    Icon(Icons.add_circle_outline),
                                    Text('   '),
                                    Text('New Job',textAlign:TextAlign.center ,),

                                  ],
                                ),
                              ),style: ElevatedButton.styleFrom(primary: primarycolor,shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),),),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: Provider.of<companyJobs>(context,listen: false).count,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    child: ListTile(
                                      tileColor: backgroundcolor,
                                      title: Container(
                                        constraints: BoxConstraints(maxHeight: double.infinity),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex:7,
                                              fit: FlexFit.loose,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        appliedid=Provider.of<companyJobs>(context,listen:false).idis[index];
                                                        print(appliedid);
                                                        applied(appliedid, context);
                                                      },
                                                      child: Container(width:150,constraints: BoxConstraints(maxHeight: double.infinity),child: Text('${Provider.of<companyJobs>(context,listen:false).jobtitles[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold)))),
                                                  Text('${Provider.of<companyJobs>(context,listen:false).companyName}',style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.bold)),
                                                  Text('${Provider.of<companyJobs>(context,listen:false).companylocation}')
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              flex: 10,
                                              fit: FlexFit.tight,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text('${Provider.of<companyJobs>(context,listen:false).createdat[index].toString()}',style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.bold),),
                                                  Text('${Provider.of<companyJobs>(context,listen:false).jobtypes[index]}'),
                                                  Text('${Provider.of<companyJobs>(context,listen:false).applicants[index].toString()} applicants'),

                                                  ElevatedButton(onPressed: () {
                                                    huntid=Provider.of<companyJobs>(context,listen: false).idis[index];
                                                    print(huntid);
                                                    hunt(huntid, context);

                                                  }, child: Text('Hunt Now!'),style: ElevatedButton.styleFrom(primary: primarycolor,minimumSize: Size(70, 20)),),
                                                  // ElevatedButton(onPressed: () {
                                                  //   id=Provider.of<companyJobs>(context,listen: false).idis[index];
                                                  //   print(id);
                                                  //   getEdit(id, context);
                                                  //
                                                  //
                                                  // }, child: Text('Edit'),style: ElevatedButton.styleFrom(primary: primarycolor,minimumSize: Size(100, 20)),),
                                                  GestureDetector(
                                                    onTap: () {
                                                      id=Provider.of<companyJobs>(context,listen: false).idis[index];
                                                      print(id);
                                                      getEdit(id, context);
                                                    },
                                                    child: Text('Edit',style: GoogleFonts.nunito(fontSize: 20,color: Colors.black87),),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      );

  }
}