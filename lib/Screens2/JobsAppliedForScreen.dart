import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workin_servive/controllers/JobsAppliedFor.dart';


import '../Screens1/companyProfileScreen_public.dart';
import '../Screens1/home_Screen.dart';
import '../constants.dart';
import '../controllers/companyPrivateReview.dart';
import '../controllers/companyPublicProfile.dart';
import '../controllers/company_getJobs.dart';
class jobsAppliedForScreen extends StatefulWidget {
  const jobsAppliedForScreen({Key? key}) : super(key: key);

  @override
  _jobsAppliedForScreenState createState() => _jobsAppliedForScreenState();
}

class _jobsAppliedForScreenState extends State<jobsAppliedForScreen> {

  String mail='';
  Future<void>gotocomp(mail)async{
    Provider.of<companyReviews>(context,listen: false).delete();
    Provider.of<companyJobs>(context,listen: false).delete();
    await Provider.of<companyDetailView>(context,listen: false).fetchDetails(mail);
    await Provider.of<companyReviews>(context,listen: false).fetchReviews(mail);
    await Provider.of<companyJobs>(context,listen: false).fetchjobs(mail);
    Navigator.push(context, MaterialPageRoute(builder: (context) => companyPublicProfile(),));


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
            Text('Jobs Applied For',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
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
                  color: backgroundcolor,
              ),padding: EdgeInsets.all(5),),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => realHomeScreen(),));
                }, child: Text('Home',style: GoogleFonts.nunito(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
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
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: Provider.of<jobsAppliedForView>(context,listen: false).togetcount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: ListTile(
                        tileColor: Color(0xfff3f3f3),
                        title: Container(
                          constraints: BoxConstraints(
                              maxHeight: double.infinity
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Flexible(
                                flex: 7,
                                fit: FlexFit.loose,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(width:150,constraints: BoxConstraints(maxHeight: double.infinity),
                                        child: Text('${Provider.of<jobsAppliedForView>(context,listen: false).ToGetJobTitle[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo))),
                                    GestureDetector(
                                        onTap: () {
                                          mail=Provider.of<jobsAppliedForView>(context,listen: false).ToGetmail[index];
                                          gotocomp(mail);
                                          print(mail);
                                        },
                                        child: Text('${Provider.of<jobsAppliedForView>(context,listen: false).ToGetCompanyName[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold))),
                                    Text('Cairo,Egypt',style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.bold)),

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
                                    Text('${Provider.of<jobsAppliedForView>(context,listen: false).ToGetDate[index]}',style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.bold),),
                                    Text('${Provider.of<jobsAppliedForView>(context,listen: false).ToGetJobType[index]}'),
                                    Text('${Provider.of<jobsAppliedForView>(context,listen: false).ToGetApplicantsCount[index]} applicants'),
                                    ElevatedButton(onPressed:null,child: Text('Applied'),style: ElevatedButton.styleFrom(primary: backgroundcolor,minimumSize: Size(70, 20)))
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