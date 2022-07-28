//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:workin_servive/controllers/AppliedUser.dart';
// import 'package:workin_servive/controllers/JobsAppliedFor.dart';
// import 'package:workin_servive/controllers/jobDetails.dart';
//
// import 'Screens1/companyProfileScreen_private.dart';
// import 'Screens1/companyProfileScreen_public.dart';
// import 'Screens1/home_Screen.dart';
// import 'Screens1/userPrivateProfile_Screen.dart';
// import 'Screens2/JobDetailsScreen.dart';
// import 'Screens2/JobsAppliedForScreen.dart';
// import 'Screens2/login.dart';
// import 'constants.dart';
// import 'controllers/InviteUsers.dart';
// import 'controllers/companyPrivateReview.dart';
// import 'controllers/companyPublicProfile.dart';
// import 'controllers/company_getJobs.dart';
// import 'controllers/homescreen_getjobs.dart';
// import 'controllers/userPrivateInfo.dart';
//
//
// class homeScreen extends StatefulWidget {
//   const homeScreen({Key? key}) : super(key: key);
//
//   @override
//   _homeScreenState createState() => _homeScreenState();
// }
//
// class _homeScreenState extends State<homeScreen> {
//
//   Future<void> fetchJobDetails() async{
//     await Provider.of<jobDetailView>(context,listen: false).fetchJobDetails();
//   Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => jobDetailsScreen()),);
// }
//   // Future<void> fetchAppliedUsers() async{
//   //   await Provider.of<AppliedUserView>(context,listen: false).fetchAppliedUsers();
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(builder: (context) => appliedUsersScreen()),);
//   // }
//   // Future<void> fetchInviteUsers() async{
//   //   await Provider.of<InviteUserView>(context,listen: false).fetchInviteUsers();
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(builder: (context) => inviteUsersScreen()),);
//   // }
//
//   Future<void> fetchJobsAppliedFor() async{
//     await Provider.of<jobsAppliedForView>(context,listen: false).fetchJobsAppliedForView();
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => jobsAppliedForScreen()),);
//   }
//
//   Future<void>fetchcompdetails()async{
//
//     await Provider.of<companyDetailView>(context,listen: false).fetchDetails('ana@comp.doda');
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(builder: (context) => companyPublicProfile()),);
//
//
//   }
//   Future<void>fetchHomedetails()async{
//
//     await Provider.of<homeView>(context,listen: false).fetchhomeDetails('','','');
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => realHomeScreen()),);
//
//
//   }
//   Future<void>fetchcompdetailsprv()async{
//
//     await Provider.of<companyDetailView>(context,listen: false).fetchDetails('ana@comp.doda');
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(builder: (context) => companyPrivateProfile()),);
//
//
//   }
//
//   Future<void>fetchcompdetails2()async{
//
//     await Provider.of<companyReviews>(context,listen: false).fetchReviews('ana@comp.doda');
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(builder: (context) => companyPrivateProfile()),);
//
//
//   }
//   Future<void>fetchcompdetails2prv()async{
//
//     await Provider.of<companyReviews>(context,listen: false).fetchReviews('ana@comp.doda');
//
//
//
//   }
//   Future<void>fetchcompjobs()async{
//
//     await Provider.of<companyJobs>(context,listen: false).fetchjobs('ana@comp.doda');
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => companyPublicProfile()),);
//
//
//   }
//   Future<void>fetchcompjobsprv()async{
//
//     await Provider.of<companyJobs>(context,listen: false).fetchjobs('ana@comp.doda');
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => companyPrivateProfile()),);
//
//
//   }
//   Future<void>fetchuserinfo(String email)async{
//
//     await Provider.of<userDetailView>(context,listen: false).fetchUserDetails(email);
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => userPrivateProfile()),);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body:SingleChildScrollView(
//       child:Center(
//
//         child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(height: 40,),
//           //Login Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => LogInScreen()),);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "Login Screen", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //Forget Password Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ForgotPass()),);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "ForgetPass Screen", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //Change Password Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ConfirmPassScreen()),);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "ChangePass Screen", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //Company Info Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Onboard()),);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "CompanyInfo Screen", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //Verification Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => VerficationScreen()),);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "Verification Screen", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //SignUp Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SignupScreen()),);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "SignUp Screen", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //Company SignUp Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => companySignupScreen()),);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "Company SignUp Screen", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //Company SignUp 2 Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => companySignupTwo()),);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "Company SignUp2 Screen", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //userCareerInfoScreen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => UserCompanyInfo()),);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "Career Info", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //Personal Info Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => personalInfoScreen()),);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "Personal Info", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //Upload CV Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CvUploadScreen()),);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "CV Upload", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //Job Detail Screen
//
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               fetchJobDetails();
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "Job Details", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//           SizedBox(height: 10,),
//
//           //Applied User Screen
//
//           // MaterialButton(
//           //   minWidth: 285,
//           //   color: primarycolor,
//           //   height: 50,
//           //   onPressed: () {
//           //     fetchAppliedUsers();
//           //   },
//           //   elevation: 0,
//           //   shape: RoundedRectangleBorder(
//           //     borderRadius: BorderRadius.circular(50),
//           //
//           //   ),
//           //   child: Text(
//           //       "Applied User", style: GoogleFonts.nunito(
//           //     fontSize: 18,
//           //     fontWeight: FontWeight.bold,
//           //     color: Colors.white,
//           //   )
//           //   ),
//           //
//           // ),
//
//           SizedBox(height: 10,),
//           //Jobs Applied For Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               fetchJobsAppliedFor();
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "Jobs Applied For", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//
//           SizedBox(height: 10,),
//           //Invite Users Screen
//           // MaterialButton(
//           //   minWidth: 285,
//           //   color: primarycolor,
//           //   height: 50,
//           //   onPressed: () {
//           //     fetchInviteUsers();
//           //   },
//           //   elevation: 0,
//           //   shape: RoundedRectangleBorder(
//           //     borderRadius: BorderRadius.circular(50),
//           //
//           //   ),
//           //   child: Text(
//           //       "Invite User", style: GoogleFonts.nunito(
//           //     fontSize: 18,
//           //     fontWeight: FontWeight.bold,
//           //     color: Colors.white,
//           //   )
//           //   ),
//           //
//           // ),
//
//           SizedBox(height: 10,),
//           //Company Public Profile
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               fetchcompdetails();
//               fetchcompdetails2();
//               fetchcompjobs();
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "Company Public Profile", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//
//           SizedBox(height: 10,),
//           //Company Private Profile
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               fetchcompdetailsprv();
//               fetchcompdetails2prv();
//               fetchcompjobsprv();
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "Company Private Profile", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//
//           SizedBox(height: 10,),
//           //User Private Profile
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () async{
//               SharedPreferences prefs =await SharedPreferences.getInstance();
//               fetchuserinfo(prefs.getString('usermail')!);
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "User Private Profile", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//
//           SizedBox(height: 10,),
//           //Home Screen
//           MaterialButton(
//             minWidth: 285,
//             color: primarycolor,
//             height: 50,
//             onPressed: () {
//               fetchHomedetails();
//             },
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(50),
//
//             ),
//             child: Text(
//                 "Home", style: GoogleFonts.nunito(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             )
//             ),
//
//           ),
//         ],
//       ),
//       ),
//       ),
//     );
//   }
// }
