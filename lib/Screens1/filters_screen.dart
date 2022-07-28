import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../controllers/homescreen_getjobs.dart';
import 'homeListView_Screen.dart';
import 'home_Screen.dart';

class filterScreen extends StatefulWidget {
  const filterScreen({Key? key}) : super(key: key);

  @override
  _filterScreenState createState() => _filterScreenState();
}

class _filterScreenState extends State<filterScreen> {
  List<String> listOfValue1 = ['IT/Software Development', 'Marketing', 'Advertising','Engineering','Management','Art and Design'];
  List<String> listOfValue2 = ['Student', 'EntryLevel', 'Junior', 'Senior', 'Management'];
  List<String> emptylist=[''];
  String? _selectedValue1;
  String? _selectedValue2;
  String mail='';
  String _null='';



  Future<void>getBorio()async{
    final prefs=await SharedPreferences.getInstance();
    mail=prefs.getString('mail')!;
    await Provider.of<homeView>(context,listen: false).deletelist();

    await Provider.of<homeView>(context,listen: false).fetchhomeDetails(_selectedValue1==null?'':_selectedValue1!,_selectedValue2==null?'':_selectedValue2!,mail);
    Navigator.push(context, MaterialPageRoute(builder: (context) => homeJobList(),));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        shape: Border(
            bottom: BorderSide(
              color: Colors.black,
            )
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Filters',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),




          ],
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text('Categories',style: GoogleFonts.nunito(fontSize: 20,),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.89,
                  height: 50,
                  child: DropdownButtonFormField(


                    value: _selectedValue1 ,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "can't be empty";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.nunito(fontSize: 18),
                      hintText: 'eg. Engineering',
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: primarycolor)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: primarycolor),
                      ),
                    ),
                    onChanged: (String? value) {
                      _selectedValue1 = value!;
                    },
                    onSaved: (String? value) {
                      _selectedValue1 = value!;
                    },
                    items: listOfValue1.map((String val) {
                      return DropdownMenuItem(
                          value: val, child: Text(val,overflow: TextOverflow.visible,));
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text('Career Level',style: GoogleFonts.nunito(fontSize: 20,),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.89,
                  height: 50,
                  child: DropdownButtonFormField(


                    value: _selectedValue2,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "can't be empty";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.nunito(fontSize: 18),
                      hintText: 'eg. Senior',
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: primarycolor)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: primarycolor),
                      ),
                    ),
                    onChanged: (String? value) {
                      _selectedValue2 = value!;
                    },
                    onSaved: (String? value) {
                      _selectedValue2 = value!;
                    },
                    items: listOfValue2.map((String val) {
                      return DropdownMenuItem(
                          value: val, child: Text(val,overflow: TextOverflow.visible,));
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.black)
                    ),
                    minimumSize: Size(0, 50)),
                child: Text('      Cancel       ',
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))),
            SizedBox(width: 45,),
            ElevatedButton(
                onPressed: () {
                  getBorio();
                },
                style: ElevatedButton.styleFrom(
                    primary: primarycolor,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    minimumSize: Size(0, 50)),
                child: Text('        Apply         ',
                    style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
          ],
        ),
      ),
    );
  }
}

// class filterScreen extends StatefulWidget {
//   const filterScreen({Key? key}) : super(key: key);
//
//   @override
//   _filterScreenState createState() => _filterScreenState();
// }
//
// class _filterScreenState extends State<filterScreen> {
//   List<String> listOfValue1 = ['IT/Software Development', 'Marketing', 'Advertising','Engineering','Management','Art and Design'];
//   List<String> listOfValue2 = ['Student', 'EntryLevel', 'Junior', 'Senior', 'Management'];
//   List<String> emptylist=[''];
//   String? _selectedValue1;
//   String? _selectedValue2;
//   String mail='';
//   String _null='';
//
//
//
//   Future<void>getBorio()async{
//     final prefs=await SharedPreferences.getInstance();
//     mail=prefs.getString('mail')!;
//     await Provider.of<homeView>(context,listen: false).deletelist();
//
//     await Provider.of<homeView>(context,listen: false).fetchhomeDetails(_selectedValue1==null?'':_selectedValue1!,_selectedValue2==null?'':_selectedValue2!,mail);
//     Navigator.push(context, MaterialPageRoute(builder: (context) => homeJobList(),));
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         shape: Border(
//             bottom: BorderSide(
//               color: Colors.black,
//             )
//         ),
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: Colors.white,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text('Filters',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
//
//
//
//
//           ],
//         ),
//
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 20,),
//             Text('Categories',style: GoogleFonts.nunito(fontSize: 20,),),
//             SizedBox(height: 10,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.89,
//                   height: 50,
//                   child: DropdownButtonFormField(
//
//
//                     value: _selectedValue1 ,
//                     validator: (String? value) {
//                       if (value!.isEmpty) {
//                         return "can't be empty";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       hintStyle: GoogleFonts.nunito(fontSize: 18),
//                       hintText: 'eg. Engineering',
//                       fillColor: Colors.white,
//                       filled: true,
//                       focusedBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: primarycolor)),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: primarycolor),
//                       ),
//                     ),
//                     onChanged: (String? value) {
//                       _selectedValue1 = value!;
//                     },
//                     onSaved: (String? value) {
//                       _selectedValue1 = value!;
//                     },
//                     items: listOfValue1.map((String val) {
//                       return DropdownMenuItem(
//                           value: val, child: Text(val,overflow: TextOverflow.visible,));
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20,),
//             Text('Career Level',style: GoogleFonts.nunito(fontSize: 20,),),
//             SizedBox(height: 10,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.89,
//                   height: 50,
//                   child: DropdownButtonFormField(
//
//
//                     value: _selectedValue2,
//                     validator: (String? value) {
//                       if (value!.isEmpty) {
//                         return "can't be empty";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       hintStyle: GoogleFonts.nunito(fontSize: 18),
//                       hintText: 'eg. Senior',
//                       fillColor: Colors.white,
//                       filled: true,
//                       focusedBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: primarycolor)),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: primarycolor),
//                       ),
//                     ),
//                     onChanged: (String? value) {
//                       _selectedValue2 = value!;
//                     },
//                     onSaved: (String? value) {
//                       _selectedValue2 = value!;
//                     },
//                     items: listOfValue2.map((String val) {
//                       return DropdownMenuItem(
//                           value: val, child: Text(val,overflow: TextOverflow.visible,));
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 4.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                     primary: Colors.white,
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(30.0),
//                         side: BorderSide(color: Colors.black)
//                     ),
//                     minimumSize: Size(0, 50)),
//                 child: Text('      Cancel       ',
//                     style: GoogleFonts.nunito(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black))),
//             SizedBox(width: 20,),
//             ElevatedButton(
//                 onPressed: () {
//                   getBorio();
//                 },
//                 style: ElevatedButton.styleFrom(
//                     primary: primarycolor,
//                     shape: new RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(30.0),
//                     ),
//                     minimumSize: Size(0, 50)),
//                 child: Text('        Apply         ',
//                     style: GoogleFonts.nunito(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white))),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class filterScreen extends StatefulWidget {
//   const filterScreen({Key? key}) : super(key: key);
//
//   @override
//   _filterScreenState createState() => _filterScreenState();
// }
//
// class _filterScreenState extends State<filterScreen> {
//   List<String> listOfValue1 = ['IT', 'Marketing', 'Computer Science','Art and Design'];
//   List<String> listOfValue2 = ['Junior', 'Senior', 'Fresh Graduate','CEO'];
//   String? _selectedValue1;
//   String? _selectedValue2;
//   String mail='';
//
//
//
//   Future<void>getBorio()async{
//     await Provider.of<homeView>(context,listen: false).fetchhomeDetails(_selectedValue1!,_selectedValue2!,mail);
//     Navigator.push(context, MaterialPageRoute(builder: (context) => realHomeScreen(),));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         shape: Border(
//             bottom: BorderSide(
//               color: Colors.black,
//             )
//         ),
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: backgroundcolor,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text('Filters',style: GoogleFonts.nunito(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
//
//
//
//
//           ],
//         ),
//
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 20,),
//             Text('Categories',style: GoogleFonts.nunito(fontSize: 20,),),
//             SizedBox(height: 10,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.89,
//                   height: 50,
//                   child: DropdownButtonFormField(
//
//
//                     value: _selectedValue1,
//                     validator: (String? value) {
//                       if (value!.isEmpty) {
//                         return "can't be empty";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       hintStyle: GoogleFonts.nunito(fontSize: 18),
//                       hintText: 'eg. Finance',
//                       fillColor: Colors.white,
//                       filled: true,
//                       focusedBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: primarycolor)),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: primarycolor),
//                       ),
//                     ),
//                     onChanged: (String? value) {
//                       _selectedValue1 = value!;
//                     },
//                     onSaved: (String? value) {
//                       _selectedValue1 = value!;
//                     },
//                     items: listOfValue1.map((String val) {
//                       return DropdownMenuItem(
//                           value: val, child: Text(val,overflow: TextOverflow.visible,));
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20,),
//             Text('Career Level',style: GoogleFonts.nunito(fontSize: 20,),),
//             SizedBox(height: 10,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.89,
//                   height: 50,
//                   child: DropdownButtonFormField(
//
//
//                     value: _selectedValue2,
//                     validator: (String? value) {
//                       if (value!.isEmpty) {
//                         return "can't be empty";
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       hintStyle: GoogleFonts.nunito(fontSize: 18),
//                       hintText: 'eg. Senior',
//                       fillColor: Colors.white,
//                       filled: true,
//                       focusedBorder: OutlineInputBorder(
//                           borderSide:
//                           BorderSide(color: primarycolor)),
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: primarycolor),
//                       ),
//                     ),
//                     onChanged: (String? value) {
//                       _selectedValue2 = value!;
//                     },
//                     onSaved: (String? value) {
//                       _selectedValue2 = value!;
//                     },
//                     items: listOfValue2.map((String val) {
//                       return DropdownMenuItem(
//                           value: val, child: Text(val,overflow: TextOverflow.visible,));
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 4.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 style: ElevatedButton.styleFrom(
//                     primary: Colors.white,
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(30.0),
//                         side: BorderSide(color: Colors.black)
//                     ),
//                     minimumSize: Size(0, 50)),
//                 child: Text('      Cancel       ',
//                     style: GoogleFonts.nunito(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black))),
//             SizedBox(width: 60,),
//             ElevatedButton(
//                 onPressed: () {
//                   getBorio();
//                 },
//                 style: ElevatedButton.styleFrom(
//                     primary: primarycolor,
//                     shape: new RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(30.0),
//                     ),
//                     minimumSize: Size(0, 50)),
//                 child: Text('        Apply         ',
//                     style: GoogleFonts.nunito(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white))),
//           ],
//         ),
//       ),
//     );
//   }
// }