


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../controllers/userPrivateInfo.dart';

class userPublicProfile extends StatefulWidget {
  const userPublicProfile({Key? key}) : super(key: key);


  @override
  _userPublicProfileState createState() => _userPublicProfileState();
}



class _userPublicProfileState extends State<userPublicProfile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding:const EdgeInsets.all(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.width*0.1,),

                CircleAvatar(
                  radius: 50,
                  backgroundColor: primarycolor,
                  backgroundImage: NetworkImage(Provider.of<userDetailView>(context,listen: false).picture),
                ),

                Text('${Provider.of<userDetailView>(context,listen:false).fname+' '+Provider.of<userDetailView>(context,listen:false).lname}',style: GoogleFonts.nunito(fontSize: 26,fontWeight: FontWeight.bold),),
                Text('${Provider.of<userDetailView>(context,listen:false).careerlevel+' '+Provider.of<userDetailView>(context,listen:false).jobtitle}',style: GoogleFonts.nunito(fontSize: 25,color: Colors.grey),),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${Provider.of<userDetailView>(context,listen:false).about}',style: GoogleFonts.nunito(fontSize: 17),textAlign: TextAlign.start,),
                  ],
                ),
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
                      flex:5,
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${Provider.of<userDetailView>(context,listen:false).uni}',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),Flexible(
                      flex: 1,
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
                    Text('Years of Experience:  ',style:GoogleFonts.nunito(fontSize: 18,fontWeight: FontWeight.bold),),Text('${Provider.of<userDetailView>(context,listen:false).yearsofexperience.toString()}',style: GoogleFonts.nunito(fontSize: 17),)
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



              ],
            ),
          ),
        ),
      ),
    );
  }
}