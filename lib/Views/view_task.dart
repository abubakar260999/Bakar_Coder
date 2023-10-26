import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:triple_n/Forms/add_task.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
//import 'package:triple_n/Global/status_global.dart';
import 'package:triple_n/Model/task_manager.dart';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Model/users.dart';
import 'package:triple_n/Service/Users.dart';
import 'package:triple_n/Ui/home.dart';
import '../Widget/task_widget.dart';
import 'package:triple_n/Widget/global_button.dart';
import 'package:triple_n/Authetication/storage.dart';
import 'package:triple_n/Widget/newdetailview_task.dart';

import 'detailview_task.dart';

class view_task extends StatefulWidget  {
  @override


  _view_taskState createState() => _view_taskState();
}

class Debouncer {
  int milliseconds;
  VoidCallback action;
  Timer timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}



class _view_taskState extends State<view_task> {
  @override


  final TextEditingController searchtxt = TextEditingController();
  Widget showbar =view_appbar_txt("Tickets");

  final RefreshController _refreshController = RefreshController(initialRefresh: true);
  List<TaskManager> task_manager_list = [];
  int current_page = 0, current_search_page = 0;
  String searchedWord = "";

  final TextEditingController task_date = TextEditingController();
  String task_user_name;
  int task_user;
  String task_status;

  int tas_user;

  String tas_date = "";
  String tas_status = "";

  bool no_data_present=false;

  bool onsearch = false;
  bool filter_flag =false;
  int current_filter_page = 0;

  List empty_assign_to=["Empty"];
  var status_list = [
    "Just Started",
    "Continue",
    "Updated",
    "Complete",
    "Under Review",
    "Waiting",
  ];

  onstart() async {
    await task_manager(isReload: true);
  }


  var email;

  void initState() {
    super.initState();
    email="";
    filter_flag = false;
    onstart();
  }
  Future get_email() async{

    var obtained_email=await usesecurestorage.read_data();

    setState(() {
      email=obtained_email;
    });


  }

  //simple data
  Future<List<TaskManager>> task_manager({bool isReload = false}) async {
    try {
      if (isReload) {
        current_page = 0;
      }
      get_email().whenComplete(() async {
        print(email);
        String flag = "onstart";
        String url = http_root + "task_manager.php?page_no=$current_page&size=20&&email=$email&flag=$flag";

        final response = await http.get(url);
        List<TaskManager> result = [];
        if (response.statusCode == 200) {
          final parsed = json.decode(response.body).cast<
              Map<String, dynamic>>();
          print(parsed.map<TaskManager>((json) => TaskManager.fromJson(json))
              .toList());
          result = parsed.map<TaskManager>((json) => TaskManager.fromJson(json))
              .toList();

//        if (result != null && result.isNotEmpty) {
          task_manager_list.addAll(result);
          current_page++;

          setState(() {
            setState(() {
              if (task_manager_list == [] || task_manager_list.isEmpty) {
                no_data_present = true;
              }
            });
          });
        }
        return result;
//      } else {
//        return <TaskManager>[];
//      }
      });
    } catch (e) {
      return <TaskManager>[];
    }
  }

//searched data
  Future<List<TaskManager>> task_manager_onsearch(
      {bool isReload = false, String word}) async {
    try {
      if (isReload) {
        current_search_page = 0;
      }

      get_email().whenComplete(() async {
        String flag = "onsearch";
        String url = http_root +
            "task_manager.php?page_no=$current_search_page&size=5&word=$word&email=$email&&flag=$flag";
        final response = await http.get(url);
        List<TaskManager> result = [];
        if (response.statusCode == 200) {
          final parsed = json.decode(response.body).cast<
              Map<String, dynamic>>();
          result = parsed
              .map<TaskManager>((json) => TaskManager.fromJson(json))
              .toList();
//          if (result != null && result.isNotEmpty) {
          this.searchedWord = word;
          current_search_page++;
          task_manager_list.addAll(result);
          setState(() {
            if(task_manager_list==[] || task_manager_list.isEmpty)
            {
              no_data_present=true;
            }
          });

        }
//          if (result != null && result.isNotEmpty) {
        return result;
//          }
//        } else {
//          return <TaskManager>[];
//        }
      });
    } catch (e) {
      return <TaskManager>[];
    }
  }


  Future<List<TaskManager>> task_filter_manager(
      {bool isReload = false, int tas_user, String tas_date, String tas_status}) async {
    try {
      if (isReload) {
        current_filter_page = 0;
      }

      print(tas_user);

      get_email().whenComplete(() async {
        String flag = "onfilter";
        String url = http_root +
            "task_manager.php?page_no=$current_filter_page&size=20&user=$tas_user&date=$tas_date&status=$task_status&email=$email";
        final response = await http.get(url);
        List<TaskManager> result = [];
        if (response.statusCode == 200) {
          final parsed = json.decode(response.body).cast<
              Map<String, dynamic>>();
          result = parsed
              .map<TaskManager>((json) => TaskManager.fromJson(json))
              .toList();

          print(result);
//          if (result != null && result.isNotEmpty) {
//          this.app_name = task_manager_name.text;
//          this.app_date=appintment_date.text;
//          this.app_phno=task_manager_phoneno.text;
          current_filter_page++;
          task_manager_list.addAll(result);
          setState(() {
            if(task_manager_list==[] || task_manager_list.isEmpty)
            {
              no_data_present=true;
            }
          });
          return result;
//          } else {
//            return <TaskManager>[];
//          }
        }
      });
    } catch (e) {
      return <TaskManager>[];
    }
  }

  //wait for search

  final _debouncer = Debouncer();

  Widget build(BuildContext context) {

    AlertDialog Filter = AlertDialog(
      title: Center(
        child: Text(
          "Filters",
          style: TextStyle(
              fontSize: 24.0,
              fontFamily: "poppins",
              fontWeight: FontWeight.w500,
              color: app_color),
        ),
      ),
      content: Container(
        height: 200,
        child: Column(
          children: [

            Container(
              height: 60,
              child: FutureBuilder<List<Users>>(
                  future: UsersService.users(),
                  builder: (context,snapshot)
                  {

                    if(snapshot.hasData){
                      return DropdownButtonFormField(

                        decoration: InputDecoration(

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: app_color, width: 0.0),
                          ),
//                      errorText: "",

                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(color: app_color),
                          ),
                        ),

                        hint: task_user_name == null
                            ? Text(
                          'User',
                          style: TextStyle(color: app_color),
                        )
                            : Text(
                          task_user_name,
                          style: TextStyle(color: app_color),
                        ),
                        isExpanded: true,
                        iconEnabledColor: app_color,
                        iconDisabledColor: app_color,
                        iconSize: 30.0,
                        style: TextStyle(color: app_color),
                        items: snapshot.data.map(
                              (val) {
                            return DropdownMenuItem<String>(
                              value: val.id,
                              child: Text(val.name),
                              onTap: (){
                                task_user_name=val.name;

                              },
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(() {
                            task_user = int.parse(val);
                          },
                          );
                        },
                      );

                    }
                    else{

                      return CircularProgressIndicator(
                        color: app_color,
                      );
                    }

                  }
              ),
            ),


            SizedBox(
              height: 10.0,
            ),
            //phone
            //date
            Container(
              height: 60,
              child: TextField(
                controller: task_date,
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
                      task_date.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),

            SizedBox(
              height: 10.0,
            ),

            Container(
              height: 60,
              child: DropdownButtonFormField(
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
                hint: task_status == null
                    ? Text(
                  'Status',
                  style: TextStyle(color: app_color),
                )
                    : Text(
                  task_status,
                  style: TextStyle(color: app_color),
                ),
                isExpanded: true,
                iconEnabledColor: app_color,
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
            ),

//            SizedBox(
//              height: 30.0,
//            )
          ],
        ),
      ),

      actions: [

        GestureDetector(
          onTap: () {
            if(task_user==null  && task_status==null && task_date.text.isEmpty)
            {
              _debouncer.run(() async {
                setState(() {
                  no_data_present=false;
                  task_manager_list = [];
                  searchtxt.clear();
                  onsearch = false;
                  filter_flag = false;
                });
                await task_manager(isReload: true);
                setState(() {});
              });

            }
            else{
              _debouncer.run(() async {
                setState(() {
                  filter_flag = true;
                  if (task_manager_list.isNotEmpty) {
                    task_manager_list = [];
                  }
                  tas_user= task_user; tas_date= task_date.text;tas_status= task_status;

                });

                task_filter_manager(
                    isReload: true,
                    tas_user: task_user, tas_date: task_date.text, tas_status: task_status);
                setState(() {});
              });
            }

            Navigator.of(context).pop();
          },
          child: Center(
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  color: app_color,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  'Apply'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return SafeArea(
      child: Scaffold(


        floatingActionButton: home_button(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,


        backgroundColor: background_view_color,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(95.0),
          child: Container(
            color: app_color,
            child: Column(
              children: [
                SizedBox(height: 10.0,),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      global_back_button(context),
                      Padding(
                        padding: const EdgeInsets.only( right: 10.0),
                        child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * 0.83,
                            child:  TextField(
                              onChanged: (value) {
                                _debouncer.run(() async {
                                  setState(() {
                                    no_data_present=false;
                                    if (task_manager_list.isNotEmpty) {
                                      task_manager_list = [];
                                    }
                                    onsearch = true;
                                  });
                                  await task_manager_onsearch(
                                    isReload: true,
                                    word: value.toLowerCase(),
                                  );
                                  setState(() {});
                                });
                              },
                              controller: searchtxt,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    left: 5.0, right: 30.0, top: 10.0, bottom: 10.0),
                                prefixIcon:  Icon(
                                  Icons.search_outlined,
                                  color: Colors.grey,
                                ),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                fillColor: w_color,
                                filled: true,
                                hintText: "By subject or desc",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "poppins",
                                ),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )

                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.0,),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(width: MediaQuery.of(context).size.width * 0.12),

//                      Container(
//                          width: MediaQuery.of(context).size.width * 0.3),

                      GestureDetector(
                        onTap: () async {
                          Get.to(add_task());
                        },
                        child: add_button(context),
                      ),

                      Container(
                          width: MediaQuery.of(context).size.width * 0.01),

                      GestureDetector(
                        onTap: () async {
                          _debouncer.run(() async {
                            setState(() {
                              no_data_present=false;
                              task_manager_list = [];
                              searchtxt.clear();
                              onsearch = false;
                              filter_flag = false;
                            });
                            await task_manager(isReload: true);
                            setState(() {});
                          });

                        },
                        child: refresh_button(context),
                      ),

                      Container(
                          width: MediaQuery.of(context).size.width * 0.01),

                      GestureDetector(
                        onTap: () {
                          searchtxt.clear();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Filter;
                            },
                          );
                        },
                        child: filter_button(context),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: body_layout(),
      ),
    );
  }

  body_layout() {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      enablePullDown: false,
      onRefresh: () async {
        if (filter_flag == true) {
          final result = await task_filter_manager(
              isReload: true,
              tas_user: task_user, tas_date: task_date.text, tas_status: task_status);
          print(result);
          if (result != null && result.isNotEmpty) {
            _refreshController.refreshCompleted();
          } else {
            _refreshController.refreshFailed();
          }
        } else if (onsearch == false && filter_flag == false) {
          final result = await task_manager(isReload: true);
          if (result != null && result.isNotEmpty) {
            _refreshController.refreshCompleted();
          } else {
            _refreshController.refreshFailed();
          }
        } else if (onsearch == true && filter_flag == false) {
          final result = await task_manager_onsearch(
              isReload: true, word: searchedWord);
          if (result != null && result.isNotEmpty) {
            _refreshController.refreshCompleted();
          } else {
            _refreshController.refreshFailed();
          }
        }
      },
      onLoading: () async {
        if (filter_flag == true) {
          final result = await task_filter_manager(
              tas_user: task_user, tas_date: task_date.text, tas_status: task_status);
          print(result);
          if (result != null && result.isNotEmpty) {
            _refreshController.loadComplete();
          } else {
            print("failed");
            _refreshController.loadFailed();
            Message();
          }
        } else if (onsearch == false && filter_flag == false) {
          var result = await task_manager();
          if (result != null && result.isNotEmpty) {
            _refreshController.loadComplete();
          } else {
            _refreshController.loadFailed();
            Message();
          }
        } else if (onsearch == true && filter_flag == false) {
          final result =
          await task_manager_onsearch(word: searchedWord);
          print(result);
          if (result != null && result.isNotEmpty) {
            _refreshController.loadComplete();
          } else {
            print("failed");
            _refreshController.loadFailed();
            Message();
          }
        }
      },
      child: (no_data_present==true && task_manager_list.isEmpty)?
      my_nodata():task_manager_list.isNotEmpty
          ?
          ListView.builder(
          itemCount: task_manager_list == null ? 0 : task_manager_list.length,
          itemBuilder: (context, index) {

            print(task_manager_list.length);
            var list = task_manager_list[index];
            var start_date=DateFormat.d().format(list.date)+" "+DateFormat.MMM().format(list.date);
            var last_date=DateFormat.d().format(list.deadline)+" "+DateFormat.MMM().format(list.deadline);
            print(list.files.length);
            print(list.files.runtimeType);

            String status=task_manager_list[index].status;


            return GestureDetector(
              onTap: () async {
                final updated_status=await Navigator.push(
                    context,
                    CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => detailview_task(
                          list.id!=null
//                                    ||list.id.isNotEmpty
                              ?list.id:"",
                          list.name1!=null
//                                      ||list.name1.isNotEmpty
                              ?list.name1:"",
                          task_manager_list[index].assignto.isEmpty
//                                      ||list.name2.isNotEmpty
                              ?empty_assign_to:task_manager_list[index].assignto.cast<String>(),
                          list.priority!=null
//                                      ||list.priority.isNotEmpty
                              ?list.priority:"",
                          list.subject!=null
//                                      ||list.subject.isNotEmpty
                              ? list.subject
                              .replaceAll('-', ' ')
                              .toString():"",
                          list.description!=null
//                                      ||list.description.isNotEmpty
                              ? Bidi.stripHtmlIfNeeded(list.description).replaceFirst("p","").replaceAll("/p", "")
                              .toString():"",
                          list.date!=null?list.date:"",
                          list.deadline!=null?list.deadline:"",
                          list.status!=null
//                                      ||list.status.isNotEmpty
                              ?list.status:"",
                          list.files,
                        )));

                setState(() => task_manager_list[index].status = updated_status);

              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                        color: card_color,
                        height:160,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 120,
                                width:70,

                                child: Column(
                                  children: [

                                    Text(start_date==null?"":start_date,
                                      style: TextStyle(
                                        fontFamily: "poppins",
                                        fontWeight: FontWeight.w800,
                                        color:  app_color,
                                        fontSize: 14.0,
                                      ),),

                                    SizedBox(height: 4,),

                                    bar(),

                                    SizedBox(height: 4,),


                                    Text(last_date==null?" ":last_date,
                                      style: TextStyle(
                                        fontFamily: "poppins",
                                        fontWeight: FontWeight.w800,
                                        color:  app_color,
                                        fontSize: 14.0,
                                      ),),

                                  ],
                                ),
                              ),
                            ),

                            Material(
                                elevation: 10.0,
                                borderRadius: BorderRadius.circular(15.0),
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width-90,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:8.0,bottom:6.0,left: 20.0,right: 8.0),
                                    child: Column(
                                      children: [

                                        subject(context, list.subject==null ?"  ":list.subject.replaceAll('-', ' ').toString(),),

                                        SizedBox(height: 2.0,),


                                        Assigned_to(context,list.assignto.isEmpty?empty_assign_to:list.assignto,),


                                        SizedBox(
                                          width: 2.0,
                                        ),

//                                        progress(task_manager_list[index].status),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15.0,
                                            child: Text(
                                              "Progress",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: RowStyle_grey(10.0),
                                            ),
                                          ),
                                          Spacer(),


                                          Padding(
                                            padding: const EdgeInsets.only(right: 10.0),
                                            child: Container(
                                              height: 15.0,
                                              child:
                                              Text(
                                                task_manager_list[index].status==null?"":task_manager_list[index].status,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: RowStyle_grey(10.0),
                                              ),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),

                                        SizedBox(
                                          height: 2.0,
                                        ),

//                                        progress_linear_indicator(task_manager_list[index].status),



                                        Container(
                                            height: 5.0,
//                               alignment: Alignment.topCenter,
                                            margin: EdgeInsets.only(right: 20),
                                            decoration: BoxDecoration(
                                            ),
                                            child: LinearProgressIndicator(
                                              value: parseStatusindicatorvalue(        task_manager_list[index].status==null?"":task_manager_list[index].status),
                                              valueColor: parseStatusAnimationIntoColor(        task_manager_list[index].status==null?"":task_manager_list[index].status),
                                              backgroundColor:  parseStatusIntoOpacityColorandpercentage(        task_manager_list[index].status==null?"":task_manager_list[index].status),
                                            )
                                        ),

                                        SizedBox(
                                          height: 2.0,
                                        ),


                                        priority(list.priority==null?"No priority":list.priority),

                                        SizedBox(
                                          height: 2.0,
                                        ),


                                        Description(context,  list.description==null?"  ":Bidi.stripHtmlIfNeeded(list.description).replaceFirst("p","").replaceAll("/p", "").toString(),),

                                        SizedBox(
                                          height: 2.0,
                                        ),

                                        commented_and_id(list.id, true),


                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        )
                    ),
              ),
            );
          })
          : myrefresher(),
    );
  }
}


//Row(
//                        children: [
//
//                          Expanded(
//                            flex: 2,
//
//                            child: Column(
//                              children: [
//                                Expanded(
//                                  flex: 1,
//                                  child: ID_button(
//                                      null,
//                                      null,
//                                      list.id,
//                                      8.0,
//                                      Colors.white,
//                                      blue_color),
//                                ),
//
//                                SizedBox(
//                                  height: 5.0,
//                                ),
//
//
////                                    Spacer(),
////                                    Expanded(
////                                      flex: 1,
////                                      child: Text(
////                                        "To",
////                                        maxLines: 1,
////                                        overflow: TextOverflow.ellipsis,
////                                        style: RowStyle_grey(12.0),
////                                      ),
////                                    ),
////                                    Spacer(),
//
////                                    SizedBox(
////                                      height: 5.0,
////                                    ),
//
//
//                                Expanded(
//                                    flex: 6,
//                                    child: Center(child: assigned_button(null, null,list.name1==null
////                                              ||list.name1==""
//                                        ?"No Name":list.name1 ,  list.name2 ==null||list.name2==""?"No Name":list.name2, 8.0,Colors.black ,blue_color ))),
//
//
//
//                                SizedBox(
//                                  height: 5.0,
//                                ),
//
//                                Expanded(
//                                  flex:1,
//                                  child: button(
//                                      null,
//                                      null,
//                                      list.priority==null?"No priority":list.priority,
//                                      10.0,
//                                      Colors.white,
//                                      parsePriorityIntoColor(
//                                          list.priority)),
//                                )
//                              ],
//
//                            ),
//                          ),
//
//                          SizedBox(
//                            width: 10.0,
//                          ),
//
//                          Expanded(
//                            flex: 8,
//                            child: Container(
//                              height:card_height,
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//
//                                  Expanded(
//                                    flex:2,
//                                    child: Align(
//                                      alignment: Alignment.topLeft,
//                                      child: Container(
//                                        height: null,
//                                        child: Text(
//                                          list.subject==null
////                                                    ||list.subject==""
//                                              ?"   ":list.subject
//                                              .replaceAll('-', ' ')
//                                              .toString(),
//                                          maxLines: 2,
//                                          overflow: TextOverflow.ellipsis,
//                                          textAlign: TextAlign.left,
//                                          style: RowStyle_grey(13.0),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//
//                                  SizedBox(
//                                    height: 3.0,
//                                  ),
//
//                                  Expanded(
//                                    flex:2,
//                                    child: Align(
//                                      alignment: Alignment.topLeft,
//                                      child: Container(
//                                        height: null,
//                                        child: Text(
//                                          list.description==null
////                                                    ||list.description==""
//                                              ?"  ":Bidi.stripHtmlIfNeeded(list.description).replaceFirst("p","").replaceAll("/p", "")
//                                              .toString(),
//                                          maxLines: 2,
//                                          overflow: TextOverflow.ellipsis,
//                                          textAlign: TextAlign.left,
//                                          style: RowStyle_grey(10.0),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//
//
//                                  SizedBox(
//                                    height: 3.0,
//                                  ),
//
//                                  Expanded(
//                                    flex: 2,
//                                    child: Row(
//
//                                      children: [
//                                        Expanded(
//                                          flex:1,
//                                          child: date_button(null, null, list.date==null
////                                                    ||list.date==""
//                                              ?"No Date":list.date, 8.0,
//                                              Colors.white,blue_color),
//                                        ),
//
//                                        Spacer(),
//
//                                        Expanded(
//                                          flex: 1,
//                                          child: date_button(
//                                              null,
//                                              null,
//                                              list.deadline==null
////                                                        ||list.deadline==""
//                                                  ?"No Deadline":list.deadline,
//                                              8.0,
//                                              Colors.white,
//                                              blue_color),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//
//                                  SizedBox(
//                                    height: 5.0,
//                                  ),
//
//
//                                  Expanded(
//                                    flex: 1,
//                                    child: button(
//                                        MediaQuery.of(context).size.width,
//                                        null,
//                                        list.status==null
//                                            ?"No Status"
//                                            :list.status,
//                                        11.0,
//                                        Colors.white,
//                                        parseStatusIntoColor(   list.status==null
//                                            ?""
//                                            :list.status,)),
//                                  ),
//
//                                ],
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),