import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:workin_servive/controllers/InviteUsers.dart';
import 'package:workin_servive/controllers/JobsAppliedFor.dart';
import 'package:workin_servive/controllers/companySignup2.dart';
import 'package:workin_servive/controllers/editJob.dart';
import 'package:workin_servive/controllers/jobDetails.dart';
import 'package:workin_servive/controllers/personalInfo2.dart';


import 'Screens2/CVUploadScreen.dart';
import 'Screens2/SplashScreen.dart';
import 'controllers/AppliedUser.dart';
import 'controllers/InviteUsers.dart';
import 'controllers/applyJob.dart';
import 'controllers/companyCreateReview.dart';
import 'controllers/companyPrivateReview.dart';
import 'controllers/companyPublicProfile.dart';
import 'controllers/companySignup.dart';
import 'controllers/company_getCategoryJobs.dart';
import 'controllers/company_getJobs.dart';
import 'controllers/homescreen_getjobs.dart';
import 'controllers/personalInfo.dart';
import 'controllers/signup.dart';
import 'controllers/userPrivateInfo.dart';

import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
void main()async{
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Auth>(create:(_)=>Auth()),
    ChangeNotifierProvider<companyAuth>(create:(_) =>companyAuth()),
    ChangeNotifierProvider<postfile>(create:(_) =>postfile()),
    ChangeNotifierProvider<jobDetailView>(create:(_) =>jobDetailView()),
    ChangeNotifierProvider<AppliedUserView>(create:(_) =>AppliedUserView()),
    ChangeNotifierProvider<InviteUserView>(create:(_) =>InviteUserView()),
    ChangeNotifierProvider<jobsAppliedForView>(create:(_) =>jobsAppliedForView()),
    ChangeNotifierProvider<companyAuth2>(create:(_) =>companyAuth2()),
    ChangeNotifierProvider<personalInfoAuth>(create:(_) =>personalInfoAuth()),
    ChangeNotifierProvider<companyDetailView>(create:(_) =>companyDetailView()),
    ChangeNotifierProvider<companyReviews>(create:(_) =>companyReviews()),
    ChangeNotifierProvider<companyCreateReview>(create:(_) =>companyCreateReview()),
    ChangeNotifierProvider<companyJobs>(create:(_) =>companyJobs()),
    ChangeNotifierProvider<userDetailView>(create:(_) =>userDetailView()),
    ChangeNotifierProvider<homeView>(create:(_) =>homeView()),
    ChangeNotifierProvider<categoryJobs>(create:(_) =>categoryJobs()),
    ChangeNotifierProvider<jobApply>(create:(_) =>jobApply()),
    ChangeNotifierProvider<personalInfoAuth2>(create:(_) =>personalInfoAuth2()),
    ChangeNotifierProvider<Edit>(create:(_) =>Edit()),



  ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        supportedLocales: [
          Locale('en','US')
        ],
        localizationsDelegates: [
          CountryLocalizations.delegate
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Color(0xfff3f3f3)),




        home: splashScreen(),
    );
  }
}
