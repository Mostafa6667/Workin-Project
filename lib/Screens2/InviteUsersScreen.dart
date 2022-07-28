

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workin_servive/controllers/InviteUsers.dart';

import '../constants.dart';



class inviteUsersScreen extends StatefulWidget {
  const inviteUsersScreen({Key? key}) : super(key: key);

  @override
  _inviteUsersScreenState createState() => _inviteUsersScreenState();
}

class _inviteUsersScreenState extends State<inviteUsersScreen> {

  String invite="invite";
  String email="";
  String id='';

  Future <void> Decision(String email, String decision,String id) async{
    await Provider.of<InviteUserView>(context, listen: false).applyInviteUserDecision(email, decision,id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[

                  Container(
                    child: CircleAvatar(
                      radius: 51,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(Provider.of<InviteUserView>(context,listen: false).companyLogo),
                    ),
                  ),
                  Text(
                    "${Provider.of<InviteUserView>(context,listen: false).jobtitle}",//${Provider.of<jobDetailView>(context,listen: false).jobtitle}",
                    style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${Provider.of<InviteUserView>(context,listen: false).jobType}",//${Provider.of<jobDetailView>(context,listen: false).jobType} Job",
                    style: GoogleFonts.nunito(fontSize: 18,),
                  ),
                  Text(
                    "${Provider.of<InviteUserView>(context,listen: false).jobSalary}",//${Provider.of<jobDetailView>(context,listen: false).jobType} Job",
                    style: GoogleFonts.nunito(fontSize: 18,),
                  ),
                  Text(
                    "Recommended Users",//${Provider.of<jobDetailView>(context,listen: false).jobType} Job",
                    style: GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),
                  ),


                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: Provider.of<InviteUserView>(context,listen: false).count,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                    child: ListTile(
                      tileColor: backgroundcolor,
                      title: Container(
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(flex:2,fit: FlexFit.loose,child:CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              // backgroundImage: NetworkImage(Provider.of<InviteUserView>(context, listen: false).ToGetPicture[index]),
                            ), ),
                            SizedBox(width: 5,),
                            Flexible(flex:7,fit: FlexFit.tight,child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${Provider.of<InviteUserView>(context, listen: false).ToGetFirstName[index]} ${Provider.of<InviteUserView>(context, listen: false).ToGetLastName[index]}',style: GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.bold)),
                                Text('${Provider.of<InviteUserView>(context, listen: false).ToGetuserJobTitle[index]}',style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.bold)),
                                Text('${Provider.of<InviteUserView>(context, listen: false).ToGetLocation[index]}',style: GoogleFonts.nunito(fontSize: 15,)),
                              ],
                            ),),

                            Flexible(
                              flex: 0,
                              fit: FlexFit.loose,
                              //padding: const EdgeInsets.only(left: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15,),
                                  ElevatedButton(
                                    onPressed: () {
                                      email='${Provider.of<InviteUserView>(context, listen: false).ToGetEmail[index]}';
                                      id=Provider.of<InviteUserView>(context,listen: false).id;
                                      print(id);
                                      print("------------>$email");

                                      Decision(email, invite,id);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(primarycolor),
                                      //minimumSize:MaterialStateProperty.<Size>(88,30)) ,
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                          )),
                                    ),
                                    child:Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        Text(
                                            "Invite", style: GoogleFonts.nunito(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
    );
  }
}

// class inviteUsersScreen extends StatefulWidget {
//   const inviteUsersScreen({Key? key}) : super(key: key);
//
//   @override
//   _inviteUsersScreenState createState() => _inviteUsersScreenState();
// }
//
// class _inviteUsersScreenState extends State<inviteUsersScreen> {
//
//   String invite="invite";
//   String email="";
//
//   Future <void> Decision(String email, String decision) async{
//     await Provider.of<InviteUserView>(context, listen: false).applyInviteUserDecision(email, decision);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 40,),
//             Container(
//               padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
//               child:Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
//                   Container(
//                     child: CircleAvatar(
//                       radius: 51,
//                       backgroundColor: Colors.grey,
//                       backgroundImage: NetworkImage(Provider.of<InviteUserView>(context,listen: false).companyLogo),
//                     ),
//                   ),
//                   Text(
//                     "${Provider.of<InviteUserView>(context,listen: false).jobtitle}",//${Provider.of<jobDetailView>(context,listen: false).jobtitle}",
//                     style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     "${Provider.of<InviteUserView>(context,listen: false).jobType}",//${Provider.of<jobDetailView>(context,listen: false).jobType} Job",
//                     style: GoogleFonts.nunito(fontSize: 18,),
//                   ),
//                   Text(
//                     "${Provider.of<InviteUserView>(context,listen: false).jobSalary}",//${Provider.of<jobDetailView>(context,listen: false).jobType} Job",
//                     style: GoogleFonts.nunito(fontSize: 18,),
//                   ),
//                   Text(
//                     "Recommended Users",//${Provider.of<jobDetailView>(context,listen: false).jobType} Job",
//                     style: GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),
//                   ),
//
//
//                 ],
//               ),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: Provider.of<InviteUserView>(context,listen: false).count,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: Card(
//                     child: ListTile(
//                       tileColor: backgroundcolor,
//                       title: Container(
//                         height: 120,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Flexible(flex:2,fit: FlexFit.loose,child:CircleAvatar(
//                               radius: 30,
//                               backgroundColor: Colors.grey,
//                               backgroundImage: NetworkImage(Provider.of<InviteUserView>(context, listen: false).ToGetPicture[index]),
//                             ), ),
//                             SizedBox(width: 5,),
//                             Flexible(flex:7,fit: FlexFit.tight,child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text('${Provider.of<InviteUserView>(context, listen: false).ToGetFirstName[index]} ${Provider.of<InviteUserView>(context, listen: false).ToGetLastName[index]}',style: GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.bold)),
//                                 Text('${Provider.of<InviteUserView>(context, listen: false).ToGetuserJobTitle[index]}',style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.bold)),
//                                 Text('${Provider.of<InviteUserView>(context, listen: false).ToGetLocation[index]}',style: GoogleFonts.nunito(fontSize: 15,)),
//                               ],
//                             ),),
//
//                             Flexible(
//                               flex: 0,
//                               fit: FlexFit.loose,
//                               //padding: const EdgeInsets.only(left: 0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: 15,),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       email='${Provider.of<InviteUserView>(context, listen: false).ToGetEmail[index]}';
//                                       print("------------>${email}");
//                                       Decision(email, invite);
//                                     },
//                                     style: ButtonStyle(
//                                         backgroundColor: MaterialStateProperty.all<Color>(primarycolor),
//                                         //minimumSize:MaterialStateProperty.<Size>(88,30)) ,
//                                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                           RoundedRectangleBorder(
//                                               borderRadius: BorderRadius.circular(12.0),
//                                           )),
//                                     ),
//                                     child:Row(
//                                       children: [
//                                         Icon(
//                                           Icons.add,
//                                           color: Colors.white,
//                                           size: 16,
//                                         ),
//                                         Text(
//                                             "Invite", style: GoogleFonts.nunito(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         )
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                       ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },),
//
//
//
//
//
//
//
//
//
//
//
//
//             //My UI Build:-
//             // ListView.builder(
//             //     padding: const EdgeInsets.all(3),
//             //     shrinkWrap: true,
//             //     physics: NeverScrollableScrollPhysics(),
//             //     itemCount: 1,
//             //     itemBuilder: (BuildContext context, int index) {
//             //       return Container(
//             //   height: 200,
//             //   color: Colors.red,
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: [
//             //       CircleAvatar(
//             //         radius: 25,
//             //         backgroundColor: Colors.grey,
//             //         //backgroundImage: NetworkImage(Provider.of<>(context,listen: false).companyLogo),
//             //       ),
//             //       Column(
//             //         mainAxisAlignment: MainAxisAlignment.start,
//             //
//             //         children: [
//             //           Text("Mostafa Hisham",style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold),),
//             //           Text("Senior Graphic Designer",style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.bold),),
//             //           Text("Cairo, Egypt",style: GoogleFonts.nunito(fontSize: 10,),),
//             //         ],
//             //       ),
//             //       Column(
//             //         mainAxisAlignment: MainAxisAlignment.start,
//             //         crossAxisAlignment: CrossAxisAlignment.end,
//             //         mainAxisSize: MainAxisSize.min,
//             //         children: [
//             //           Text("2 Hours ago",style: GoogleFonts.nunito(fontSize: 10, fontWeight: FontWeight.bold),),
//             //           // MaterialButton(
//             //           //   minWidth: 30,
//             //           //   color: primarycolor,
//             //           //   height: 30,
//             //           //   onPressed: ()  {
//             //           //
//             //           //   },
//             //           //   elevation: 2,
//             //           //   shape: RoundedRectangleBorder(
//             //           //     borderRadius: BorderRadius.circular(15),
//             //           //
//             //           //   ),
//             //             child:Row(
//             //               children: [
//             //                 Icon(
//             //                   Icons.check_outlined,
//             //                   color: Color(0xFF1FA522),
//             //                   size: 15,
//             //                 ),
//             //                 Text(
//             //                     "Accept", style: GoogleFonts.nunito(
//             //                   fontSize: 10,
//             //                   fontWeight: FontWeight.bold,
//             //                   color: Colors.white,
//             //                 )
//             //                 ),
//             //               ],
//             //             ),
//             //           //
//             //           //
//             //           // ),
//             //           // MaterialButton(
//             //           //   minWidth: 30,
//             //           //   color: primarycolor,
//             //           //   height: 30,
//             //           //   onPressed: ()  {
//             //           //
//             //           //   },
//             //           //   elevation: 2,
//             //           //   shape: RoundedRectangleBorder(
//             //           //     borderRadius: BorderRadius.circular(15),
//             //           //
//             //           //   ),
//             //             child:Row(
//             //               children: [
//             //                 Icon(
//             //                   Icons.free_cancellation_outlined,
//             //                   color: Color(0xFFE81313),
//             //                   size: 15,
//             //                 ),
//             //                 Text(
//             //                     "Reject", style: GoogleFonts.nunito(
//             //                   fontSize: 10,
//             //                   fontWeight: FontWeight.bold,
//             //                   color: Colors.white,
//             //                 )
//             //                 ),
//             //               ],
//             //             ),
//             //           // ),
//             //           // MaterialButton(
//             //           //   minWidth: 30,
//             //           //   color: primarycolor,
//             //           //   height: 30,
//             //           //   onPressed: ()  {
//             //           //
//             //           //   },
//             //           //   elevation: 2,
//             //           //   shape: RoundedRectangleBorder(
//             //           //     borderRadius: BorderRadius.circular(15),
//             //           //
//             //           //   ),
//             //             child:Row(
//             //               children: [
//             //                 Icon(
//             //                   Icons.featured_play_list,
//             //                   color: Colors.white,
//             //                   size: 15,
//             //                 ),
//             //                 SizedBox(width: 5,),
//             //                 Text(
//             //                     "Short List", style: GoogleFonts.nunito(
//             //                   fontSize: 8,
//             //                   fontWeight: FontWeight.bold,
//             //                   color: Colors.white,
//             //                 )
//             //                 ),
//             //               ],
//             //             ),
//             //           // ),
//             //         ],
//             //       ),
//             //     ],
//             //   ),
//             //
//             // );
//             //}
//             //),
//
//
//           ],
//         ),
//       ),
//     );
//   }
// }
