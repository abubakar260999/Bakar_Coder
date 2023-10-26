//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/appointments.dart';
//
//
//
//class AppointmentService{
//  static Future<List<Appointment>> appointment() async {
//    try {
//
//      String url = http_root+appointment_path;
//      var map = Map<String, dynamic>();
//      map['action'] = "Appointment";
//      final response = await http.post(url, body: map);
//      var result=[];
//
//
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        return parsed.map<Appointment>((json) => Appointment.fromJson(json)).toList();
//
//
//      }
//      else {
//        return List<Appointment>();
//
//      }
//
//    }
//    catch(e){
//      return List<Appointment>();
//    }
//  }
//
//
//
//}

//
//import 'dart:async';
//import 'dart:convert';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
//import 'package:get/get.dart';
//import 'package:intl/intl.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Global/notification.dart';
//import 'package:triple_n/Model/appointments.dart';
//import 'package:http/http.dart' as http;
//import 'package:triple_n/Global/paths.dart';
//import 'package:triple_n/Views/detailview_appointments.dart';
//
//
//
//class view_appointments extends StatefulWidget {
//  @override
//  _view_appointmentsState createState() => _view_appointmentsState();
//}
//
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
//class _view_appointmentsState extends State<view_appointments> {
//  @override
//  final TextEditingController searchtxt = TextEditingController();
//  Widget showbar = view_appbar_txt("Appointments");
//
//  final RefreshController _refreshController = RefreshController(
//      initialRefresh: true);
//  List<Appointment> appointment_list = [];
//  int current_page = 0, current_search_page = 0;
//  String searchedWord = "";
//  bool close = true;
//
//  //simple data
//  Future<List<Appointment>> appointment_manager({bool isReload = false}) async {
//    try {
//      if (isReload) {
//        current_page = 0;
//      }
//      String url = http_root + "appointment.php?page_no=$current_page&size=20";
//      final response = await http.get(url);
//      List<Appointment> result = [];
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        print(parsed.map<Appointment>((json) => Appointment.fromJson(json)).toList());
//        result = parsed.map<Appointment>((json) => Appointment.fromJson(json)).toList();
//
//
//        if (result != null && result.isNotEmpty) {
//          appointment_list.addAll(result);
//          current_page++;
//        }
//        setState(() {});
//        return result;
//      } else {
//        return <Appointment>[];
//      }
//    } catch (e) {
//      return <Appointment>[];
//    }
//  }
//
////searched data
//  Future<List<Appointment>> appointment_manager_onsearch(
//      {bool isReload = false, String word}) async {
//    try {
//      if (isReload) {
//        current_search_page = 0;
//      }
//      String url = http_root + "appointment.php?page_no=$current_search_page&size=5&word=$word";
//      final response = await http.get(url);
//      List<Appointment> result = [];
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        result = parsed.map<Appointment>((json) => Appointment.fromJson(json)).toList();
//
//        if (result != null && result.isNotEmpty) {
//          this.searchedWord = word;
//          current_search_page++;
//          appointment_list.addAll(result);
//          setState(() {});
//        }
//        if (result != null && result.isNotEmpty) {
//          return result;
//        }
//      } else {
//        return <Appointment>[];
//      }
//    } catch (e) {
//      return <Appointment>[];
//    }
//  }
//
//  final _debouncer = Debouncer();
//
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//
//          backgroundColor: background_view_color,
//          appBar: AppBar(
//            toolbarHeight: 90.0,
//            backgroundColor: app_color,
//            elevation: 10.0,
//            title: showbar,
//            leading: Back_button(Colors.white),
//            actions: [
//              close == true
//                  ? IconButton(
//                onPressed: () {
//                  setState(() {
//                    showbar = TextField(
//                      onChanged: (value) {
//                        _debouncer.run(() async {
//                          setState(() {
//                            if (appointment_list.isNotEmpty) {
//                              appointment_list = [];
//                            }
//                            close = false;
//                          });
//                          await appointment_manager_onsearch(
//                            isReload: true,
//                            word: value.toLowerCase(),
//                          );
//                          setState(() {});
//                        });
//                      },
//                      controller: searchtxt,
//                      decoration: InputDecoration(
//                        contentPadding: EdgeInsets.only(
//                            left: 10.0, right: 30.0, top: 10.0, bottom: 10.0),
//                        isDense: true,
//                        enabledBorder: OutlineInputBorder(
//                          borderSide: const BorderSide(
//                              color: Colors.white, width: 5.0),
//                          borderRadius: BorderRadius.circular(8.0),
//                        ),
//                        focusedBorder: OutlineInputBorder(
//                          borderSide: const BorderSide(
//                              color: Colors.white, width: 5.0),
//                          borderRadius: BorderRadius.circular(10.0),
//                        ),
//                        fillColor: w_color,
//                        filled: true,
//                        hintText: 'Search By Name',
//                        hintStyle: TextStyle(
//                          color: Colors.grey,
//                          fontSize: 16,
//                          fontWeight: FontWeight.w500,
//                          fontFamily: "poppins",
//                        ),
//                      ),
//                      style: TextStyle(
//                        color: Colors.black,
//                      ),
//                    );
//                    close = false;
//                  });
//                },
//                icon: Icon(
//                  Icons.search,
//                  color: w_color,
//                ),
//              )
//                  : IconButton(
//                icon: Icon(
//                  Icons.clear,
//                  color: Colors.white,
//                  size: 33.0,
//                ),
//                onPressed: () async {
//                  close = true;
//                  searchtxt.clear();
//                  appointment_list = [];
//                  await appointment_manager(isReload: true);
//                  setState(() {});
//                  showbar = view_appbar_txt("Appointments");
//                },
//              )
//            ],
//          ),
//          body: body_layout()
//      ),
//    );
//  }
//
//
//  body_layout() {
//    return SmartRefresher(
//        controller: _refreshController,
//        enablePullUp: true,
//        enablePullDown: true,
//        onRefresh: () async {
//          if (close == true) {
//            final result = await appointment_manager(isReload: true);
//            if (result != null && result.isNotEmpty) {
//              _refreshController.refreshCompleted();
//            } else {
//              _refreshController.refreshFailed();
//            }
//          } else {
//            final result =
//            await appointment_manager_onsearch(isReload: true, word: searchedWord);
//            if (result != null && result.isNotEmpty) {
//              _refreshController.refreshCompleted();
//            } else {
//              _refreshController.refreshFailed();
//            }
//          }
//        },
//        onLoading: () async {
//          if (close == true) {
//            var result = await appointment_manager();
//            if (result != null && result.isNotEmpty) {
//              _refreshController.loadComplete();
//            } else {
//              _refreshController.loadFailed();
//              Message();
//            }
//          } else {
//            final result = await appointment_manager_onsearch(word: searchedWord);
//            print(result);
//            if (result != null && result.isNotEmpty) {
//              _refreshController.loadComplete();
//            } else {
//              print("failed");
//
//              _refreshController.loadFailed();
//              Message();
//            }
//          }
//        },
//        child: appointment_list != null
//            ? ListView.builder(
//            itemCount: appointment_list == null ? 0 : appointment_list.length,
//            itemBuilder: (context, index) {
//              print(appointment_list.length);
//
//
//              var list = appointment_list[index];
//
////              String time= DateFormat("HH:mm:ss").format(list.start);
//              return GestureDetector(
//
//                onTap: (){
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => detailview_appointments(
//                              list.id,
//                              list.company,
//                              list.description,
//                              list.name,
//                              list.date,
//                              list.time,
//                              list.status.toString(),
//                              list.phone
//                          )));
//                },
//                child: Padding(
//                  padding: const EdgeInsets.all(10.0),
//                  child: Material(
//                    elevation: 10.0,
//                    borderRadius: BorderRadius.circular(10.0),
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Container(
//                        color: card_color,
//                        height: card_height,
//                        child: Row(
//                          children: [
//                            Expanded(
//                              flex: 2,
//                              child: Column(
//
//                                children: [
//                                  Expanded(
//                                    flex: 1,
//                                    child: ID_button(
//                                        null,
//                                        null,
//                                        list.id,
//                                        8.0,
//                                        Colors.white,
//                                        blue_color),
//                                  ),
//
//
//
//                                  SizedBox(
//                                    height: 10.0,
//                                  ),
//
////
////                                Expanded(
////                                  flex:2,
////                                  child: app_date_button(
////                                      null,
////                                      null,
////                                      list.date==null && list.date.isEmpty?" ": DateFormat('dd-MM-yyyy').format(DateTime.parse(list.date)),
////                                      8.0,
////                                      Colors.white,
////                                     blue_color),
////                                ),
////
////                                SizedBox(
////                                  height: 5.0,
////                                ),
////
////                                Expanded(
////                                  flex:2,
////                                  child: time_button(
////                                      null,
////                                      null,
////                                      list.time==null && list.time.isEmpty?" ":list.time,
////                                      8.0,
////                                      Colors.white,
////                                      blue_color),
////                                ),
////                                SizedBox(
////                                  height: 5.0,
////                                ),
//
//                                  Expanded(
//                                    flex:3,
//                                    child: name_button(null, null,list.name==null||list.name==""?"No Name":list.name, 10.0,
//                                        Colors.white, blue_color),
//                                  ),
//
////                                Expanded(flex:3,child: Text("")),
////                                Expanded(
////                                  flex:2,
////                                  child: phone_button(
////                                      null,
////                                      null,
////                                      list.phone==null?"No phone":list.phone,
////                                      8.0,
////                                      Colors.white,
////                                      blue_color),
//
////                                )
//                                ],
//
//                              ),
//                            ),
//
//                            SizedBox(
//                              width: 20.0,
//                            ),
//
//
//                            Expanded(
//                              flex: 8,
//                              child: Container(
//                                height: card_height,
//                                child: Column(
//                                  children: [
//
//                                    Expanded(
//                                      flex: 2,
//                                      child: Align(
//                                        alignment: Alignment.topLeft,
//                                        child: Container(
////                                              width: MediaQuery.of(context).size.width * 0.6,
//                                          height: null,
//                                          child: Text(
//                                            list.company==""?"No Comapany Name":list.company
//                                                .replaceAll('-', ' ')
//                                                .toString(),
//                                            maxLines: 2,
//                                            overflow: TextOverflow.ellipsis,
//                                            textAlign: TextAlign.left,
//                                            style: RowStyle_grey(12.0),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//
//                                    SizedBox(
//                                      height: 5.0,
//                                    ),
//
//                                    Expanded(
//                                      flex: 2,
//                                      child: Align(
//                                        alignment: Alignment.topLeft,
//                                        child: Container(
////                                              width: MediaQuery.of(context).size.width * 0.6,
//                                          height: null,
//                                          child: Text(
//                                            list.description==""?"No Discription":list.description
//                                                .replaceAll('-', ' ')
//                                                .toString(),
//                                            maxLines: 2,
//                                            overflow: TextOverflow.ellipsis,
//                                            textAlign: TextAlign.left,
//                                            style: RowStyle_grey(10.0),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//
//                                    SizedBox(
//                                      height: 5.0,
//                                    ),
//
//                                    Expanded(
//                                        flex: 1,
//                                        child: Row(children: [
//                                          Expanded(
//                                            flex:5,
//                                            child: time_button(
//                                                null,
//                                                null,
//                                                list.time==null && list.time.isEmpty?" ":list.time,
//                                                8.0,
//                                                Colors.white,
//                                                blue_color),
//                                          ),
//
//                                          Spacer(),
//
//                                          Expanded(
//                                            flex: 5,
//                                            child: app_date_button(
//                                                null,
//                                                null,
//                                                list.date==null && list.date.isEmpty?" ": DateFormat('dd-MM-yyyy').format(DateTime.parse(list.date)),
//                                                8.0,
//                                                Colors.white,
//                                                blue_color),
//                                          ),
//                                        ],)
//                                    ),
//
////                                  SizedBox(
////                                    height: 5.0,
////                                  ),
//
////                                  Expanded(
////                                    flex: 1,
////                                    child: button( MediaQuery.of(context).size.width, null,list.name==null||list.name==""?"No Name":list.name, 10.0,
////                                        Colors.white, blue_color),
////                                  ),
////                                  Expanded(
////                                    flex: 2,
////                                    child: Row(
////                                      mainAxisAlignment:
////                                      MainAxisAlignment.spaceEvenly,
////                                      children: [
////                                        Expanded(
////                                          flex: 4,
////                                          child: button(null, 20,list.name==null||list.name==""?"No Name":list.name, 12.0,
////                                              Colors.white, blue_color),
////                                        ),
////                                        Spacer(),
////                                        Expanded(
////                                          flex: 1,
////                                          child: Text(
////                                            "  ",
////                                            maxLines: 1,
////                                            overflow: TextOverflow.ellipsis,
////                                            style: RowStyle_grey(12.0),
////                                          ),
////                                        ),
////                                        Spacer(),
////                                        Expanded(
////                                          flex: 4,
////                                          child: button(null, 20,list.phone==null||list.phone==""?"No Name":list.phone, 12.0,
////                                            Colors.white,blue_color,
////                                          ),),
////                                      ],
////                                    ),
////                                  ),
//
////                                  Expanded(
////                                    flex: 2,
////                                    child: Row(
////                                      mainAxisAlignment:
////                                      MainAxisAlignment.spaceEvenly,
////                                      children: [
////                                        Expanded(
////                                          flex: 4,
////                                          child: button(null, 20,list.date==null||list.date==""?"No Date":list.date, 12.0,
////                                              Colors.white, blue_color),
////                                        ),
////                                        Spacer(),
////                                        Expanded(
////                                          flex: 1,
////                                          child: Text(
////                                            "AT",
////                                            maxLines: 1,
////                                            overflow: TextOverflow.ellipsis,
////                                            style: RowStyle_grey(12.0),
////                                          ),
////                                        ),
////                                        Spacer(),
////                                        Expanded(
////                                          flex: 4,
////                                          child: button(null, 20,list.time==null||list.time==""?"No Time":list.time, 12.0,
////                                            Colors.white,blue_color,
////                                          ),),
////                                      ],
////                                    ),
////                                  ),
//
//                                    SizedBox(
//                                      height: 5.0,
//                                    ),
//
//                                    Expanded(
//                                      flex: 1,
//                                      child: Row(
//                                        children: [
//                                          Expanded(
//                                            flex: 3,
//                                            child: button(
//                                              null,
//                                              null,
//                                              parseAppointmentsPriorityIntoText(list.status.toString()),
//                                              10.0,
//                                              Colors.white,
//                                              parseAppointmentsPriorityIntocolor(list.status.toString()),
//
//                                            ),
//                                          ),
//
//                                          Spacer(),
//                                          Expanded(
//                                            flex: 7,
//                                            child: phone_button(
//                                                null,
//                                                null,
//                                                list.phone==null?"No phone":list.phone,
//                                                8.0,
//                                                Colors.white,
//                                                blue_color),
//                                          ),
//
//                                        ],
//                                      ),
//                                    )
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              );
//            })
//            : CircularProgressIndicator(
//          color: app_color,
//        ));
//  }
//}