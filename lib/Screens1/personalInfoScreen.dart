import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../Screens2/CVUploadScreen.dart';
import '../Screens2/userCareerInfoScreen.dart';
import '../constants.dart';
import '../controllers/personalInfo.dart';


enum SingingCharacter { m, f }

class personalInfoScreen extends StatefulWidget {
  const personalInfoScreen({Key? key}) : super(key: key);

  @override
  _personalInfoScreenState createState() => _personalInfoScreenState();
}

class _personalInfoScreenState extends State<personalInfoScreen> {
//CvUploadScreen().createState().firstName.toString()
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _phonenumController = TextEditingController();
  String? _selectedValue1;
  String? _selectedValue2;
  String? _selectedValue3;
  String? _selectedValue4;
  List<String> listOfValue1 = ['Egyptian', 'American', 'Australian'];
  List<String> listOfValue2 = ['Egypt', 'United States', 'Australia'];
  List<String> listOfValue3 = ['Cairo', 'Alexandria', 'Giza'];
  List<String> listOfValue4 = ['Maadi', 'Nasr City', 'New Cairo','Heliopolis'];
  String? date ;
  DateTime selectedDate = DateTime.now();
  final GlobalKey<FormState> _formkey = GlobalKey();
  var _countrypick;
  var _isLoading=false;
  // List<String>genders=['M','F'];
  SingingCharacter? _character = SingingCharacter.m;
  _choosegender(){
    if(_character==SingingCharacter.m){
      return 'M';
    }else{
      return'F';
    }
  }



  _fNameValidation() {
    if (RegExp('^[a-zA-Z]').hasMatch(_fNameController.text)) {
      return false;
    } else {
      return true;
    }
  }

  _lNameValidation() {
    if (RegExp('^[a-zA-Z]').hasMatch(_lNameController.text)) {
      return false;
    } else {
      return true;
    }
  }

  _phoneNumValidation(){
    if(RegExp('^(?:[+0]9)?[0-9]{10}').hasMatch(_phonenumController.text)){
      return false;
    }else{
      return true;
    }
  }


  TextEditingController _dateinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    _dateinput.text = ""; //set the initial value of text field
    _fNameController.text=Provider.of<postfile>(context,listen: false).firstName==""?"":Provider.of<postfile>(context,listen: false).firstName;
    _lNameController.text=Provider.of<postfile>(context,listen: false).lastName==""?"":Provider.of<postfile>(context,listen: false).lastName;
    _phonenumController.text=Provider.of<postfile>(context,listen: false).mobileNumber==""?"":Provider.of<postfile>(context,listen: false).mobileNumber;
    //_dateinput.text=Provider.of<postfile>(context,listen: false).birthDate==""?_dateinput.text:Provider.of<postfile>(context,listen: false).birthDate;
    _selectedValue2=Provider.of<postfile>(context,listen: false).country==""?"Egypt":Provider.of<postfile>(context,listen: false).country;
    _selectedValue3=Provider.of<postfile>(context,listen: false).city==""?"Cairo":Provider.of<postfile>(context,listen: false).city;
    _selectedValue4=Provider.of<postfile>(context,listen: false).area==""?"Maadi":Provider.of<postfile>(context,listen: false).area;
    _selectedValue1='Egyptian';


    super.initState();
  }

  Future<void> _submit() async {
    var prefs=await SharedPreferences.getInstance();
    final mobNumber = _phonenumController.text;
    final email=prefs.getString('mail');
    final birthdate=_dateinput.text;
    final  String gender=_choosegender();
    final nationality=_selectedValue1.toString();
    final country=_selectedValue2.toString();
    final city=_selectedValue3.toString();
    final area=_selectedValue4.toString();



    if (!_formkey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formkey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<personalInfoAuth>(context, listen: false)
          .personalInfo(email!,birthdate,mobNumber,gender,nationality,country,city,area);
    } catch(e) {
      throw e;
    }
    if(Provider.of<personalInfoAuth>(context,listen: false).theresponse=='Success'){
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserCompanyInfo(),));
    }
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Personal Info',
                        style: GoogleFonts.nunito(fontSize: 36),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Introduce yourself to companies',
                        style: GoogleFonts.nunito(fontSize: 13,),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child:Text('${Provider.of<personalInfoAuth>(context,listen: false).theError!=''?Provider.of<personalInfoAuth>(context,listen: false).theError:''}',style: GoogleFonts.nunito(fontSize: 20,color: Colors.red,),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'First Name',
                            style: GoogleFonts.nunito(fontSize: 18),
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.38,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _fNameController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Type your first Name';
                                } else if (_fNameValidation()) {
                                  return 'only characters here';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: primarycolor)),
                                border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: primarycolor),
                                ),
                                hintStyle: GoogleFonts.nunito(fontSize: 18),
                                hintText: 'First Name',
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last Name',
                            style: GoogleFonts.nunito(fontSize: 18),
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _lNameController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Type your Last Name';
                                } else if (_lNameValidation()) {
                                  return 'only characters here';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: primarycolor)),
                                border: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: primarycolor),
                                ),
                                hintStyle: GoogleFonts.nunito(fontSize: 18),
                                hintText: 'Last Name',
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'Mobile Number',
                            style: GoogleFonts.nunito(fontSize: 18),
                          ))
                    ],
                  ),
                  Row(children: [
                    Column(children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                            Border.all(width: 1, color: primarycolor),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: CountryCodePicker(
                          initialSelection: 'EG',
                          onChanged: (value) {
                            _countrypick = value;
                          },
                        ),
                      ),
                    ]),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.59,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: _phonenumController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Type your number';
                              } else if (_phoneNumValidation()) {
                                return 'only numbers(10 digits)';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: primarycolor)),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: primarycolor),
                              ),
                              hintStyle: GoogleFonts.nunito(fontSize: 18),
                              hintText: 'Phone number',
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'Birthdate',
                            style: GoogleFonts.nunito(fontSize: 18),
                          ))
                    ],
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
                      controller: _dateinput,
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.nunito(fontSize: 18),
                        hintText:"${selectedDate.day}-0${selectedDate.month}-${selectedDate.year}",
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: Icon(Icons.calendar_month_sharp),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primarycolor)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: primarycolor),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(

                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2023)
                        );

                        if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            _dateinput.text = formattedDate; //set output date to TextField value.
                          });
                        }

                      },

                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'Gender',
                            style: GoogleFonts.nunito(fontSize: 18),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        activeColor: Colors.black,
                        value: SingingCharacter.m,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character= value;
                          });
                        },
                      ),
                      Text(
                        'Male',
                        style: GoogleFonts.nunito(fontSize: 18),
                      ),
                      Radio(
                        activeColor: Colors.black,
                        value: SingingCharacter.f,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                      Text(
                        'Female',
                        style: GoogleFonts.nunito(fontSize: 18),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'Nationality',
                            style: GoogleFonts.nunito(fontSize: 18),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.89,
                        height: 50,
                        child: DropdownButtonFormField(


                          value: _selectedValue1,

                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "can't be empty";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.nunito(fontSize: 18),
                            hintText: 'Egyptian',
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width*0.89 ,
                          child: Text(
                            'Your Location',
                            style: GoogleFonts.nunito(fontSize: 25),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'Country',
                            style: GoogleFonts.nunito(fontSize: 16),
                          ))
                    ],
                  ),
                  Row(
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
                            hintText: 'Egypt',
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'City',
                            style: GoogleFonts.nunito(fontSize: 16),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.89,
                        height: 50,
                        child: DropdownButtonFormField(
                          value: _selectedValue3,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "can't be empty";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.nunito(fontSize: 18),
                            hintText: 'Cairo',
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
                            _selectedValue3 = value!;
                          },
                          onSaved: (String? value) {
                            _selectedValue3 = value!;
                          },
                          items: listOfValue3.map((String val) {
                            return DropdownMenuItem(
                                value: val, child: Text(val,overflow: TextOverflow.visible));
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'Area',
                            style: GoogleFonts.nunito(fontSize: 16),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.89,
                        height: 50,
                        child: DropdownButtonFormField(
                          value: _selectedValue4,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "can't be empty";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintStyle: GoogleFonts.nunito(fontSize: 18),
                            hintText: 'Maadi',
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
                            _selectedValue4 = value!;
                          },
                          onSaved: (String? value) {
                            _selectedValue4 = value!;
                          },
                          items: listOfValue4.map((String val) {
                            return DropdownMenuItem(
                                value: val, child: Text(val,overflow: TextOverflow.visible));
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  if (_isLoading) Center(child: CircularProgressIndicator()),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                          onPressed: () {
                            _submit();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: primarycolor,
                              shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(30.0),
                              ),
                              minimumSize: Size(0, 50)),
                          child: Text('Submit and continue',
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
// enum SingingCharacter { m, f }
//
// class personalInfoScreen extends StatefulWidget {
//   const personalInfoScreen({Key? key}) : super(key: key);
//
//   @override
//   _personalInfoScreenState createState() => _personalInfoScreenState();
// }
//
// class _personalInfoScreenState extends State<personalInfoScreen> {
// //CvUploadScreen().createState().firstName.toString()
//   TextEditingController _fNameController = TextEditingController();
//   TextEditingController _lNameController = TextEditingController();
//   TextEditingController _phonenumController = TextEditingController();
//   String? _selectedValue1;
//   String? _selectedValue2;
//   String? _selectedValue3;
//   String? _selectedValue4;
//   List<String> listOfValue1 = ['Egyptian', 'American', 'Australian'];
//   List<String> listOfValue2 = ['Egypt', 'United States', 'Australia'];
//   List<String> listOfValue3 = ['Cairo', 'Alexandria', 'Giza'];
//   List<String> listOfValue4 = ['Maadi', 'Nasr City', 'New Cairo','Heliopolis'];
//   String? date ;
//   DateTime selectedDate = DateTime.now();
//   final GlobalKey<FormState> _formkey = GlobalKey();
//   var _countrypick;
//   var _isLoading=false;
//   // List<String>genders=['M','F'];
//   SingingCharacter? _character = SingingCharacter.m;
//   _choosegender(){
//     if(_character==SingingCharacter.m){
//       return 'M';
//     }else{
//       return'F';
//     }
//   }
//
//
//
//   _fNameValidation() {
//     if (RegExp('^[a-zA-Z]').hasMatch(_fNameController.text)) {
//       return false;
//     } else {
//       return true;
//     }
//   }
//
//   _lNameValidation() {
//     if (RegExp('^[a-zA-Z]').hasMatch(_lNameController.text)) {
//       return false;
//     } else {
//       return true;
//     }
//   }
//
//   _phoneNumValidation(){
//     if(RegExp('^(?:[+0]9)?[0-9]{10}').hasMatch(_phonenumController.text)){
//       return false;
//     }else{
//       return true;
//     }
//   }
//
//
//   TextEditingController _dateinput = TextEditingController();
//   //text editing controller for text field
//
//   @override
//   void initState() {
//     _dateinput.text = ""; //set the initial value of text field
//     _fNameController.text=Provider.of<postfile>(context,listen: false).firstName==""?"":Provider.of<postfile>(context,listen: false).firstName;
//     _lNameController.text=Provider.of<postfile>(context,listen: false).lastName==""?"":Provider.of<postfile>(context,listen: false).lastName;
//     _phonenumController.text=Provider.of<postfile>(context,listen: false).mobileNumber==""?"":Provider.of<postfile>(context,listen: false).mobileNumber;
//     //_dateinput.text=Provider.of<postfile>(context,listen: false).birthDate==""?_dateinput.text:Provider.of<postfile>(context,listen: false).birthDate;
//     _selectedValue2=Provider.of<postfile>(context,listen: false).country==""?"Egypt":Provider.of<postfile>(context,listen: false).country;
//     _selectedValue3=Provider.of<postfile>(context,listen: false).city==""?"Cairo":Provider.of<postfile>(context,listen: false).city;
//     _selectedValue4=Provider.of<postfile>(context,listen: false).area==""?"Maadi":Provider.of<postfile>(context,listen: false).area;
//     _selectedValue1='Egyptian';
//
//
//     super.initState();
//   }
//
//   Future<void> _submit() async {
//     var prefs=await SharedPreferences.getInstance();
//     final mobNumber = _phonenumController.text;
//     final email=prefs.getString('mail');
//     final birthdate=_dateinput.text;
//     final  String gender=_choosegender();
//     final nationality=_selectedValue1.toString();
//     final country=_selectedValue2.toString();
//     final city=_selectedValue3.toString();
//     final area=_selectedValue4.toString();
//
//
//
//     if (!_formkey.currentState!.validate()) {
//       return;
//     }
//     FocusScope.of(context).unfocus();
//     _formkey.currentState!.save();
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       await Provider.of<personalInfoAuth>(context, listen: false)
//           .personalInfo(email!,birthdate,mobNumber,gender,nationality,country,city,area);
//     } catch(e) {
//       throw e;
//     }
//     if(Provider.of<personalInfoAuth>(context,listen: false).theresponse=='Success'){
//       Navigator.push(context, MaterialPageRoute(builder: (context) => UserCompanyInfo(),));
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formkey,
//           child: Container(
//             height: MediaQuery.of(context).size.height * 1.3,
//             width: MediaQuery.of(context).size.width,
//             child: Column(children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 40,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Personal Info',
//                             style: GoogleFonts.nunito(fontSize: 36),
//                           )
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Introduce yourself to companies',
//                             style: GoogleFonts.nunito(fontSize: 13,),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Center(
//                       child:Text('${Provider.of<personalInfoAuth>(context,listen: false).theError!=''?Provider.of<personalInfoAuth>(context,listen: false).theError:''}',style: GoogleFonts.nunito(fontSize: 20,color: Colors.red,),),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'First Name',
//                                 style: GoogleFonts.nunito(fontSize: 18),
//                               ),
//                               Container(
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width * 0.38,
//                                 child: TextFormField(
//                                   keyboardType: TextInputType.name,
//                                   controller: _fNameController,
//                                   validator: (val) {
//                                     if (val!.isEmpty) {
//                                       return 'Type your first Name';
//                                     } else if (_fNameValidation()) {
//                                       return 'only characters here';
//                                     }
//                                     return null;
//                                   },
//                                   decoration: InputDecoration(
//                                     fillColor: Colors.white,
//                                     filled: true,
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide:
//                                         BorderSide(color: primarycolor)),
//                                     border: OutlineInputBorder(
//                                       borderSide:
//                                       BorderSide(color: primarycolor),
//                                     ),
//                                     hintStyle: GoogleFonts.nunito(fontSize: 18),
//                                     hintText: 'First Name',
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.1,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Last Name',
//                                 style: GoogleFonts.nunito(fontSize: 18),
//                               ),
//                               Container(
//                                 height: 50,
//                                 width: MediaQuery.of(context).size.width * 0.4,
//                                 child: TextFormField(
//                                   keyboardType: TextInputType.name,
//                                   controller: _lNameController,
//                                   validator: (val) {
//                                     if (val!.isEmpty) {
//                                       return 'Type your Last Name';
//                                     } else if (_lNameValidation()) {
//                                       return 'only characters here';
//                                     }
//                                     return null;
//                                   },
//                                   decoration: InputDecoration(
//                                     fillColor: Colors.white,
//                                     filled: true,
//                                     focusedBorder: OutlineInputBorder(
//                                         borderSide:
//                                         BorderSide(color: primarycolor)),
//                                     border: OutlineInputBorder(
//                                       borderSide:
//                                       BorderSide(color: primarycolor),
//                                     ),
//                                     hintStyle: GoogleFonts.nunito(fontSize: 18),
//                                     hintText: 'Last Name',
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                               width: MediaQuery.of(context).size.width * 0.4,
//                               child: Text(
//                                 'Mobile Number',
//                                 style: GoogleFonts.nunito(fontSize: 18),
//                               ))
//                         ],
//                       ),
//                       Row(children: [
//                         Column(children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.3,
//                             height: 50,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 border:
//                                 Border.all(width: 1, color: primarycolor),
//                                 borderRadius: BorderRadius.circular(5.0)),
//                             child: CountryCodePicker(
//                               initialSelection: 'EG',
//                               onChanged: (value) {
//                                 _countrypick = value;
//                               },
//                             ),
//                           ),
//                         ]),
//                         Column(
//                           children: [
//                             Container(
//                               height: 50,
//                               width: MediaQuery.of(context).size.width * 0.59,
//                               child: TextFormField(
//                                 keyboardType: TextInputType.phone,
//                                 controller: _phonenumController,
//                                 validator: (val) {
//                                   if (val!.isEmpty) {
//                                     return 'Type your number';
//                                   } else if (_phoneNumValidation()) {
//                                     return 'only numbers here';
//                                   }
//                                   return null;
//                                 },
//                                 decoration: InputDecoration(
//                                   fillColor: Colors.white,
//                                   filled: true,
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                       BorderSide(color: primarycolor)),
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(color: primarycolor),
//                                   ),
//                                   hintStyle: GoogleFonts.nunito(fontSize: 18),
//                                   hintText: 'Phone number',
//                                 ),
//                               ),
//                             )
//                           ],
//                         )
//                       ]),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                               width: MediaQuery.of(context).size.width * 0.4,
//                               child: Text(
//                                 'Birthdate',
//                                 style: GoogleFonts.nunito(fontSize: 18),
//                               ))
//                         ],
//                       ),
//                       Container(
//                         height: 50,
//                         child: TextFormField(
//                           readOnly: true,
//                           controller: _dateinput,
//                           decoration: InputDecoration(
//                             hintStyle: GoogleFonts.nunito(fontSize: 18),
//                             hintText:"${selectedDate.day}-0${selectedDate.month}-${selectedDate.year}",
//                             fillColor: Colors.white,
//                             filled: true,
//                             suffixIcon: Icon(Icons.calendar_month_sharp),
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: primarycolor)),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(color: primarycolor),
//                             ),
//                           ),
//                           onTap: () async {
//                             DateTime? pickedDate = await showDatePicker(
//
//                                 context: context, initialDate: DateTime.now(),
//                                 firstDate: DateTime(1950),
//                                 lastDate: DateTime(2023)
//                             );
//
//                             if(pickedDate != null ){
//                               String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                               setState(() {
//                                 _dateinput.text = formattedDate; //set output date to TextField value.
//                               });
//                             }
//
//                           },
//
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                               width: MediaQuery.of(context).size.width * 0.4,
//                               child: Text(
//                                 'Gender',
//                                 style: GoogleFonts.nunito(fontSize: 18),
//                               ))
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Radio(
//                             activeColor: Colors.black,
//                             value: SingingCharacter.m,
//                             groupValue: _character,
//                             onChanged: (SingingCharacter? value) {
//                               setState(() {
//                                 _character= value;
//                               });
//                             },
//                           ),
//                           Text(
//                             'Male',
//                             style: GoogleFonts.nunito(fontSize: 18),
//                           ),
//                           Radio(
//                             activeColor: Colors.black,
//                             value: SingingCharacter.f,
//                             groupValue: _character,
//                             onChanged: (SingingCharacter? value) {
//                               setState(() {
//                                 _character = value;
//                               });
//                             },
//                           ),
//                           Text(
//                             'Female',
//                             style: GoogleFonts.nunito(fontSize: 18),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Container(
//                               width: MediaQuery.of(context).size.width * 0.4,
//                               child: Text(
//                                 'Nationality',
//                                 style: GoogleFonts.nunito(fontSize: 18),
//                               ))
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.89,
//                             height: 50,
//                             child: DropdownButtonFormField(
//
//
//                               value: _selectedValue1,
//
//                               validator: (String? value) {
//                                 if (value!.isEmpty) {
//                                   return "can't be empty";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                 hintStyle: GoogleFonts.nunito(fontSize: 18),
//                                 hintText: 'Egyptian',
//                                 fillColor: Colors.white,
//                                 filled: true,
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide:
//                                     BorderSide(color: primarycolor)),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(color: primarycolor),
//                                 ),
//                               ),
//                               onChanged: (String? value) {
//                                 _selectedValue1 = value!;
//                               },
//                               onSaved: (String? value) {
//                                 _selectedValue1 = value!;
//                               },
//                               items: listOfValue1.map((String val) {
//                                 return DropdownMenuItem(
//                                     value: val, child: Text(val,overflow: TextOverflow.visible,));
//                               }).toList(),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                               width: MediaQuery.of(context).size.width*0.89 ,
//                               child: Text(
//                                 'Your Location',
//                                 style: GoogleFonts.nunito(fontSize: 25),
//                               ))
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                               width: MediaQuery.of(context).size.width * 0.4,
//                               child: Text(
//                                 'Country',
//                                 style: GoogleFonts.nunito(fontSize: 16),
//                               ))
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.89,
//                             height: 50,
//                             child: DropdownButtonFormField(
//                               value: _selectedValue2,
//                               validator: (String? value) {
//                                 if (value!.isEmpty) {
//                                   return "can't be empty";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                 hintStyle: GoogleFonts.nunito(fontSize: 18),
//                                 hintText: 'Egypt',
//                                 fillColor: Colors.white,
//                                 filled: true,
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide:
//                                     BorderSide(color: primarycolor)),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(color: primarycolor),
//                                 ),
//                               ),
//                               onChanged: (String? value) {
//                                 _selectedValue2 = value!;
//                               },
//                               onSaved: (String? value) {
//                                 _selectedValue2 = value!;
//                               },
//
//                               items: listOfValue2.map((String val) {
//                                 return DropdownMenuItem(
//                                     value: val, child: Text(val,overflow: TextOverflow.visible,));
//                               }).toList(),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                               width: MediaQuery.of(context).size.width * 0.4,
//                               child: Text(
//                                 'City',
//                                 style: GoogleFonts.nunito(fontSize: 16),
//                               ))
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.89,
//                             height: 50,
//                             child: DropdownButtonFormField(
//                               value: _selectedValue3,
//                               validator: (String? value) {
//                                 if (value!.isEmpty) {
//                                   return "can't be empty";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                 hintStyle: GoogleFonts.nunito(fontSize: 18),
//                                 hintText: 'Cairo',
//                                 fillColor: Colors.white,
//                                 filled: true,
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide:
//                                     BorderSide(color: primarycolor)),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(color: primarycolor),
//                                 ),
//                               ),
//                               onChanged: (String? value) {
//                                 _selectedValue3 = value!;
//                               },
//                               onSaved: (String? value) {
//                                 _selectedValue3 = value!;
//                               },
//                               items: listOfValue3.map((String val) {
//                                 return DropdownMenuItem(
//                                     value: val, child: Text(val,overflow: TextOverflow.visible));
//                               }).toList(),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                               width: MediaQuery.of(context).size.width * 0.4,
//                               child: Text(
//                                 'Area',
//                                 style: GoogleFonts.nunito(fontSize: 16),
//                               ))
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             width: MediaQuery.of(context).size.width * 0.89,
//                             height: 50,
//                             child: DropdownButtonFormField(
//                               value: _selectedValue4,
//                               validator: (String? value) {
//                                 if (value!.isEmpty) {
//                                   return "can't be empty";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                 hintStyle: GoogleFonts.nunito(fontSize: 18),
//                                 hintText: 'Maadi',
//                                 fillColor: Colors.white,
//                                 filled: true,
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide:
//                                     BorderSide(color: primarycolor)),
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(color: primarycolor),
//                                 ),
//                               ),
//                               onChanged: (String? value) {
//                                 _selectedValue4 = value!;
//                               },
//                               onSaved: (String? value) {
//                                 _selectedValue4 = value!;
//                               },
//                               items: listOfValue4.map((String val) {
//                                 return DropdownMenuItem(
//                                     value: val, child: Text(val,overflow: TextOverflow.visible));
//                               }).toList(),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       if (_isLoading) Center(child: CircularProgressIndicator()),
//                       Center(
//                         child: Container(
//                           width: MediaQuery.of(context).size.width * 0.7,
//                           child: ElevatedButton(
//                               onPressed: () {
//                                 _submit();
//                               },
//                               style: ElevatedButton.styleFrom(
//                                   primary: primarycolor,
//                                   shape: new RoundedRectangleBorder(
//                                     borderRadius:
//                                     new BorderRadius.circular(30.0),
//                                   ),
//                                   minimumSize: Size(0, 50)),
//                               child: Text('Submit and continue',
//                                   style: GoogleFonts.nunito(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white))),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }