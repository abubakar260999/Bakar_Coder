import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Model/companies.dart';
import 'package:triple_n/Service/Companies.dart';
import 'package:triple_n/Service/add_appointments.dart';
import 'package:triple_n/Views/view_appointments.dart';
import 'package:triple_n/Widget/custom_appbar.dart';
import '../Extras/service.dart';
import 'package:http/http.dart' as http;

class add_appoitment extends StatefulWidget {
  @override
  _add_appoitmentState createState() => _add_appoitmentState();
}

class _add_appoitmentState extends State<add_appoitment> {
  @override
  var title = "Add appointment";

  TextEditingController appointment_name = TextEditingController();
  TextEditingController appointment_custname = TextEditingController();
  TextEditingController appintment_date = TextEditingController();
  TextEditingController appintment_time = TextEditingController();
  TextEditingController appintment_phoneno = TextEditingController();
  TextEditingController appintment_description = TextEditingController();

//  var app_name;
//  var app_custname;
//  var app_date;
//  var app_time;
//  var app_phoneno;
//  var app_description;

  final formKey = GlobalKey<FormState>();

  List _list = new List();
  static const customer_label = "Customer Name";


  @override
  void initState() {
    companies();
    appintment_date.text = ""; //set the initial value of text field
    super.initState();
  }


//  bool _validate = false;
//
//  Validator(String validate) {
//    setState(() {
//      if (validate.isEmpty) {
//        _validate = true;
//      } else {
//        _validate = false;
//      }
//    });
//  }

  bool _autovalidate = false;



  Future<List<Companies>> companies() async {
    try {
//      192.168.10.135
      String url = http_root + cooperation_path;
      var map = Map<String, dynamic>();
      map['action'] = "Company";
      final response = await http.get(url);
      List<Companies> result = [];

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        result = parsed.map<Companies>((json) => Companies.fromJson(json)).toList();

        print(result);
        _list = [];
        for (var c in result) {
          //idhar galti hai issue kia h

          _list.add(c.companyTitle);
        }
        print(json.encode(_list));
        print("heello");

        setState(() {});
      } else {
        return List<Companies>();
      }
    } catch (e) {
      return List<Companies>();
    }
  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custom_appbar(title,2),
      body:
//      Form(
//        key: formKey,
//        autovalidateMode: AutovalidateMode.disabled,
        //child:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),

                  //full name
                  new TextFormField(
                    controller: appointment_name,
                    validator: (value) {
                      if (value.isEmpty||value==null) {
                        return "Plz Enter appointment name ";
                      }
                      else{
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Name",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      prefixIcon: Icon(
                        Icons.person,
                        color: app_color,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: app_color, width: 0.0),
                      ),
                      labelStyle: TextStyle(fontSize: 18.0, color: app_color),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //busness name
//                 FutureBuilder<List<Companies>>(
//                      future: CompaniesService.companies(),
//                      builder: (context,snapshot){
//                        if(snapshot.hasData){
//                          for(int i=0;i<snapshot.data.length;i++) {
//                              _list.add(snapshot.data[i].companyTitle);
//                          }
//                          return TextFieldSearch(
//                            initialList:_list,
//                            label: customer_label,
//                            controller: appointment_custname,
//                            decoration: new InputDecoration(
//                              labelText: "Customer/Business name",
//                              fillColor: Colors.white,
//                              errorStyle:
//                              TextStyle(color: Colors.redAccent, fontSize: 12.0),
//                              prefixIcon: Icon(
//                                Icons.person,
//                                color: app_color,
//                              ),
//                              enabledBorder: OutlineInputBorder(
//                                borderSide: BorderSide(color: app_color, width: 0.0),
//                              ),
//                              labelStyle: TextStyle(fontSize: 18.0, color: app_color),
//                              border: new OutlineInputBorder(
//                                borderRadius: new BorderRadius.circular(10.0),
//                                borderSide: new BorderSide(color: Colors.blue),
//                              ),
//                            ),
//                          );
//                        }
//                        else{
//
//                          return CircularProgressIndicator(
//                            color: app_color,
//                          );
//                        }
//
//                      }),



                  _list != null
                       ? TextFieldSearch(
                    initialList: _list,
                    label: customer_label,
                    controller: appointment_custname,
                    decoration: new InputDecoration(
                      labelText: "Customer/Business name",
                      fillColor: Colors.white,
                      errorStyle: TextStyle(
                          color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: app_color,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: app_color, width: 0.0),
                      ),
                      labelStyle:
                      TextStyle(fontSize: 18.0, color: app_color),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(color: Colors.blue),
                      ),
                    ),
                  )
                      : CircularProgressIndicator(
                    color: app_color,
                  ),


                  SizedBox(
                    height: 30.0,
                  ),


                  TextFormField(
                    controller: appintment_date,

                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter appintment date";
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    //editing controller of this TextField
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: app_color, width: 0.0),
                        ),
                        labelStyle: TextStyle(fontSize: 18.0, color: app_color),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(color: Colors.blue),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: app_color,
                        ),
                        //icon of text field
                        labelText: "Enter Date" //label text of field
                        ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          appintment_date.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //time
                  new TextFormField(
                    controller: appintment_time,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter appintment Time";
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    decoration: new InputDecoration(
                      labelText: "Time HH:MM",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      prefixIcon: Icon(
                        Icons.access_alarm,
                        color: app_color,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: app_color, width: 0.0),
                      ),
                      labelStyle: TextStyle(fontSize: 18.0, color: app_color),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //PHONE
                  new TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: appintment_phoneno,
                    validator: (value) {
//                      if (value.isEmpty || value == null) {
//                        return "Plz Enter Phone number";
//                      }
    String pattern =  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
    return 'Please enter Email';
    }
    else if (!regExp.hasMatch(value)) {
    return 'Please enter valid Email';
    }
    return null;
    },

//                      },

                    decoration: new InputDecoration(
                      labelText: "Phone number",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: app_color,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: app_color, width: 0.0),
                      ),
                      labelStyle: TextStyle(fontSize: 18.0, color: app_color),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //Description
                  new TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: appintment_description,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter appintment Name";
                      }
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                    decoration: new InputDecoration(
                      labelText: "Description/Remarks",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      prefixIcon: Icon(
                        Icons.description,
                        color: app_color,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: app_color, width: 0.0),
                      ),
                      labelStyle: TextStyle(fontSize: 18.0, color: app_color),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
//                      if (formKey.currentState.validate()) {
                        print('valid');

                        Data_processing_Message();

                       Services.add_appointment(
                         appintment_date.text,
                         appointment_name.text,
                         appintment_phoneno.text,
                         appointment_custname.text,
                         "New",
                         appintment_description.text,
                         appintment_time.text
                       ).whenComplete(() {

                           Data_added_Message();

                           Timer(Duration(seconds: 2), () {
                             Get.back();
                             Get.off(add_appoitment());
                           });


                       }).onError((error, stackTrace) {
                         Error_message(error);
                       });

//                      . then((value){
//                        print(value.toString());
//
//String succes='succes';
//                         if(value.compareTo('succes') == 0){
//                            print("hello");
//                           Data_added_Message();
//                           return Timer(Duration(seconds: 2), () {
//                             Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (BuildContext context) =>
//                                     super.widget));
//                           });
////
//                         }else{
//                           Error_message("error");
//
//                         }
//
//
//                       });

//                       setState(() {
//                         appintment_date.clear();
//                         appointment_name.clear();
//                         appintment_phoneno.clear();
//                         appointment_custname.clear();
//                         appintment_description.clear();
//                         appintment_time.clear();
//                       });

//   end  }


                  },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              app_color,
                              app_color,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          'Submit'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),
        ),
//      ),
    );
  }
}
