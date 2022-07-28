import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workin_servive/Screens1/search.dart';
import 'package:workin_servive/Screens1/userPrivateProfile_Screen.dart';


import '../Screens2/JobDetailsScreen.dart';
import '../constants.dart';
import '../controllers/applyJob.dart';
import '../controllers/companyPrivateReview.dart';
import '../controllers/companyPublicProfile.dart';
import '../controllers/company_getJobs.dart';
import '../controllers/homescreen_getjobs.dart';
import '../controllers/userPrivateInfo.dart';
import 'companyProfileScreen_public.dart';
import 'companySignup_screen.dart';
import 'filters_screen.dart';
import 'home_Screen.dart';
class homeJobList extends StatefulWidget {
  const homeJobList({Key? key}) : super(key: key);

  @override
  _homeJobListState createState() => _homeJobListState();
}

class _homeJobListState extends State<homeJobList> {
  // List<String>jobs=['Software Engineer','Flutter Developer','.net developer','hey','ehhh','eheheheh',];
  // List<String>categories=['Software Engineer','Flutter Developer','.net developer','hey',];
  // List<String>resjobs=['Software Engineer','Flutter Developer','.net developer'];
  // String job='';
  // String job2='';
  // Future<void> _showSearch() async {
  //   await showSearch(
  //     context: context,
  //     delegate: mySearchDelegate(),
  //     query: "any query",
  //   );
  // }

  String? login;
  int id=0;
  int applyid=0;
  String mail='';
  Future<void>apply(int id)async{
    await Provider.of<jobApply>(context,listen: false).See(id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => jobDetailsScreen(),));
  }
  Future<void>seecomp(String mail)async{
    Provider.of<companyReviews>(context,listen: false).delete();
    Provider.of<companyJobs>(context,listen: false).delete();
    await Provider.of<companyDetailView>(context,listen: false).fetchDetails(mail);
    await Provider.of<companyReviews>(context,listen: false).fetchReviews(mail);
    await Provider.of<companyJobs>(context,listen: false).fetchjobs(mail);
    Navigator.push(context, MaterialPageRoute(builder: (context) => companyPublicProfile(),));

  }
  Future<String>getprefs()async{
    final prefs= await SharedPreferences.getInstance();
    login=prefs.getString('mail')!;
    return login!;

  }

  Future<void>fetchuserinfo(String email)async{

    await Provider.of<userDetailView>(context,listen: false).fetchUserDetails(email);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => userPrivateProfile()),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: Border(
            bottom: BorderSide(
              color: Colors.black,
            )
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: backgroundcolor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: Column(
                children: [
                  Text('Latest Work-in Jobs',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                ],
              ),
            ),

            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(onPressed: () async{
                    await showSearch(context: context, delegate: searchit());


                  }, icon: Icon(Icons.search)),
                ],
              ),
            )


          ],
        ),

      ),
      drawer: Drawer(
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

                FutureBuilder(
                  future: getprefs(),
                  builder: (BuildContext context,AsyncSnapshot snapshot){
                    if(snapshot.data==''){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => realHomeScreen(),));

                          }, child: Text('Home',style: GoogleFonts.nunito(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                          TextButton(onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => companySignupScreen()),);

                          }, child: Text('Start Hiring',style: GoogleFonts.nunito(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),//start hiring
                        ],
                      );

                    }else{
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => realHomeScreen(),));
                          }, child: Text('Home',style: GoogleFonts.nunito(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),

                          TextButton(onPressed: () async{
                            SharedPreferences prefs =await SharedPreferences.getInstance();
                            fetchuserinfo(prefs.getString('mail')!);
                          }, child: Text('My Profile',style: GoogleFonts.nunito(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),//my profile

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
                          }, child: Text('Logout',style: GoogleFonts.nunito(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),//logout
                        ],
                      );
                    }
                  },
                ),



              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              // Row(children: [
              //   ElevatedButton(onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => filterScreen(),));
              //   }, child: Row(children: [
              //     Icon(Icons.filter_list_outlined,color: Colors.black,),Text('Filters',style: GoogleFonts.nunito(color: Colors.black),)
              //   ],),style: ElevatedButton.styleFrom(primary: Colors.white,side: BorderSide(color: Colors.black)), ),
              //   SizedBox(width: 200,),
              //   Text('${Provider.of<homeView>(context,listen: false).count.toString()} Jobs Found'),
              // ],),
              Row(
                children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.loose,
                  child: Column(
                    children: [
                      ElevatedButton(

                        onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => filterScreen(),));
                      }, child: Row(children: [
                        Icon(Icons.filter_list_outlined,color: Colors.black,),Text('Filters',style: GoogleFonts.nunito(color: Colors.black),)
                      ],),style: ElevatedButton.styleFrom(primary: Colors.white,side: BorderSide(color: Colors.black)), ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 7,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${Provider.of<homeView>(context,listen: false).count.toString()} Jobs found'),
                    ],
                  ),
                ),
              ],),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: Provider.of<homeView>(context,listen: false).count,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: ListTile(
                        tileColor: backgroundcolor,
                        title: Container(
                          constraints: BoxConstraints(
                              maxHeight: double.infinity
                          ),
                          child: Row(
                            children: [

                              Flexible(
                                flex: 7,
                                fit: FlexFit.loose,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(width:150,constraints: BoxConstraints(maxHeight: double.infinity),child: Text('${Provider.of<homeView>(context,listen: false).jobtitle[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo))),
                                    GestureDetector(
                                        onTap: () {
                                          mail=Provider.of<homeView>(context,listen: false).mail[index];
                                          print(mail);
                                          seecomp(mail);
                                        },
                                        child: Text('${Provider.of<homeView>(context,listen: false).compname[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold))),
                                    Text('${Provider.of<homeView>(context,listen: false).location[index]}',style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.bold)),

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
                                    Text('${Provider.of<homeView>(context,listen: false).createdat[index]}',style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.bold),),
                                    Text('${Provider.of<homeView>(context,listen: false).jobtype[index]}'),
                                    Text('${Provider.of<homeView>(context,listen: false).applicantscount[index].toString()} applicants'),
                                    ElevatedButton(
                                        onPressed: () async{
                                          final prefs=await SharedPreferences.getInstance();
                                          id=Provider.of<homeView>(context,listen: false).jobidis[index];
                                          prefs.setInt('id', id);

                                          print(id);
                                          apply(id);

                                        }, child: Text('Apply'),style:ElevatedButton.styleFrom(primary:primarycolor,minimumSize: Size(70, 20)))
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
      ),
    );
  }
}