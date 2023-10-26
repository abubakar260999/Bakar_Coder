import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Model/users.dart';
import 'package:triple_n/Service/add_dailytask.dart';
import 'package:triple_n/Views/view_daily_task.dart';
import 'package:triple_n/Widget/custom_appbar.dart';
import 'package:triple_n/Service/user_profile.dart';
import 'package:triple_n/Authetication/storage.dart';

class add_daily_task extends StatefulWidget {
  @override
  _add_daily_taskState createState() => _add_daily_taskState();
}

class _add_daily_taskState extends State<add_daily_task> {
  @override



  List<Users> user_data_list = [];
  var email;
  String user_id;



  Future get_email() async {
    email = await usesecurestorage.read_data();
//  email="abubakar@abconline.us";
    setState(() {});
    print(email);
  }

  Future get_data() async {
    get_email().whenComplete(() async {
      user_data_list = await data.users(email);
      setState(() {
        user_id = user_data_list[0].id;
      });
    });
  }

  void initState() {
    super.initState();
    get_data();
    getCurrentDate();

  }


  var title = "Add Daily Task";

  TextEditingController daily_task_title = TextEditingController();
  TextEditingController daily_task_start_time = TextEditingController();
  TextEditingController daily_task_end_time = TextEditingController();
  TextEditingController daily_task_detail = TextEditingController();
  TextEditingController daily_task_date = TextEditingController();
  TextEditingController daily_task_status = TextEditingController();


 String task_title;
 String task_start_time;
  String task_end_time;
String task_date;

  getCurrentDate() {

    setState(() {
      task_date= DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    });

  }


  String task_detail;
  String task_status;

//  String user="5";
  var status_list = [
   "Complete",
    "Continue"
  ];

  final formKey = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: custom_appbar(title,1),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: SingleChildScrollView(
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
                    controller: daily_task_title,
                    onChanged: (text) {
                      setState(() {
                        task_title = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter Task Title ";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Task Title",
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


                  //start time

              TextFormField(
                validator: (value) {
                  if (value.isEmpty||value==null) {
                    return "Plz Enter start Time ";
                  }
                  else{
                    return null;
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      Icons.timer,
                      color: app_color,
                    ),
                    //icon of text field
                    labelText: "Enter Start Time" //label text of field
                ),
                controller: daily_task_start_time,
                //editing controller of this TextField
                readOnly: true,
                //set it true, so that user will not able to edit text
                onTap: () async {
                  TimeOfDay pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  if (pickedTime != null) {
                    print(pickedTime.format(context)); //output 10:51 PM
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());
                    //converting to DateTime so that we can further format on different pattern.
                    print(parsedTime); //output 1970-01-01 22:53:00.000
                    String formattedTime =
                    DateFormat('HH:mm:ss').format(parsedTime);
                    print(formattedTime); //output 14:59:00
//                    DateFormat();
                    //is from intl package, you can format the time on any pattern you need
                    setState(() {
                      daily_task_start_time.text =
                          formattedTime; //set the value of text field.
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
              ),


                  SizedBox(
                    height: 30.0,
                  ),

                  //end time
                  TextFormField(

                    validator: (value) {
                      if (value.isEmpty||value==null) {
                        return "Plz Enter End Time ";
                      }
                      else{
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          Icons.timer,
                          color: app_color,
                        ),
                        //icon of text field
                        labelText: "Enter End Time" //label text of field
                    ),
                    controller: daily_task_end_time,
                    //editing controller of this TextField
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context)); //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime =
                        DateFormat('HH:mm:ss').format(parsedTime);
                        print(formattedTime); //output 14:59:00
//                    DateFormat();
                        //is from intl package, you can format the time on any pattern you need
                        setState(() {
                          daily_task_end_time.text =
                              formattedTime; //set the value of text field.
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),






                  SizedBox(
                    height: 30.0,
                  ),


                  TextFormField(
                    controller: daily_task_date,

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
                        labelText: task_date, //label text of field
                        ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //Status

                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == '' || value == null) {
                        return "Plz Enter Task status";
                      }

                    },
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hint: task_status == null
                        ? Text(
                      'status',
                      style: TextStyle(color: app_color),
                    )
                        : Text(
                      task_status,
                      style: TextStyle(color: app_color),
                    ),
                    isExpanded: true,
                    iconEnabledColor: app_color,
                     icon: Icon(Icons.arrow_downward),
                    iconDisabledColor: app_color,
                    iconSize: 30.0,
                    style: TextStyle(color: app_color),
                    items: status_list.map(
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
                          task_status = val;
                        },
                      );
                    },
                  ),

                  SizedBox(
                    height: 30.0,
                  ),


                  //detail/description
                  new TextFormField(
                    controller: daily_task_detail,
                    onChanged: (text) {
                      setState(() {
                        task_detail = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty||value==null) {
                        return "Plz Enter Details/Note";
                      }
                      else{
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: null,
                    decoration: new InputDecoration(
                      labelText: "Details/Note",
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

                  SizedBox(
                    height: 30.0,
                  ),



                  SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState.validate()) {
                        print('valid');

                        print(task_title);
                        print(task_detail);
                        print(daily_task_end_time.text);
                        print(daily_task_start_time.text);
                        print(task_status);
                        print(task_date);
                        print(user_id);

                        Data_processing_Message();


//                        Data_added_Message();
                        Services.add_daily_task(
                                task_title,
                                daily_task_start_time.text,
                            daily_task_end_time.text,
                                task_detail,
                                task_date,
                                task_status,
                          user_id
                        ).whenComplete(() {

                            Data_added_Message();

                            Timer(Duration(seconds: 2), () {

                              Get.back();
                              Get.off(add_daily_task());

                            });


                        }).onError((error, stackTrace) {
                          Error_message(error);
                        });



//                  Navigator.push(
                      }
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
      ),
    );
  }
}
