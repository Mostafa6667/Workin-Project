import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens2/JobDetailsScreen.dart';
import '../constants.dart';
import '../controllers/applyJob.dart';
import '../controllers/companyPrivateReview.dart';
import '../controllers/companyPublicProfile.dart';
import '../controllers/company_getJobs.dart';
import '../controllers/homescreen_getjobs.dart';
import 'companyProfileScreen_public.dart';


class searchit extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(
      icon: Icon(Icons.clear),
      onPressed:(){
        query='';
      } ,
    )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    int id=0;
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
    List companies=[];
    List listitems=[];
    List jobtypes=[];
    List dates=[];
    List applicants=[];
    List ids=[];
    List mails=[];
    // List listitems=query.isEmpty?Provider.of<homeView>(context,listen: false).jobtitle:
    //     // Provider.of<homeView>(context,listen: false).jobtitle.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
    if(query.isEmpty){
      listitems=Provider.of<homeView>(context,listen: false).jobtitle;
      companies=Provider.of<homeView>(context,listen: false).compname;
      jobtypes=Provider.of<homeView>(context,listen: false).jobtype;
      dates=Provider.of<homeView>(context,listen: false).createdat;
      applicants=Provider.of<homeView>(context,listen: false).applicantscount;
      ids=Provider.of<homeView>(context,listen: false).jobidis;
      mails=Provider.of<homeView>(context,listen: false).mail;

    }else{
      for(int i=0;i<Provider.of<homeView>(context,listen: false).jobtitle.length;i++){
        if(Provider.of<homeView>(context,listen: false).jobtitle[i].toLowerCase().contains(query.toLowerCase())){
          listitems.add(Provider.of<homeView>(context,listen: false).jobtitle[i]);
          companies.add(Provider.of<homeView>(context,listen: false).compname[i]);
          jobtypes.add(Provider.of<homeView>(context,listen: false).jobtype[i]);
          dates.add(Provider.of<homeView>(context,listen: false).createdat[i]);
          applicants.add(Provider.of<homeView>(context,listen: false).applicantscount[i]);
          ids.add(Provider.of<homeView>(context,listen: false).jobidis[i]);
          mails.add(Provider.of<homeView>(context,listen: false).mail[i]);


        }
      }
    }
    return listitems.isEmpty?Center(child: Text('No Data Found!'),):
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(listitems.length.toString()+' Jobs found'),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listitems.length,
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
                            flex: 7,
                            fit: FlexFit.loose,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(width:150,constraints: BoxConstraints(maxHeight: double.infinity),child: Text('${listitems[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo)),),
                                GestureDetector(
                                    onTap: () {
                                      mail=mails[index];
                                      print(mail);
                                      seecomp(mail);
                                    },
                                    child: Text('${companies[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold))),
                                Text('${jobtypes[index]}',style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.bold)),

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
                                Text('${dates[index]}',style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green),),
                                Text('${jobtypes[index]}'),
                                Text('${applicants[index].toString()} applicants'),
                                ElevatedButton(onPressed: () async{
                                  final prefs=await SharedPreferences.getInstance();
                                  id=ids[index];
                                  prefs.setInt('id', id);
                                  print(id);
                                  apply(id);

                                }, child: Text('Apply'),style: ElevatedButton.styleFrom(primary: primarycolor,minimumSize: Size(70, 20)))
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    int id=0;
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
    List companies=[];
    List listitems=[];
    List jobtypes=[];
    List dates=[];
    List applicants=[];
    List ids=[];
    List mails=[];
    // List listitems=query.isEmpty?Provider.of<homeView>(context,listen: false).jobtitle:
    //     // Provider.of<homeView>(context,listen: false).jobtitle.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
    if(query.isEmpty){
      listitems=Provider.of<homeView>(context,listen: false).jobtitle;
      companies=Provider.of<homeView>(context,listen: false).compname;
      jobtypes=Provider.of<homeView>(context,listen: false).jobtype;
      dates=Provider.of<homeView>(context,listen: false).createdat;
      applicants=Provider.of<homeView>(context,listen: false).applicantscount;
      ids=Provider.of<homeView>(context,listen: false).jobidis;
      mails=Provider.of<homeView>(context,listen: false).mail;

    }else{
      for(int i=0;i<Provider.of<homeView>(context,listen: false).jobtitle.length;i++){
        if(Provider.of<homeView>(context,listen: false).jobtitle[i].toLowerCase().contains(query.toLowerCase())){
          listitems.add(Provider.of<homeView>(context,listen: false).jobtitle[i]);
          companies.add(Provider.of<homeView>(context,listen: false).compname[i]);
          jobtypes.add(Provider.of<homeView>(context,listen: false).jobtype[i]);
          dates.add(Provider.of<homeView>(context,listen: false).createdat[i]);
          applicants.add(Provider.of<homeView>(context,listen: false).applicantscount[i]);
          ids.add(Provider.of<homeView>(context,listen: false).jobidis[i]);
          mails.add(Provider.of<homeView>(context,listen: false).mail[i]);

        }
      }
    }
    return listitems.isEmpty?Center(child: Text('No Data Found!'),):
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(listitems.length.toString()+' Jobs found'),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listitems.length,
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
                            flex: 7,
                            fit: FlexFit.loose,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(width:150,constraints: BoxConstraints(maxHeight: double.infinity),child: Text('${listitems[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo)),),
                                GestureDetector(
                                    onTap: () {
                                      mail=mails[index];
                                      print(mail);
                                      seecomp(mail);
                                    },
                                    child: Text('${companies[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold))),
                                Text('${jobtypes[index]}',style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.bold)),

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
                                Text('${dates[index]}',style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green),),
                                Text('${jobtypes[index]}'),
                                Text('${applicants[index].toString()} applicants'),
                                ElevatedButton(onPressed: () async{
                                  final prefs=await SharedPreferences.getInstance();
                                  id=ids[index];
                                  prefs.setInt('id', id);
                                  print(id);
                                  apply(id);

                                }, child: Text('Apply'),style: ElevatedButton.styleFrom(primary: primarycolor,minimumSize: Size(70, 20)))
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
    );
  }

}

// class searchit extends SearchDelegate{
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [IconButton(
//       icon: Icon(Icons.clear),
//       onPressed:(){
//         query='';
//       } ,
//     )];
//   }
//
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(onPressed: () {
//       close(context, null);
//     }, icon: Icon(Icons.arrow_back));
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     List companies=[];
//     List listitems=[];
//     List jobtypes=[];
//     List dates=[];
//     List applicants=[];
//     // List listitems=query.isEmpty?Provider.of<homeView>(context,listen: false).jobtitle:
//     //     // Provider.of<homeView>(context,listen: false).jobtitle.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
//     if(query.isEmpty){
//       listitems=Provider.of<homeView>(context,listen: false).jobtitle;
//       companies=Provider.of<homeView>(context,listen: false).compname;
//       jobtypes=Provider.of<homeView>(context,listen: false).jobtype;
//       dates=Provider.of<homeView>(context,listen: false).createdat;
//       applicants=Provider.of<homeView>(context,listen: false).applicantscount;
//     }else{
//       for(int i=0;i<Provider.of<homeView>(context,listen: false).jobtitle.length;i++){
//         if(Provider.of<homeView>(context,listen: false).jobtitle[i].toLowerCase().contains(query.toLowerCase())){
//           listitems.add(Provider.of<homeView>(context,listen: false).jobtitle[i]);
//           companies.add(Provider.of<homeView>(context,listen: false).compname[i]);
//           jobtypes.add(Provider.of<homeView>(context,listen: false).jobtype[i]);
//           dates.add(Provider.of<homeView>(context,listen: false).createdat[i]);
//           applicants.add(Provider.of<homeView>(context,listen: false).applicantscount[i]);
//         }
//       }
//     }
//     return listitems.isEmpty?Center(child: Text('No Data Found!'),):
//     SingleChildScrollView(
//       child: Column(
//         children: [
//           Text(listitems.length.toString()+' items'),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: listitems.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Card(
//                   child: ListTile(
//                     tileColor: backgroundcolor,
//                     title: Container(
//                       constraints: BoxConstraints(maxHeight: double.infinity),
//                       child: Row(
//                         children: [
//
//                           Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(width:150,constraints: BoxConstraints(maxHeight: double.infinity),child: Text('${listitems[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo)),),
//                                   Text('${companies[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold)),
//                                   Text('${jobtypes[index]}',style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.bold)),
//
//                                 ],
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 85.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text('${dates[index]}',style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green),),
//                                     Text('${Provider.of<homeView>(context,listen: false).jobtype[index]}'),
//                                     Text('${applicants[index].toString()} applicants'),
//                                     ElevatedButton(onPressed: () {
//
//                                     }, child: Text('Apply'),style: ElevatedButton.styleFrom(primary: primarycolor,minimumSize: Size(70, 20)))
//                                   ],
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List companies=[];
//     List listitems=[];
//     List jobtypes=[];
//     List dates=[];
//     List applicants=[];
//     // List listitems=query.isEmpty?Provider.of<homeView>(context,listen: false).jobtitle:
//     //     // Provider.of<homeView>(context,listen: false).jobtitle.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
//     if(query.isEmpty){
//       listitems=Provider.of<homeView>(context,listen: false).jobtitle;
//       companies=Provider.of<homeView>(context,listen: false).compname;
//       jobtypes=Provider.of<homeView>(context,listen: false).jobtype;
//       dates=Provider.of<homeView>(context,listen: false).createdat;
//       applicants=Provider.of<homeView>(context,listen: false).applicantscount;
//     }else{
//       for(int i=0;i<Provider.of<homeView>(context,listen: false).jobtitle.length;i++){
//         if(Provider.of<homeView>(context,listen: false).jobtitle[i].toLowerCase().contains(query.toLowerCase())){
//           listitems.add(Provider.of<homeView>(context,listen: false).jobtitle[i]);
//           companies.add(Provider.of<homeView>(context,listen: false).compname[i]);
//           jobtypes.add(Provider.of<homeView>(context,listen: false).jobtype[i]);
//           dates.add(Provider.of<homeView>(context,listen: false).createdat[i]);
//           applicants.add(Provider.of<homeView>(context,listen: false).applicantscount[i]);
//         }
//       }
//     }
//     return listitems.isEmpty?Center(child: Text('No Data Found!'),):
//     SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(listitems.length.toString()+' Jobs found'),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: listitems.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Card(
//                   child: ListTile(
//                     tileColor: backgroundcolor,
//                     title: Container(
//                       constraints: BoxConstraints(maxHeight: double.infinity),
//                       child: Row(
//                         children: [
//
//                           Row(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(width:150,constraints: BoxConstraints(maxHeight: double.infinity),child: Text('${listitems[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.indigo)),),
//                                   Text('${companies[index]}',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold)),
//                                   Text('${jobtypes[index]}',style: GoogleFonts.nunito(fontSize: 15,fontWeight: FontWeight.bold)),
//
//                                 ],
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 85.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text('${dates[index]}',style: GoogleFonts.nunito(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.green),),
//                                     Text('${Provider.of<homeView>(context,listen: false).jobtype[index]}'),
//                                     Text('${applicants[index].toString()} applicants'),
//                                     ElevatedButton(onPressed: () {
//
//                                     }, child: Text('Apply'),style: ElevatedButton.styleFrom(primary: primarycolor,minimumSize: Size(70, 20)))
//                                   ],
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },),
//         ],
//       ),
//     );
//   }
//
// }