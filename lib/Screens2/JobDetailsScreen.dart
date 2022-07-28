

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workin_servive/controllers/applyJob.dart';
import 'package:workin_servive/controllers/jobDetails.dart';

import '../Screens1/companyProfileScreen_public.dart';
import '../constants.dart';
import '../controllers/companyPrivateReview.dart';
import '../controllers/companyPublicProfile.dart';
import '../controllers/company_getJobs.dart';
import 'login.dart';

class jobDetailsScreen extends StatefulWidget {
  const jobDetailsScreen({Key? key}) : super(key: key);

  @override
  _jobDetailsScreenState createState() => _jobDetailsScreenState();
}

class _jobDetailsScreenState extends State<jobDetailsScreen> {
  int id=0;
  String mail='';
  String email='';

  Future <void> apply() async{
    final prefs=await SharedPreferences.getInstance();
    id=prefs.getInt('id')!;
    await Provider.of<jobDetailView>(context, listen: false).applyJobDetails(id);
  }
  Future<void>seecomp(String mail)async{
    Provider.of<companyJobs>(context,listen: false).delete();
    Provider.of<companyReviews>(context,listen: false).delete();
    await Provider.of<companyDetailView>(context,listen: false).fetchDetails(mail);
    await Provider.of<companyReviews>(context,listen: false).fetchReviews(mail);
    await Provider.of<companyJobs>(context,listen: false).fetchjobs(mail);
    Navigator.push(context, MaterialPageRoute(builder: (context) => companyPublicProfile(),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        mail=Provider.of<jobApply>(context,listen: false).mail;
                        seecomp(mail);
                      },
                      child: CircleAvatar(
                        radius: 51,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(Provider.of<jobApply>(context,listen: false).logo),
                      ),
                    ),
                  ),
                  Text(
                    "${Provider.of<jobApply>(context,listen: false).title}",
                    style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${Provider.of<jobApply>(context,listen: false).type} Job",
                    style: GoogleFonts.nunito(fontSize: 18,),
                  ),
                  Text(
                    "${Provider.of<jobApply>(context,listen: false).salary}EGP /Month",
                    style: GoogleFonts.nunito(fontSize: 18,),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Job Description",
                    style: GoogleFonts.nunito(fontSize: 18,),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${Provider.of<jobApply>(context,listen: false).description} ",
                    style: GoogleFonts.nunito(fontSize: 15,color: Colors.black,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Requirements",
                    style: GoogleFonts.nunito(fontSize: 18,),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${Provider.of<jobApply>(context,listen: false).requirements}",
                    style: GoogleFonts.nunito(fontSize: 15,color: Colors.black,),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  minWidth: 250,
                  color: primarycolor,
                  height: 50,
                  onPressed: ()  async{
                    final prefs=await SharedPreferences.getInstance();
                    email=prefs.getString('mail')!;
                    if(email==''){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen(),));
                    }else {
                      apply();
                    }
                  },
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),

                  ),
                  child: Text(
                      "Apply", style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
                  ),

                ),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ) ,
      ),
    );
  }
}

// class jobDetailsScreen extends StatefulWidget {
//   const jobDetailsScreen({Key? key}) : super(key: key);
//
//   @override
//   _jobDetailsScreenState createState() => _jobDetailsScreenState();
// }
//
// class _jobDetailsScreenState extends State<jobDetailsScreen> {
//
//   int id=0;
//
//   Future <void> apply() async{
//     final prefs=await SharedPreferences.getInstance();
//     id=prefs.getInt('id')!;
//     await Provider.of<jobDetailView>(context, listen: false).applyJobDetails(id);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:SingleChildScrollView(
//         child:Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 40,
//           ),
//         Container(
//           padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
//             child:Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children:[
//             Container(
//               child: CircleAvatar(
//                 radius: 51,
//                 backgroundColor: Colors.grey,
//                 backgroundImage: NetworkImage(Provider.of<jobDetailView>(context,listen: false).companyLogo),
//               ),
//             ),
//           Text(
//               "${Provider.of<jobDetailView>(context,listen: false).jobtitle}",
//             style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             "${Provider.of<jobDetailView>(context,listen: false).jobType} Job",
//             style: GoogleFonts.nunito(fontSize: 18,),
//           ),
//           Text(
//             "${Provider.of<jobDetailView>(context,listen: false).jobSalary}EGP /Month",
//             style: GoogleFonts.nunito(fontSize: 18,),
//           ),
//               ],
//             ),
//         ),
//           Container(
//             margin: const EdgeInsets.all(15.0),
//             padding: const EdgeInsets.all(3),
//             decoration: BoxDecoration(
//               color: Colors.white,
//                 border: Border.all(color: Colors.black)
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Job Description",
//                   style: GoogleFonts.nunito(fontSize: 18,),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "${Provider.of<jobApply>(context,listen: false).description} ",
//                   style: GoogleFonts.nunito(fontSize: 15,color: Colors.black,),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   "Requirements",
//                   style: GoogleFonts.nunito(fontSize: 18,),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "${Provider.of<jobDetailView>(context,listen: false).jobRequirements}",
//                   style: GoogleFonts.nunito(fontSize: 15,color: Colors.black,),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               MaterialButton(
//                 minWidth: 250,
//                 color: primarycolor,
//                 height: 50,
//                 onPressed: ()  {
//                   apply();
//                 },
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//
//                 ),
//                 child: Text(
//                     "Apply", style: GoogleFonts.nunito(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 )
//                 ),
//
//               ),
//             ],
//           ),
//         ],
//       ) ,
//       ),
//     );
//   }
// }
