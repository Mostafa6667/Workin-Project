import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens2/JobDetailsScreen.dart';
import '../constants.dart';
import '../controllers/applyJob.dart';
import '../controllers/companyCreateReview.dart';
import '../controllers/companyPrivateReview.dart';
import '../controllers/companyPublicProfile.dart';
import '../controllers/company_getJobs.dart';



class companyPublicProfile extends StatefulWidget {
  const companyPublicProfile({Key? key}) : super(key: key);

  @override
  _companyPublicProfileState createState() => _companyPublicProfileState();
}

class _companyPublicProfileState extends State<companyPublicProfile> {

  TextEditingController _reviewscontroller = TextEditingController();



  File? image;
  bool showspinner=false;
  bool _isLoading=false;
  double? Rating;
  String mail='';


  final GlobalKey<FormState> _formkey = GlobalKey();
  _reviewsvalidation() {
    if (RegExp('^[A-Za-z0-9]').hasMatch(_reviewscontroller.text)) {
      return false;
    } else {
      return true;
    }
  }
  Future<void> _uploadReview() async {
    mail=Provider.of<companyDetailView>(context,listen: false).email;
    final review = _reviewscontroller.text;
    final _rating = Rating!.toInt();

    if (!_formkey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formkey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<companyCreateReview>(context, listen: false)
          .addReview(review,_rating,mail);
    } catch(e) {
      throw e;
    }
    Navigator.of(context).pop();
    _reviewscontroller.clear();
    setState(() {
      _isLoading=false;
    });

  }

  int id = 0;

  Future<void> apply(int id) async {
    await Provider.of<jobApply>(context, listen: false).See(id);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => jobDetailsScreen(),
        ));
  }

  Widget getimage(BuildContext context){
    if(Provider.of<companyDetailView>(context,listen: false).logo==''){
      return Container(
        width:MediaQuery.of(context).size.width*0.2 ,
        height: MediaQuery.of(context).size.width*0.2,
        color: backgroundcolor,
        child: Icon(Icons.laptop_windows_sharp,size: 45,color: Colors.black,),
      );
    }else{
      return Container(
        width:MediaQuery.of(context).size.width*0.2 ,
        height: MediaQuery.of(context).size.width*0.2,
        child:Image.network(Provider.of<companyDetailView>(context,listen: false).logo,width:MediaQuery.of(context).size.width*0.2 ,height: MediaQuery.of(context).size.width*0.2,
          fit: BoxFit.cover,),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title:Row(
            children: [
              getimage(context),
              SizedBox(width: MediaQuery.of(context).size.width*0.1,),
              Text('${Provider.of<companyDetailView>(context, listen: false).name
              }',style: GoogleFonts.nunito(fontSize: 25,color: Colors.white),)
            ],
          ) ,
          backgroundColor: primarycolor,
          toolbarHeight: MediaQuery.of(context).size.height*0.15,
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
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Row(
                                children: [
                                  Text(
                                    'Website',
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                              Container(
                                height: 30,
                                child: Text(
                                  '${Provider.of<companyDetailView>(context, listen: false).website}',
                                  style: GoogleFonts.nunito(fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.001),
                              Row(
                                children: [
                                  Text(
                                    'company info',
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                              Container(
                                constraints:
                                BoxConstraints(maxHeight: double.infinity),
                                child: Text(
                                  '${Provider.of<companyDetailView>(context, listen: false).compinfo}',
                                  style: GoogleFonts.nunito(fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Row(
                                children: [
                                  Text(
                                    'Industry (field)',
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                              Container(
                                  height: 30,
                                  child: Text(
                                    '${Provider.of<companyDetailView>(context, listen: false).industry}',
                                    style: GoogleFonts.nunito(
                                        fontSize: 20, color: Colors.black),
                                  )),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Row(
                                children: [
                                  Text(
                                    'Location',
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                              Container(
                                  constraints: BoxConstraints(
                                      maxHeight: double.infinity),
                                  child: Text(
                                    '${Provider.of<companyDetailView>(context, listen: false).location}',
                                    style: GoogleFonts.nunito(fontSize: 20),
                                  )),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
                              Row(
                                children: [
                                  Text(
                                    'Other information',
                                    style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.001),
                              Text(
                                'Type:  ${Provider.of<companyDetailView>(context, listen: false).type}',
                                style: GoogleFonts.nunito(fontSize: 20),
                              ),
                              Text(
                                'Size:  ${Provider.of<companyDetailView>(context, listen: false).size}',
                                style: GoogleFonts.nunito(fontSize: 20),
                              ),
                              Text(
                                'Founded:  ${Provider.of<companyDetailView>(context, listen: false).founded}',
                                style: GoogleFonts.nunito(fontSize: 20),
                              ),
                              Text(
                                'Headquarter:  ${Provider.of<companyDetailView>(context, listen: false).headquarter}',
                                style: GoogleFonts.nunito(fontSize: 20),
                              ),
                              Container(
                                  constraints: BoxConstraints(
                                      maxHeight: double.infinity),
                                  child: Text(
                                    'Specialities:  ${Provider.of<companyDetailView>(context, listen: false).specialities}',
                                    style: GoogleFonts.nunito(fontSize: 20),
                                  )),
                            ],
                          ),
                        ),
                      ),

                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, left: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        Widget ok = GestureDetector(
                                          onTap: () {
                                            _uploadReview();
                                          },
                                          child: Text(
                                            'Submit',
                                            style: GoogleFonts.nunito(
                                                fontSize: 16,
                                                color: Colors.blue),
                                          ),
                                        );
                                        Widget cancel = GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.nunito(
                                                fontSize: 16),
                                          ),
                                        );
                                        AlertDialog alert = AlertDialog(
                                          title: Text('Add review'),
                                          content: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.4,
                                            child: Column(
                                              children: [
                                                RatingBar.builder(
                                                    itemSize: 35.0,
                                                    initialRating: 0,
                                                    minRating: 0,
                                                    direction: Axis.horizontal,
                                                    itemCount: 5,
                                                    itemBuilder: (context,
                                                        rate) =>
                                                        Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                    onRatingUpdate: (rating) {
                                                      Rating = rating;
                                                      print(rating);
                                                    }),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                if (_isLoading)
                                                  CircularProgressIndicator(),
                                                TextFormField(
                                                  maxLines: 6,
                                                  keyboardType:
                                                  TextInputType.name,
                                                  controller:
                                                  _reviewscontroller,
                                                  validator: (val) {
                                                    if (val!.isEmpty) {
                                                      return 'please write a review';
                                                    } else if (_reviewsvalidation()) {
                                                      return 'only characters or numbers';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                            primarycolor)),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: primarycolor),
                                                    ),
                                                    hintStyle:
                                                    GoogleFonts.nunito(
                                                        fontSize: 18),
                                                    hintText: 'Write a review',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [ok, cancel],
                                        );
                                        return alert;
                                      });
                                },
                                child: Container(
                                  width: 130,
                                  child: Row(
                                    children: [
                                      Icon(Icons.add_circle_outline),
                                      Text('   '),
                                      Text(
                                        'Add Review',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: primarycolor,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: Provider.of<companyReviews>(context,
                                  listen: false)
                                  .count,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Card(
                                    child: ListTile(
                                        tileColor: backgroundcolor,
                                        title: Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black))),
                                          constraints: BoxConstraints(
                                              maxHeight: double.infinity),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        '${Provider.of<companyReviews>(context, listen: false).user[index]}'),
                                                    Text(
                                                        '${Provider.of<companyReviews>(context, listen: false).date[index]}'),
                                                    RatingBarIndicator(
                                                      itemBuilder:
                                                          (context, _) {
                                                        return Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        );
                                                      },
                                                      itemCount: 5,
                                                      itemSize: 20,
                                                      rating: Provider.of<
                                                          companyReviews>(
                                                          context,
                                                          listen: false)
                                                          .rate[index],
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
                                                    Container(
                                                        width: 245,
                                                        constraints:
                                                        BoxConstraints(
                                                            maxHeight: double
                                                                .infinity),
                                                        child: Text(
                                                          '${Provider.of<companyReviews>(context, listen: false).review[index]}',
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: Provider.of<companyJobs>(context,
                                  listen: false)
                                  .count,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    child: ListTile(
                                      tileColor: backgroundcolor,
                                      title: Container(
                                        constraints: BoxConstraints(
                                            maxHeight: double.infinity),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 7,
                                              fit: FlexFit.loose,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 150,
                                                      constraints:
                                                      BoxConstraints(
                                                          maxHeight: double
                                                              .infinity),
                                                      child: Text(
                                                          '${Provider.of<companyJobs>(context, listen: false).jobtitles[index]}',
                                                          style: GoogleFonts
                                                              .nunito(
                                                              fontSize: 20,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold))),
                                                  Text(
                                                      '${Provider.of<companyJobs>(context, listen: false).companyName}',
                                                      style: GoogleFonts.nunito(
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                  Text(
                                                      '${Provider.of<companyJobs>(context, listen: false).companylocation}')
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              flex: 10,
                                              fit: FlexFit.tight,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 80,
                                                      child: Text(
                                                        '${Provider.of<companyJobs>(context, listen: false).createdat[index]}',
                                                        style:
                                                        GoogleFonts.nunito(
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                      )),
                                                  Text(
                                                      '${Provider.of<companyJobs>(context, listen: false).jobtypes[index]}'),
                                                  Text(
                                                      '${Provider.of<companyJobs>(context, listen: false).applicants[index].toString()} applicants'),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      final prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                      id = Provider.of<
                                                          companyJobs>(
                                                          context,
                                                          listen: false)
                                                          .idis[index];
                                                      prefs.setInt('id', id);
                                                      print(id);
                                                      apply(id);
                                                    },
                                                    child: Text('Apply'),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                        primary:
                                                        primarycolor,
                                                        minimumSize:
                                                        Size(70, 20)),
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
                              },
                            ),
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
      ),
    );

  }
}