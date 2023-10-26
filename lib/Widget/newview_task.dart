//import 'dart:async';
//import 'dart:convert';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
//import 'package:get/get.dart';
//import 'package:intl/intl.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
//import 'package:triple_n/Forms/add_daily_task.dart';
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Global/notification.dart';
//import 'package:triple_n/Model/daily_task.dart';
//import 'package:http/http.dart' as http;
//import 'package:triple_n/Global/paths.dart';
//import 'package:triple_n/Model/users.dart';
//import 'package:triple_n/Service/Users.dart';
//import 'package:triple_n/Widget/daily_task_widget.dart';
//import 'package:triple_n/Widget/global_button.dart';
//import 'package:triple_n/Widget/newdetailview_task.dart';
//
//class view_daily_task extends StatefulWidget {
//  @override
//  _view_daily_taskState createState() => _view_daily_taskState();
//}
//
//class Debouncer {
//  int milliseconds;
//  VoidCallback action;
//  Timer timer;
//
//  run(VoidCallback action) {
//    if (null != timer) {
//      timer.cancel();
//    }
//    timer = Timer(
//      Duration(milliseconds: Duration.millisecondsPerSecond),
//      action,
//    );
//  }
//}
//
//class _view_daily_taskState extends State<view_daily_task> {
//  @override
//  final TextEditingController searchtxt = TextEditingController();
//  Widget showbar = view_appbar_txt("Daily Task");
//
//  final RefreshController _refreshController =
//      RefreshController(initialRefresh: true);
//  List<DailyTask> daily_task_list = [];
//  int current_page = 0, current_search_page = 0;
//  String searchedWord = "";
//  String namer;
//
//  int dail_user;
//  String dail_date = "";
//  String dail_status = "";
//
//  bool onsearch = false;
//  bool filter_flag = false;
//  int current_filter_page = 0;
//
//  final TextEditingController daily_date = TextEditingController();
//  String daily_user_name;
//  int daily_user;
//  String daily_status;
//
//  bool no_data_present = false;
//
//  var status_list = ["Complete", "Continue"];
//
//  onstart() async {
//    await daily_task_manager(isReload: true);
//  }
//
//  void initState() {
//    super.initState();
//    filter_flag = false;
//    onstart();
//  }
//
//  //simple data
//  Future<List<DailyTask>> daily_task_manager({bool isReload = false}) async {
//    try {
//      if (isReload) {
//        current_page = 0;
//      }
//      String flag = "onstart";
//      String url =
//          http_root + "daily_task.php?page_no=$current_page&size=20&flag=$flag";
//      final response = await http.get(url);
//      List<DailyTask> result = [];
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        print(
//            parsed.map<DailyTask>((json) => DailyTask.fromJson(json)).toList());
//        result =
//            parsed.map<DailyTask>((json) => DailyTask.fromJson(json)).toList();
//
////        if (result != null && result.isNotEmpty) {
//        daily_task_list.addAll(result);
//        current_page++;
////        }
//        setState(() {
//          if (daily_task_list == [] || daily_task_list.isEmpty) {
//            no_data_present = true;
//          }
//        });
//        return result;
//      }
////      else {
////        return <DailyTask>[];
////      }
//    } catch (e) {
//      return <DailyTask>[];
//    }
//  }
//
////searched data
//  Future<List<DailyTask>> daily_task_manager_onsearch(
//      {bool isReload = false, String word}) async {
//    try {
//      if (isReload) {
//        current_search_page = 0;
//      }
//      String flag = "onsearch";
//      String url = http_root +
//          "daily_task.php?page_no=$current_search_page&size=5&word=$word&flag=$flag";
//
//      final response = await http.get(url);
//      List<DailyTask> result = [];
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        result =
//            parsed.map<DailyTask>((json) => DailyTask.fromJson(json)).toList();
//
////        if (result != null && result.isNotEmpty) {
//        this.searchedWord = word;
//        current_search_page++;
//        daily_task_list.addAll(result);
//        setState(() {
//          if (daily_task_list == [] || daily_task_list.isEmpty) {
//            no_data_present = true;
//          }
//        });
//      }
////        if (result != null && result.isNotEmpty) {
//      return result;
////        }
////      } else {
////        return <DailyTask>[];
////      }
//    } catch (e) {
//      return <DailyTask>[];
//    }
//  }
//
//  Future<List<DailyTask>> daily_task_filter_manager(
//      {bool isReload = false, int user, String date, String status}) async {
//    try {
//      if (isReload) {
//        current_filter_page = 0;
//      }
//
//      String flag = "onfilter";
//      String url = http_root +
//          "daily_task.php?page_no=$current_filter_page&size=20&user=$user&date=$date&status=$status&flag=$flag";
//      final response = await http.get(url);
//      List<DailyTask> result = [];
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        result =
//            parsed.map<DailyTask>((json) => DailyTask.fromJson(json)).toList();
//
//        print(result);
////        if (result != null && result.isNotEmpty) {
////          this.app_name = appointment_name.text;
////          this.app_date=appintment_date.text;
////          this.app_phno=appointment_phoneno.text;
//        current_filter_page++;
//        daily_task_list.addAll(result);
//        setState(() {
//          if (daily_task_list == [] || daily_task_list.isEmpty) {
//            no_data_present = true;
//          }
//        });
//        return result;
////        } else {
////          return <DailyTask>[];
////        }
//      }
//    } catch (e) {
//      print(e);
//      return <DailyTask>[];
//    }
//  }
//
//  final _debouncer = Debouncer();
//
//  Widget build(BuildContext context) {
//    AlertDialog Filter = AlertDialog(
//      title: Center(
//        child: Text(
//          "Filters",
//          style: TextStyle(
//              fontSize: 24.0,
//              fontFamily: "poppins",
//              fontWeight: FontWeight.w500,
//              color: app_color),
//        ),
//      ),
//      content: Container(
//        height: 170,
//        child: Column(
//          children: [
//            Container(
//              height: 50,
//              child: FutureBuilder<List<Users>>(
//                  future: UsersService.users(),
//                  builder: (context, snapshot) {
//                    if (snapshot.hasData) {
//                      return DropdownButtonFormField(
//                        decoration: InputDecoration(
//                          enabledBorder: OutlineInputBorder(
//                            borderSide:
//                                BorderSide(color: app_color, width: 0.0),
//                          ),
////                      errorText: "",
//
//                          border: new OutlineInputBorder(
//                            borderRadius: new BorderRadius.circular(10.0),
//                            borderSide: new BorderSide(color: app_color),
//                          ),
//                        ),
//                        hint: daily_user_name == null
//                            ? Text(
//                                'Assigned By',
//                                style: TextStyle(color: app_color),
//                              )
//                            : Text(
//                                daily_user_name,
//                                style: TextStyle(color: app_color),
//                              ),
//                        isExpanded: true,
//                        iconEnabledColor: app_color,
//                        iconDisabledColor: app_color,
//                        iconSize: 30.0,
//                        style: TextStyle(color: app_color),
//                        items: snapshot.data.map(
//                          (val) {
//                            return DropdownMenuItem<String>(
//                              value: val.id,
//                              child: Text(val.name),
//                              onTap: () {
//                                setState(
//                                  () {
//                                    daily_user_name = val.name;
//                                  },
//                                );
//                              },
//                            );
//                          },
//                        ).toList(),
//                        onChanged: (val) {
//                          setState(
//                            () {
//                              daily_user = int.parse(val);
//                            },
//                          );
//                        },
//                      );
//                    } else {
//                      return CircularProgressIndicator(
//                        color: app_color,
//                      );
//                    }
//                  }),
//            ),
//
//            SizedBox(
//              height: 10.0,
//            ),
//            //date
//            Container(
//              height: 45,
//              child: TextField(
//                controller: daily_date,
//                decoration: InputDecoration(
//                    enabledBorder: OutlineInputBorder(
//                      borderSide: BorderSide(color: app_color, width: 0.0),
//                    ),
//                    labelStyle: TextStyle(fontSize: 18.0, color: app_color),
//                    border: new OutlineInputBorder(
//                      borderRadius: new BorderRadius.circular(10.0),
//                      borderSide: new BorderSide(color: Colors.blue),
//                    ),
//                    prefixIcon: Icon(
//                      Icons.calendar_today,
//                      color: app_color,
//                    ),
//                    //icon of text field
//                    labelText: "Enter Date" //label text of field
//                    ),
//                readOnly: true,
//                //set it true, so that user will not able to edit text
//                onTap: () async {
//                  DateTime pickedDate = await showDatePicker(
//                      context: context,
//                      initialDate: DateTime.now(),
//                      firstDate: DateTime(2000),
//                      //DateTime.now() - not to allow to choose before today.
//                      lastDate: DateTime(2101));
//                  if (pickedDate != null) {
//                    print(
//                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                    String formattedDate =
//                        DateFormat('yyyy-MM-dd').format(pickedDate);
//                    print(
//                        formattedDate); //formatted date output using intl package =>  2021-03-16
//                    //you can implement different kind of Date Format here according to your requirement
//                    setState(() {
//                      daily_date.text =
//                          formattedDate; //set output date to TextField value.
//                    });
//                  } else {
//                    print("Date is not selected");
//                  }
//                },
//              ),
//            ),
//
//            SizedBox(
//              height: 10.0,
//            ),
//
//            Container(
//              height: 50,
//              child: DropdownButtonFormField(
//                decoration: InputDecoration(
//                  enabledBorder: OutlineInputBorder(
//                    borderSide: BorderSide(color: app_color, width: 0.0),
//                  ),
////                      errorText: "",
//                  border: new OutlineInputBorder(
//                    borderRadius: new BorderRadius.circular(10.0),
//                    borderSide: new BorderSide(color: app_color),
//                  ),
//                ),
//                hint: daily_status == null
//                    ? Text(
//                        'status',
//                        style: TextStyle(color: app_color),
//                      )
//                    : Text(
//                        daily_status,
//                        style: TextStyle(color: app_color),
//                      ),
//                isExpanded: true,
//                iconEnabledColor: app_color,
//                iconDisabledColor: app_color,
//                iconSize: 30.0,
//                style: TextStyle(color: app_color),
//                items: status_list.map(
//                  (val) {
//                    return DropdownMenuItem<String>(
//                      value: val,
//                      child: Text(val),
//                    );
//                  },
//                ).toList(),
//                onChanged: (val) {
//                  setState(
//                    () {
//                      daily_status = val;
//                    },
//                  );
//                },
//              ),
//            ),
//          ],
//        ),
//      ),
//      actions: [
//        GestureDetector(
//          onTap: () {
//            if (daily_user == null &&
//                daily_date.text.isEmpty &&
//                daily_status == null) {
//              _debouncer.run(() async {
//                setState(() {
//                  no_data_present = false;
//                  daily_task_list = [];
//                  searchtxt.clear();
//                  onsearch = false;
//                  filter_flag = false;
//                });
//                await daily_task_manager(isReload: true);
//                setState(() {});
//              });
//            } else {
//              _debouncer.run(() async {
//                setState(() {
//                  filter_flag = true;
//                  if (daily_task_list.isNotEmpty) {
//                    daily_task_list = [];
//                  }
//
//                  dail_user = daily_user;
//                  dail_date = daily_date.text;
//                  dail_status = daily_status;
//                });
//
//                daily_task_filter_manager(
//                    isReload: true,
//                    user: daily_user,
//                    date: daily_date.text,
//                    status: daily_status);
//                setState(() {});
//              });
//            }
//            Navigator.of(context).pop();
//          },
//          child: Center(
//            child: Container(
//              height: 45,
//              width: MediaQuery.of(context).size.width * 0.6,
//              decoration: BoxDecoration(
//                  color: app_color,
//                  borderRadius: BorderRadius.all(Radius.circular(10))),
//              child: Center(
//                child: Text(
//                  'Apply'.toUpperCase(),
//                  style: TextStyle(
//                      fontSize: 18.0,
//                      color: Colors.white,
//                      fontWeight: FontWeight.bold),
//                ),
//              ),
//            ),
//          ),
//        ),
//      ],
//    );
//
//    return SafeArea(
//      child: Scaffold(
//          backgroundColor: background_view_color,
//          appBar: PreferredSize(
//            preferredSize: const Size.fromHeight(95.0),
//            child: Container(
//              color: app_color,
//              child: Column(
//                children: [
//                  SizedBox(
//                    height: 10.0,
//                  ),
//                  Container(
//                    height: 40,
//                    width: MediaQuery.of(context).size.width,
//                    child: Row(
//                      children: [
//                        global_back_button(context),
//                        Padding(
//                          padding: const EdgeInsets.only(right: 10.0),
//                          child: Container(
//                              height: 35,
//                              width: MediaQuery.of(context).size.width * 0.83,
//                              child: TextField(
//                                onChanged: (value) {
//                                  _debouncer.run(() async {
//                                    setState(() {
//                                      no_data_present = false;
//                                      if (daily_task_list.isNotEmpty) {
//                                        daily_task_list = [];
//                                      }
//                                      onsearch = true;
//                                    });
//                                    await daily_task_manager_onsearch(
//                                      isReload: true,
//                                      word: value.toLowerCase(),
//                                    );
//                                    setState(() {});
//                                  });
//                                },
//                                controller: searchtxt,
//                                decoration: InputDecoration(
//                                  contentPadding: EdgeInsets.only(
//                                      left: 5.0,
//                                      right: 30.0,
//                                      top: 10.0,
//                                      bottom: 10.0),
//                                  prefixIcon: Icon(
//                                    Icons.search_outlined,
//                                    color: Colors.grey,
//                                  ),
//                                  isDense: true,
//                                  enabledBorder: OutlineInputBorder(
//                                    borderSide: const BorderSide(
//                                        color: Colors.white, width: 2.0),
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
//                                  focusedBorder: OutlineInputBorder(
//                                    borderSide: const BorderSide(
//                                        color: Colors.white, width: 2.0),
//                                    borderRadius: BorderRadius.circular(10.0),
//                                  ),
//                                  fillColor: w_color,
//                                  filled: true,
//                                  hintText: "By Title or Note",
//                                  hintStyle: TextStyle(
//                                    color: Colors.grey,
//                                    fontSize: 14,
//                                    fontWeight: FontWeight.w500,
//                                    fontFamily: "poppins",
//                                  ),
//                                  border: InputBorder.none,
//                                ),
//                                style: TextStyle(
//                                  color: Colors.black,
//                                ),
//                              )),
//                        ),
//                      ],
//                    ),
//                  ),
//                  SizedBox(
//                    height: 5.0,
//                  ),
//                  Container(
//                    height: 40,
//                    width: MediaQuery.of(context).size.width,
//                    child: Row(
//                      children: [
//                        Container(
//                            width: MediaQuery.of(context).size.width * 0.12),
//
//                        GestureDetector(
//                          onTap: () async {
//                            Get.to(add_daily_task());
//                          },
//                          child: add_button(context),
//                        ),
//
//                        Container(
//                            width: MediaQuery.of(context).size.width * 0.01),
//
//                        GestureDetector(
//                          onTap: () async {
//                            _debouncer.run(() async {
//                              setState(() {
//                                no_data_present = false;
//                                daily_task_list = [];
//                                searchtxt.clear();
//                                onsearch = false;
//                                filter_flag = false;
//                              });
//                              await daily_task_manager(isReload: true);
//                              setState(() {});
//                            });
//                          },
//                          child: refresh_button(context),
//                        ),
//                        Container(
//                            width: MediaQuery.of(context).size.width * 0.01),
////                        Container(
////                            width: MediaQuery.of(context).size.width * 0.30),
//                        GestureDetector(
//                          onTap: () {
//                            searchtxt.clear();
//                            showDialog(
//                              context: context,
//                              builder: (BuildContext context) {
//                                return Filter;
//                              },
//                            );
//                          },
//                          child: filter_button(context),
//                        ),
//                      ],
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
//          body: body_layout()),
//    );
//  }
//
//  body_layout() {
//    return SmartRefresher(
//      controller: _refreshController,
//      enablePullUp: true,
//      enablePullDown: false,
//      onRefresh: () async {
//        if (filter_flag == true) {
//          final result = await daily_task_filter_manager(
//            isReload: true,
//            user: daily_user,
//            date: daily_date.text,
//            status: daily_status,
//          );
//          print(result);
//          if (result != null && result.isNotEmpty) {
//            _refreshController.refreshCompleted();
//          } else {
//            _refreshController.refreshFailed();
//          }
//        } else if (onsearch == false && filter_flag == false) {
//          final result = await daily_task_manager(isReload: true);
//          if (result != null && result.isNotEmpty) {
//            _refreshController.refreshCompleted();
//          } else {
//            _refreshController.refreshFailed();
//          }
//        } else if (onsearch == true && filter_flag == false) {
//          final result = await daily_task_manager_onsearch(
//              isReload: true, word: searchedWord);
//          if (result != null && result.isNotEmpty) {
//            _refreshController.refreshCompleted();
//          } else {
//            _refreshController.refreshFailed();
//          }
//        }
//      },
//      onLoading: () async {
//        if (filter_flag == true) {
//          final result = await daily_task_filter_manager(
//            user: daily_user,
//            date: daily_date.text,
//            status: daily_status,
//          );
//          print(result);
//          if (result != null && result.isNotEmpty) {
//            _refreshController.loadComplete();
//          } else {
//            print("failed");
//            _refreshController.loadFailed();
//            Message();
//          }
//        } else if (onsearch == false && filter_flag == false) {
//          var result = await daily_task_manager();
//          if (result != null && result.isNotEmpty) {
//            _refreshController.loadComplete();
//          } else {
//            _refreshController.loadFailed();
//            Message();
//          }
//        } else if (onsearch == true && filter_flag == false) {
//          final result = await daily_task_manager_onsearch(word: searchedWord);
//          print(result);
//          if (result != null && result.isNotEmpty) {
//            _refreshController.loadComplete();
//          } else {
//            print("failed");
//            _refreshController.loadFailed();
//            Message();
//          }
//        }
//      },
//      child: (no_data_present == true && daily_task_list.isEmpty)
//          ? my_nodata()
//          : daily_task_list.isNotEmpty
//              ? ListView.builder(
//                  itemCount:
//                      daily_task_list == null ? 0 : daily_task_list.length,
//                  itemBuilder: (context, index) {
////              print(daily_task_list.length);
//                    var list = daily_task_list[index];
//                    String date = DateFormat("dd-MM-yyyy")
//                        .format(list.date == null
////                                ||list.date.toString().isEmpty
//                            ? ""
//                            : list.date)
//                        .toString();
////            String time = DateFormat.Hm()
////                .format(DateTime.parse(list.start));
////                                ||list.date.toString().isEmpty
////                ? ""
////                : DateTime.parse(list.start))
////                .toString();
////            String detail_time = DateFormat.Hm()
////                .format(list.start == null
//////                                ||list.date.toString().isEmpty
////                ? ""
////                : list.start)
////                .toString();
//                    var start_date = DateFormat.d().format(list.date) +
//                        " " +
//                        DateFormat.MMM().format(list.date);
////              String date= DateFormat("yyyy-MM-dd HH:mm:ss").format(list.date);
////              String time= DateFormat("HH:mm:ss").format(list.start);
//                    return GestureDetector(
//                      onTap: () {
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => detailview_daily_task(
//                                      list.id == null
////                                  ||list.id.isEmpty
//                                          ? ""
//                                          : list.id,
//                                      list.name == null
////                                ||list.name.isEmpty
//                                          ? ""
//                                          : list.name,
//                                      list.start != null ? list.start : " ",
////                            list.date==null
////                                ||list.date.toString().isEmpty
////                                ?"":list.date,
//                                      list.end != null ? list.end : "",
//                                      list.date != null ? list.date : " ",
//                                      list.title == null
////                                ||list.title.isEmpty
//                                          ? ""
//                                          : list.title,
//                                      list.note == null
////                                ||list.note.isEmpty
//                                          ? ""
//                                          : list.note,
//                                      list.status == null
////                                ||list.status.isEmpty
//                                          ? ""
//                                          : list.status,
//                                    )));
//                      },
//                      child: Padding(
//                        padding: const EdgeInsets.all(10.0),
//                        child: Container(
//                            color: card_color,
//                            height: 160,
//                            child: Row(
//                              children: [
//                                Align(
//                                  alignment: Alignment.centerLeft,
//                                  child: Container(
//                                    height: 120,
//                                    width: 70,
//                                    child: Column(
//                                      children: [
//                                        Text(
//                                          start_date == null ? "" : start_date,
//                                          style: TextStyle(
//                                            fontFamily: "poppins",
//                                            fontWeight: FontWeight.w800,
//                                            color: app_color,
//                                            fontSize: 14.0,
//                                          ),
//                                        ),
//                                        SizedBox(
//                                          height: 4,
//                                        ),
//                                        bar(),
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                                Material(
//                                    elevation: 10.0,
//                                    borderRadius: BorderRadius.circular(15.0),
//                                    child: Container(
//                                      height:
//                                          MediaQuery.of(context).size.height,
//                                      width: MediaQuery.of(context).size.width -
//                                          90,
//                                      child: Padding(
//                                        padding: const EdgeInsets.only(
//                                            top: 8.0,
//                                            bottom: 5.0,
//                                            left: 20.0,
//                                            right: 8.0),
//                                        child: Column(
//                                          children: [
//                                            title(
//                                              context,
//                                              list.title == null
//                                                  ? "  "
//                                                  : list.title
//                                                      .replaceAll('-', ' ')
//                                                      .toString(),
//                                            ),
//
//                                            SizedBox(
//                                              height: 2.0,
//                                            ),
//
//                                            Assigned_by(
//                                              context,
//                                              list.name == null
//                                                  ? list.name
//                                                  : list.name,
//                                            ),
//
//                                            SizedBox(
//                                              height: 2.0,
//                                            ),
//
//
//                                            daily_task_time(
//                                                context,
//                                                list.start != null
//                                                    ? list.start
//                                                    : "",
//                                                list.end != null
//                                                ? list.end
//                                                : ""),
//
//
//                                            SizedBox(
//                                              height: 2.0,
//                                            ),
//                                            //time is remaining
//
//                                            progress(list.status == null
//                                                ? ""
//                                                : list.status),
//
//                                            SizedBox(
//                                              height: 2.0,
//                                            ),
//
//                                            progress_linear_indicator(
//                                                list.status == null
//                                                    ? ""
//                                                    : list.status),
//
//                                            SizedBox(
//                                              height: 2.0,
//                                            ),
//
//                                            note(
//                                              context,
//                                              list.note == null
//                                                  ? "  "
//                                                  : Bidi.stripHtmlIfNeeded(
//                                                          list.note)
//                                                      .replaceFirst("p", "")
//                                                      .replaceAll("/p", "")
//                                                      .toString(),
//                                            ),
//
//                                            SizedBox(
//                                              height: 2.0,
//                                            ),
//
//                                            commented_and_id(list.id, true),
//                                          ],
//                                        ),
//                                      ),
//                                    )),
//                              ],
//                            )),
//                      ),
//                    );
//                  })
//              : myrefresher(),
//    );
//  }
//}
//
////Padding(
////padding: const EdgeInsets.all(10.0),
////child: Material(
////elevation: 10.0,
////borderRadius: BorderRadius.circular(10.0),
////child: Padding(
////padding: const EdgeInsets.all(10.0),
////child: Container(
////color: card_color,
////height: card_height,
////child: Row(
////children: [
////Expanded(
////flex: 3,
////child: Column(
////children: [
////Expanded(
////flex: 1,
////child: ID_button(
////null,
////card_height,
////list.id == null ? "" : list.id,
////8.0,
////Colors.white,
////blue_color),
////),
////SizedBox(
////height: 5.0,
////),
////Expanded(
////flex: 1,
////child: button(
////null,
////null,
////list.name == null
//////                                       ||list.name==""
////? "No Name"
////: list.name,
////8.0,
////Colors.white,
////blue_color,
////),
////),
////SizedBox(
////height: 5.0,
////),
////Expanded(
////flex: 1,
////child: app_date_button(
////null,
////null,
////date == null
//////                                       ||date==""
////? "No date"
////: date,
////8.0,
////Colors.white,
////blue_color,
////),
////),
////SizedBox(
////height: 5.0,
////),
////Expanded(
////flex: 1,
////child: time_button(
////null,
////null,
////list.start == null
//////                                       ||list.start==""
////? "No time"
////: list.start,
////8.0,
////Colors.white,
////blue_color,
////),
////),
////],
////),
////),
////SizedBox(
////width: 10.0,
////),
////Expanded(
////flex: 7,
////child: Container(
////height: card_height,
////child: Column(
////children: [
////Expanded(
////flex: 2,
////child: Align(
////alignment: Alignment.topLeft,
////child: Container(
//////                                              width: MediaQuery.of(context).size.width * 0.6,
////height: null,
////child: Text(
////list.note == null
////? ""
////: list.note
////    .replaceAll('-', ' ')
////.toString(),
////maxLines: 2,
////style: RowStyle_grey(13.0),
////),
////),
////),
////),
////
////SizedBox(
////height: 5.0,
////),
////
////Expanded(
////flex: 2,
////child: Align(
////alignment: Alignment.topLeft,
////child: Container(
//////                                              width: MediaQuery.of(context).size.width * 0.6,
////height: null,
////child: Text(
////list.title == null
////? " "
////: list.title
////    .replaceAll('-', ' ')
////.toString(),
////maxLines: 2,
////style: RowStyle_grey(10.0),
////),
////),
////),
////),
////
////SizedBox(
////height: 5.0,
////),
////
//////                                  Expanded(
//////                                    flex: 2,
//////                                    child: Row(
//////                                      mainAxisAlignment:
//////                                      MainAxisAlignment.spaceEvenly,
//////                                      children: [
//////                                        Expanded(
//////                                          flex: 4,
//////                                          child: button(null, 20,date==""||date==null?"No Date":date, 12.0,
//////                                              Colors.white, blue_color),
//////                                        ),
//////                                        Spacer(),
//////                                        Expanded(
//////                                          flex: 1,
//////                                          child: Text(
//////                                            "AT",
//////                                            maxLines: 1,
//////                                            overflow: TextOverflow.ellipsis,
//////                                            style: RowStyle_grey(12.0),
//////                                          ),
//////                                        ),
//////                                        Spacer(),
//////                                        Expanded(
//////                                          flex: 4,
//////                                          child: button(null, 20,list.start == null||list.start==""?"No Time":list.start, 12.0,
//////                                            Colors.white,blue_color,
//////                                          ),),
//////                                      ],
//////                                    ),
//////                                  ),
////
////Expanded(
////flex: 1,
////child: button(
////MediaQuery.of(context).size.width,
////null,
////list.status == null
////? "No Status"
////: list.status,
////10.0,
////Colors.white,
////parseDailyTaskStatusIntoColor(
////list == null ? "" : list.status,
////)),
////)
////],
////),
////),
////),
////],
////),
////),
////),
////),
////),
