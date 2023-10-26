import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Model/users.dart';
import 'package:triple_n/Service/Users.dart';
import 'package:triple_n/Service/add_task.dart';
import 'package:triple_n/Views/view_task.dart';
import 'package:triple_n/Widget/custom_appbar.dart';
import '../Extras/service.dart';

import 'package:triple_n/Model/users.dart';
import 'package:http/http.dart' as http;

class add_task extends StatefulWidget {
  @override
  _add_taskState createState() => _add_taskState();
}

//done
class _add_taskState extends State<add_task> {
  @override


  var status="Not started";
  var status_list = [
    "Just Started",
    "Continue",
    "Updated",
//    "Complete",
    "Under Review",
    "Waiting",
    "Not started"
  ];

  String client = "new";
  var client_list = ["New Client"];

  String priorty="High";

  var priorty_list = [
    "High",
    "Medium",
    "Low",
  ];

  String task_owner;
  var task_name;
  String task_owner_final;
  String assigned_by;
  String assigned_by_final;
  String assigned_to;
  String assigned_to_final;

  String task_subject;
  String task_description;

  //time
  DateTime Picked_Due_Date = DateTime.now();
  bool flag_of_due_date_done = false;
  String Due_Date = "";
  String Start_Date = "";

  List fileNames = [];
  List<File> files = [];
  bool file_done = false;

  List assign_to_users = [];

  TextEditingController startdate = TextEditingController();
  TextEditingController duedate = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController task_owner_txt = TextEditingController();
  TextEditingController assign_to_txt = TextEditingController();
  TextEditingController assign_by_txt = TextEditingController();


  static const task_owner_label = "Task Owner";
  static const assigned_by_label = "Assigned by";
//  static const assign_to_label = "Assigned To";


  List<Users> User_list;

  @override
  void initState() {
    startdate.text = "";
    duedate.text = "";
    timeinput.text = "";
    users();
    super.initState();
  }

  bool done = false;
  final formkey = GlobalKey<FormState>();

  Future<List<Users>> users() async {
    try {
      String url = http_root + users_path;
      var map = Map<String, dynamic>();
      map['action'] = "Users";

      final response = await http.post(url, body: map);

      if (response.statusCode == 200) {
        setState(() {
          final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
          User_list = parsed.map<Users>((json) => Users.fromJson(json)).toList();
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


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custom_appbar("Add Tickets", 0),
      body:
//      Form(
//        key: formkey,
//        autovalidateMode: AutovalidateMode.disabled,
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

                  //Task Owner
                  User_list != null
                      ? TextFieldSearch(
                    initialList: User_list.map((e) => e.name).toList(),
                    label: task_owner_label,
                    controller: task_owner_txt,
                    decoration: new InputDecoration(
                      labelText: "Task Owner",
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



//                  (User_list != null) ? DropdownButtonFormField(
//                          validator: (value) {
//                            if (value == '' || value == null) {
//                              return "Plz Enter Task Owner";
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
//                          hint: task_owner == null
//                              ? Text(
//                                  'Task Owner',
//                                  style: TextStyle(color: app_color),
//                                )
//                              : Text(
//                                  task_owner,
//                                  style: TextStyle(color: app_color),
//                                ),
//                          isExpanded: true,
//                             iconEnabledColor: app_color,
//                    icon: Icon(Icons.arrow_downward),
//                          iconDisabledColor: app_color,
//                          iconSize: 30.0,
//                          style: TextStyle(color: app_color),
//                          items: User_list.map(
//                            (val) {
//                              return DropdownMenuItem<String>(
//                                value: val.id,
//                                child: Text(val.name),
//                                onTap: () {
//                                  setState(() {
//                                    task_owner = val.name;
//                                  });
//                                },
//                              );
//                            },
//                          ).toList(),
//                          onChanged: (val) {
//                            setState(() {
//                              print(val);
//                              task_owner_final = val;
//                            });
//                          },
//                        )
//                      : CircularProgressIndicator(),

                  SizedBox(
                    height: 30.0,
                  ),

                  //New client
//                  DropdownButtonFormField(
//                    validator: (value) {
//                      if (value == '' || value == null) {
//                        return "Plz Enter Client";
//                      }
//                    },
//                    decoration: InputDecoration(
//
//                      enabledBorder: OutlineInputBorder(
//                        borderSide: BorderSide(color: app_color, width: 0.0),
//                      ),
////                      errorText: "",
//                      errorStyle:
//                      TextStyle(color: Colors.redAccent, fontSize: 12.0),
//                      border: new OutlineInputBorder(
//                        borderRadius: new BorderRadius.circular(10.0),
//                        borderSide: new BorderSide(color: app_color),
//                      ),
//                    ),
//                    autovalidateMode: AutovalidateMode.onUserInteraction,
//                    hint: client == null
//                        ? Text(
//                      'Client',
//                      style: TextStyle(color: app_color),
//                    )
//                        : Text(
//                      client,
//                      style: TextStyle(color: app_color),
//                    ),
//                    isExpanded: true,
//                       iconEnabledColor: app_color,
//                    icon: Icon(Icons.arrow_downward),
//                    iconDisabledColor: app_color,
//                    iconSize: 30.0,
//                    style: TextStyle(color: app_color),
//                    items: client_list.map(
//                          (val) {
//                        return DropdownMenuItem<String>(
//                          value: val,
//                          child: Text(val),
//                        );
//                      },
//                    ).toList(),
//                    onChanged: (val) {
//                      setState(
//                            () {
//                          client = val;
//                        },
//                      );
//                    },
//                  ),
//
//
//                  SizedBox(
//                    height: 30.0,
//                  ),

                  //Assigned by

//assign_by

                  User_list != null
                      ? TextFieldSearch(
                    initialList: User_list.map((e) => e.name).toList(),
                    label: assigned_by_label,
                    controller: assign_by_txt,
                    decoration: new InputDecoration(
                      labelText: "Assigned by",
                      fillColor: Colors.white,
                      errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                      CupertinoIcons.search,
                        color: app_color,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: app_color, width: 0.0),
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
//                              return "Plz Enter Assigned By";
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
//                          hint: assigned_by == null
//                              ? Text(
//                                  'Assigned By',
//                                  style: TextStyle(color: app_color),
//                                )
//                              : Text(
//                                  assigned_by,
//                                  style: TextStyle(color: app_color),
//                                ),
//                          isExpanded: true,
//                             iconEnabledColor: app_color,
//                    icon: Icon(Icons.arrow_downward),
//                          iconDisabledColor: app_color,
//                          iconSize: 30.0,
//                          style: TextStyle(color: app_color),
//                          items: User_list.map(
//                            (val) {
//                              return DropdownMenuItem<String>(
//                                value: val.id,
//                                child: Text(val.name),
//                                onTap: () {
//                                  setState(() {
//                                    assigned_by = val.name;
//                                  });
//                                },
//                              );
//                            },
//                          ).toList(),
//                          onChanged: (val) {
//                            setState(
//                              () {
//                                assigned_by_final = val;
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

//MULTI assign to

                  User_list != null
                      ? MultiSelectDialogField(
                          searchable: true,
//                          backgroundColor:app_color.withOpacity(0.2),
                          searchIcon: Icon(CupertinoIcons.search),
                          items: User_list.map((val) => MultiSelectItem(val.id, val.name)).toList(),

                          listType: MultiSelectListType.CHIP,
                          validator: (value) {
                            if (value == '' || value == null) {
                              return "Plz Enter Assigned To";
                            }
                          },
                     buttonText: Text(
                       "Assign To",style:TextStyle(
                       color: app_color
                     ),
                     ),
                          buttonIcon: Icon(
                            Icons.arrow_downward,
                            color: app_color,
                            size: 24.0,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              border: Border.all(width: 0.0, color: app_color)),
                          selectedColor: app_color,
                          selectedItemsTextStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),

                          itemsTextStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                          onConfirm: (values) {
                            assign_to_users = values;
                            print(assign_to_users);
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: app_color,
                          ),
                        ),

//   User_list!=null ?
//  DropdownButtonFormField(
//  validator: (value) {
//    if (value == '' || value == null) {
//      return "Plz Enter Assigned To";
//    }
//  },
//  decoration: InputDecoration(
//
//    enabledBorder: OutlineInputBorder(
//      borderSide: BorderSide(color: app_color, width: 0.0),
//    ),
////                      errorText: "",
//    errorStyle:
//    TextStyle(color: Colors.redAccent, fontSize: 12.0),
//    border: new OutlineInputBorder(
//      borderRadius: new BorderRadius.circular(10.0),
//      borderSide: new BorderSide(color: app_color),
//    ),
//  ),
//  autovalidateMode: AutovalidateMode.onUserInteraction,
//  hint: assigned_to == null
//      ? Text(
//    'Assigned To',
//    style: TextStyle(color: app_color),
//  )
//      : Text(
//    assigned_to,
//    style: TextStyle(color: app_color),
//  ),
//  isExpanded: true,
//     iconEnabledColor: app_color,
//                    icon: Icon(Icons.arrow_downward),
//  iconDisabledColor: app_color,
//  iconSize: 30.0,
//  style: TextStyle(color: app_color),
//  items: User_list.map(
//        (val) {
//      return DropdownMenuItem<String>(
//        value: val.id,
//        child: Text(val.name),
//        onTap: (){
//        setState(() {
//          assigned_to=val.name;
//        });
//        },
//      );
//    },
//  ).toList(),
//  onChanged: (val) {
//    setState(
//          () {
//        assigned_to_final = val;
//      },
//    );
//  },
//):CircularProgressIndicator(
//    color: app_color,
//  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  new TextFormField(
                    controller: subject,
                    onChanged: (text) {
                      setState(() {
                        task_subject = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter Subject, ";
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

                  //priorty
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == '' || value == null) {
                        return "Plz Enter Priorty";
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
                    hint: priorty == null
                        ? Text(
                            'Priorty',
                            style: TextStyle(color: app_color),
                          )
                        : Text(
                            priorty,
                            style: TextStyle(color: app_color),
                          ),
                    isExpanded: true,
                       iconEnabledColor: app_color,
                    icon: Icon(Icons.arrow_downward),
                    iconDisabledColor: app_color,
                    iconSize: 30.0,
                    style: TextStyle(color: app_color),
                    items: priorty_list.map(
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
                          priorty = val;
                        },
                      );
                    },
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //start date
                  TextFormField(
                    controller: startdate,

                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter start date ";
                      } else {
                        return null;
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
                        labelText: "Start Date" //label text of field
                        ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime pickedTime = await DateTime.now();
                      DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        setState(() {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          startdate.text = formattedDate;
                          final toutc = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute);
                          Start_Date =
                              DateFormat("yyyy-MM-dd HH:mm:ss").format(toutc);
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //due date

                  TextFormField(
                    controller: duedate,
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter Due date ";
                      } else {
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
                          Icons.calendar_today,
                          color: app_color,
                        ),
                        //icon of text field
                        labelText: "Due Date" //label text of field
                        ),
                    readOnly: true,
                    onTap: () async {
                      DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        final String formatted_Due_Date =
                            DateFormat('yyyy-MM-dd').format(pickedDate);

                        setState(() {
                          Picked_Due_Date = pickedDate;
                          duedate.text = formatted_Due_Date;
                          flag_of_due_date_done =
                              true; //set output date to TextField value.
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
                  Visibility(
                    visible: flag_of_due_date_done,
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return "Plz Enter Time ";
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
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
                          prefixIcon: Icon(
                            Icons.timer,
                            color: app_color,
                          ),
                          //icon of text field
                          labelText: "Enter Time" //label text of field
                          ),
                      controller: timeinput,
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

                          setState(() {
                            final toUTC = DateTime(
                                Picked_Due_Date.year,
                                Picked_Due_Date.month,
                                Picked_Due_Date.day,
                                parsedTime.hour,
                                parsedTime.minute);
                            Due_Date =
                                DateFormat("yyyy-MM-dd HH:mm:ss").format(toUTC);
                            timeinput.text = pickedTime.format(context);

                            print(toUTC);
                            print(timeinput.text);
                          });
                        } else {
                          print("Time is not selected");
                        }
                      },
                    ),
                  ),

                  Visibility(
                    visible: flag_of_due_date_done,
                    child: SizedBox(
                      height: 30.0,
                    ),
                  ),

                  //status
                  DropdownButtonFormField(
                    validator: (value) {
                      if (value == '' || value == null) {
                        return "Plz Enter Status";
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
                    hint: status == null
                        ? Text(
                            'Status',
                            style: TextStyle(color: app_color),
                          )
                        : Text(
                            status,
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
                          status = val;
                        },
                      );
                    },
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //description
                  new TextFormField(
                    controller: description,
                    onChanged: (text) {
                      setState(() {
                        task_description = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter Description";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                    decoration: new InputDecoration(
                      labelText: "Description/Remarks",
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

                  GestureDetector(
                    onTap: () async {
                      FilePickerResult result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: true,
                        type: FileType.any,
                      );

                      if (result != null) {
                        setState(() {
                          files =
                              result.paths.map((path) => File(path)).toList();
                          Uint8List fileBytes = result.files.first.bytes;
                          String fileName = result.files.first.name;
                          fileNames = result.files.map((e) => e.name).toList();
                          print(result.files.map((e) => e.name).toList());
                          file_done = true;
                        });
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: app_color,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          'Choose File'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18.0,
                              color: app_color,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),
//file show

                  Visibility(
                    visible: file_done,
                    child: Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                fileNames.isNotEmpty ? fileNames.length : 0,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    fileNames[index],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: app_color,
                                      fontFamily: "poppins",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            })),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  GestureDetector(
                    onTap: () {
//                      if (formkey.currentState.validate()) {
                        print('valid');
//                        Date_time_task(startdate.text,);

                        Data_processing_Message();

                        print(task_owner_final);
                        print("done");
                        print(assigned_by_final);

                        Services.task(
                          task_owner_txt.text,
                          "0",
                          assign_by_txt.text,
//                          assigned_to_final,
                         assign_to_users,
                          task_subject,
                          priorty,
                          task_description,
                          Start_Date,
                          Due_Date,
                          status,
                          files,
                        ).whenComplete(() {
                          Data_added_Message();

                          Timer(Duration(seconds: 2), () {
                            Get.back();
                            Get.off(add_task());
                          });
                        }).onError((error, stackTrace) {
                          Error_message(error);
                        });
//

//                      }


//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => Loginpage()),
//                  );
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
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
                          'Done'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
