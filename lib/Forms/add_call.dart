import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Model/companies.dart';
import 'package:triple_n/Model/users.dart';
import 'package:triple_n/Service/Companies.dart';
import 'package:triple_n/Service/Users.dart';
import 'package:triple_n/Service/add_calls.dart';
import 'package:triple_n/Views/view_call.dart';
import 'package:triple_n/Widget/custom_appbar.dart';
import '../Extras/service.dart';
import 'package:triple_n/Model/users.dart';
import 'package:http/http.dart' as http;

class companys {
  List<dynamic> companies(snapshot) {
    int i = 0;
    List company;
    while (i < snapshot.data.length) {
      company.add(snapshot.data[i].companyTitle);
    }
  }
}

class add_call extends StatefulWidget {
  @override
  _add_callState createState() => _add_callState();
}

class _add_callState extends State<add_call> {
  @override
  String title = "Add Call";
  TextEditingController custname = TextEditingController();
  TextEditingController phoneno = TextEditingController();

  TextEditingController description = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController call_for_txt = TextEditingController();
  TextEditingController attend_by = TextEditingController();

  bool isValidPhoneNumber(String value)=>
    RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)').hasMatch(value ?? '');


  var call_custname;
  var call_phoneno;
  var call_description;
  var call_subject;

  List<String> _list;

  var attender;
  String attender_final;

//  var call_attender;
  var call_for;
  String call_for_final;

  var attender_list = [
    "Farhan",
    "Abubakar",
    "Afzaal",
    "waqar",
    "Asif",
    "kashif",
    "saqib",
  ];

  var call_for_list = [
    "Farhan",
    "Abubakar",
    "Afzaal",
    "waqar",
    "Asif",
    "kashif",
    "saqib",
  ];

  var call_type;
  var call_list_type = ["Incoming", "Outgoing"];

  static const customer_label = "Customer Name";

  static const call_for_label = "Call For";

  static const attend_by_label = "Attended By";

  static const customer_list = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5'
  ];

  final formkey = GlobalKey<FormState>();

  List<Users> User_list;
  List<Users> company_list;

  @override
  void initState() {
    users();
    companies();
//    get_companies();
    super.initState();
  }

  Future<List<Users>> users() async {
    try {
      String url = http_root + users_path;
      var map = Map<String, dynamic>();
      map['action'] = "Users";

      final response = await http.post(url, body: map);

      if (response.statusCode == 200) {
        setState(() {
          final parsed =
              json.decode(response.body).cast<Map<String, dynamic>>();
          User_list =
              parsed.map<Users>((json) => Users.fromJson(json)).toList();
        });
        print(User_list);
//        return User_list;
      } else {
        return List<Users>();
      }
    } catch (e) {
      return List<Users>();
    }
  }

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
      appBar: custom_appbar(title,3),
      body:
//      Form(
//        autovalidateMode: AutovalidateMode.disabled,
//        key: formkey,
//        child:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),

                  //ateender


                  User_list != null
                      ? TextFieldSearch(
                    initialList: User_list.map((e) => e.name).toList(),
                    label: attend_by_label,
                    controller: attend_by,
                    decoration: new InputDecoration(
                      labelText: "Attender",
                      fillColor: Colors.white,
                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: app_color,
                      ),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: app_color, width: 0.0),
                      ),
                      labelStyle: TextStyle(fontSize: 16.0, color: app_color),

                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(color: Colors.blue),
                      ),
                    ),
                  )
                      : CircularProgressIndicator(
                    color: app_color,
                  ),


//                  User_list != null
//                      ? DropdownButtonFormField(
//                          validator: (value) {
//                            if (value == '' || value == null) {
//                              return "Plz Enter Attender";
//                            }
//                          },
//                          decoration: InputDecoration(
//                            enabledBorder: OutlineInputBorder(
//                              borderSide:
//                                  BorderSide(color: app_color, width: 0.0),
//                            ),
////                      errorText: "",
//                            errorStyle: TextStyle(
//                                color: Colors.redAccent, fontSize: 12.0),
//                            border: new OutlineInputBorder(
//                              borderRadius: new BorderRadius.circular(10.0),
//                              borderSide: new BorderSide(color: app_color),
//                            ),
//                          ),
//                          autovalidateMode: AutovalidateMode.onUserInteraction,
//                          hint: attender == null
//                              ? Text(
//                                  'Attender',
//                                  style: TextStyle(color: app_color),
//                                )
//                              : Text(
//                                  attender,
//                                  style: TextStyle(color: app_color),
//                                ),
//                          isExpanded: true,
//                          iconEnabledColor: app_color,
//                           icon: Icon(Icons.arrow_downward),
//                    iconDisabledColor: app_color,
//                          iconSize: 30.0,
//                          style: TextStyle(color: app_color),
//                          items: User_list.map(
//                            (val) {
//                              return DropdownMenuItem<String>(
//                                value: val.id,
//                                child: Text(val.name),
//                                onTap: () {
//                                  attender = val.name;
//                                },
//                              );
//                            },
//                          ).toList(),
//                          onChanged: (val) {
//                            setState(
//                              () {
//                                attender_final = val;
//                              },
//                            );
//                          },
//                        )
//                      : CircularProgressIndicator(
//                          color: app_color,
//                        ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //business customaer
//                 FutureBuilder<List<Companies>>(
//                     future: CompaniesService.companies(),
//                     builder: (context,snapshot){
//                   if(snapshot.hasData){
//                       for(int i=0;i<snapshot.data.length;i++) {
//                           _list.add(snapshot.data[i].companyTitle);
//                       }

                  _list != null
                      ? TextFieldSearch(
                          initialList: _list,
                          label: customer_label,
                          controller: custname,
                          decoration: new InputDecoration(
                            labelText: "Customer/Business name",
                            fillColor: Colors.white,
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 12.0),
                            prefixIcon: Icon(
                              Icons.person,
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

                  //phon no
                  new TextFormField(
                    controller: phoneno,
                    onChanged: (text) {
                      setState(() {
                        call_phoneno = text;
                      });
                    },
                    validator: (value) {
//                      value.isEmpty || value == null
//                      if (isValidPhoneNumber(value) ==true) {
//                        return "";
//                      } else  {
//                        return null;
//                      }

    String pattern =  r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
    return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
    }
    return null;
    },

                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Phone Number",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
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

                  //call for

                  User_list != null
                      ? TextFieldSearch(
                    initialList: User_list.map((e) => e.name).toList(),
                    label:call_for_label,
                    controller: call_for_txt,
                    decoration: new InputDecoration(
                      labelText: "Call For",
                      fillColor: Colors.white,
                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: app_color,
                      ),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: app_color, width: 0.0),
                      ),
                      labelStyle: TextStyle(fontSize: 16.0, color: app_color),

                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(color: Colors.blue),
                      ),
                    ),
                  )
                      : CircularProgressIndicator(
                    color: app_color,
                  ),

//                  User_list != null
//                      ? DropdownButtonFormField(
//                          validator: (value) {
//                            if (value == '' || value == null) {
//                              return "Plz Enter Call for";
//                            }
//                          },
//                          autovalidateMode: AutovalidateMode.onUserInteraction,
//                          decoration: InputDecoration(
//                            enabledBorder: OutlineInputBorder(
//                              borderSide:
//                                  BorderSide(color: app_color, width: 0.0),
//                            ),
////                      errorText: "",
//                            errorStyle: TextStyle(
//                                color: Colors.redAccent, fontSize: 12.0),
//                            border: new OutlineInputBorder(
//                              borderRadius: new BorderRadius.circular(10.0),
//                              borderSide: new BorderSide(color: app_color),
//                            ),
//                          ),
//                          hint: call_for == null
//                              ? Text(
//                                  'From/Attender',
//                                  style: TextStyle(color: app_color),
//                                )
//                              : Text(
//                                  call_for,
//                                  style: TextStyle(color: app_color),
//                                ),
//                          isExpanded: true,
//                          iconEnabledColor: app_color,
//                           icon: Icon(Icons.arrow_downward),
//                    iconDisabledColor: app_color,
//                          iconSize: 30.0,
//                          style: TextStyle(color: app_color),
//                          items: User_list.map(
//                            (val) {
//                              return DropdownMenuItem<String>(
//                                value: val.id,
//                                child: Text(val.name),
//                                onTap: () {
//                                  call_for = val.name;
//                                },
//                              );
//                            },
//                          ).toList(),
//                          onChanged: (val) {
//                            setState(
//                              () {
//                                call_for_final = val;
//                              },
//                            );
//                          },
//                        )
//                      : CircularProgressIndicator(
//                          color: app_color,
//                        ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //Subject
                  new TextFormField(
                    controller: subject,
                    onChanged: (text) {
                      setState(() {
                        call_subject = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter Subject ";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Subject",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.subject,
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

                  //Call type
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == '' || value == null) {
                        return "Plz Enter Call type";
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: app_color, width: 0.0),
                      ),
//                      errorText: "",
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: new BorderSide(color: app_color),
                      ),
                    ),
                    hint: call_type == null
                        ? Text(
                            'Call type',
                            style: TextStyle(color: app_color),
                          )
                        : Text(
                            call_type,
                            style: TextStyle(color: app_color),
                          ),
                    isExpanded: true,
                    iconEnabledColor: app_color,
                     icon: Icon(Icons.arrow_downward),
                    iconDisabledColor: app_color,
                    iconSize: 30.0,
                    style: TextStyle(color: app_color),
                    items: call_list_type.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          call_type = val;
                        },
                      );
                    },
                  ),

                  SizedBox(
                    height: 30.0,
                  ),



                  new TextFormField(
                    controller: description,
                    onChanged: (text) {
                      setState(() {
                        call_description = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter Remarks";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    minLines: 3,
                    maxLines: null,
                    decoration: new InputDecoration(
                      labelText: "Remarks",
                      fillColor: Colors.white,
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 12.0),
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
                  //button



                  SizedBox(
                    height: 30.0,
                  ),



                  GestureDetector(
                    onTap: () {
//                      if (formkey.currentState.validate()) {
                        print('valid');
                        String now_date = DateTime.now().toString();
                        var now = new DateTime.now();
                        var formatter = new DateFormat('yyyy-MM-dd');
                        var formattedDate = formatter.format(now);

                        print(formattedDate);
                        print(attender_final);
                        print(custname.text);
                        print(call_for_final);
                        Data_processing_Message();

                        Services.add_calls(
                          attender_final,
                          custname.text,
                          phoneno.text,
                          call_for_final,
                          subject.text,
                          description.text,
                          call_type,
                          formattedDate,
                        ).whenComplete(() {
                          Data_added_Message();

                          Timer(Duration(seconds: 2), () {

                            Get.back();
                            Get.off(add_call());

                          });
                        }).onError((error, stackTrace) {
                          Error_message(error);
                        });

//                            .then((value) {
//                          if ("success" == value) {
//                            print("succes");
//                          }
//                        });

                    //comment strt
//                      } else if (custname.text.isEmpty) {
//                        ScaffoldMessenger.of(context).showSnackBar(
//                          const SnackBar(
//                              content: Text('plz fill customer name')),
//                        );
//                      } else {
//                        ScaffoldMessenger.of(context).showSnackBar(
//                          const SnackBar(content: Text('plz fill the fields')),
//                        );
//                      }
                    //end


//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => Loginpage()),
//                  );
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
                          'Generate Inquiry'.toUpperCase(),
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
