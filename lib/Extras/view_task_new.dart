////import 'dart:convert';
////import 'package:http/http.dart' as http;
////import 'package:flutter/material.dart';
////import 'package:intl/intl.dart';
////import 'package:triple_n/Global/global.dart';
////import 'package:triple_n/Model/fourmain.dart';
////import 'package:triple_n/Widget/search_appbar.dart';
////
////class view_task extends StatefulWidget {
////  @override
////  _view_taskState createState() => _view_taskState();
////}
////
////class _view_taskState extends State<view_task> {
////  @override
////
////  var format = DateFormat("dd-MM-yyyy");
////  ScrollController _scrollController;
////
////  String title="Tickets";
//// String hint_text= "Search By Subject";
////   bool isLastPage=false;
////   int pageNumber=0;
////   bool error=false;
////   bool loading=false;
////  final int numberOfPostsPerRequest = 10;
////   List<TaskManager> taskmanager_list;
////   List<TaskManager> temp_list=[];
////  final int nextPageTrigger = 1;
////
////
////
////  Future<void> task_manager() async {
////    try {
////      String url = http_root + "search_task_manager.php?page_no=$pageNumber&size=numberOfPostsPerRequest";
////      final response = await http.get(url);
////
////      if (response.statusCode == 200) {
////        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
////        print(parsed.map<TaskManager>((json) => TaskManager.fromJson(json)).toList());
////        List<TaskManager> result_list= parsed.map<TaskManager>((json) => TaskManager.fromJson(json)).toList();
////          isLastPage = result_list.length < numberOfPostsPerRequest;
////          loading = false;
////        setState(() {
////          taskmanager_list=result_list;
////          pageNumber = pageNumber + 1;
////        });
////      } else {
////        setState(() {
////          loading = false;
////          error = true;
////        });
////      }
////    } catch (e) {
////      setState(() {
////        loading = false;
////        error = true;
////      });
////    }
////  }
////
////  bool close;
////
////  @override
////  void initState() {
////    super.initState();
////    _scrollController=ScrollController();
////    pageNumber = 0;
////    taskmanager_list = [];
////    isLastPage = false;
////    loading = true;
////     close=true;
////    error = false;
////    task_manager();
////
////    _scrollController.addListener(() {
////// nextPageTrigger will have a value equivalent to 80% of the list size.
////      var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
////
////// _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
////      if (_scrollController.position.pixels > nextPageTrigger) {
////        loading = true;
////        task_manager();
////      }
////    });
////
////  }
////
////
////  Widget build(BuildContext context) {
////
////    return Scaffold(
////      appBar:search_appbar(title,hint_text,close),
////
////      body:body_layout(),
////    );
////  }
////  Widget body_layout(){
////    print(close);
////
////    if (taskmanager_list.isEmpty) {
////      if (loading) {
////        return const Center(
////            child: Padding(
////              padding: EdgeInsets.all(8),
////              child: CircularProgressIndicator(),
////            ));
////      } else if (error) {
////        return Center(
////            child: errorDialog(size: 20)
////        );
////      }
////    }
////    return ListView.builder(
////      //sp
////        itemCount: taskmanager_list.length+ (isLastPage ? 0 : 1),
////        itemBuilder:(context,index)
////        {
////          if (index == taskmanager_list.length - nextPageTrigger) {
////            task_manager();
////          }
////          if (index == taskmanager_list.length) {
////            if (error) {
////              return Center(
////                  child: errorDialog(size: 15)
////              );
////            } else {
////              return const Center(
////                  child: Padding(
////                    padding: EdgeInsets.all(8),
////                    child: CircularProgressIndicator(),
////                  ));
////            }
////          }
////
////         var item=taskmanager_list[index];
////           return Container(
////            width: MediaQuery.of(context).size.width,
////            height: 200,
////            child: Padding(
////              padding: const EdgeInsets.all(10.0),
////              child: Row(
////                children: [
////
////
////                  Column(
////                    children: [
////                      Text(
////                        item.id.toString(),
////                        style: RowStyle(),
////                      ),
////                      Container(
////                        width: 100,
////                        height: 60,
////                        child: Text(
////                          item.subject.toString(),
////                          maxLines: 2,
////                          overflow: TextOverflow.ellipsis,
////                          style: RowStyle(),
////                        ),
////                      ),
////                      Row(
////                        children: [
////                          Text(
////                            item.name1.toString(),
////                            style: RowStyle(),
////                          ),
////                          Text(
////                            "To",
////                            maxLines: 1,
////                            overflow: TextOverflow.ellipsis,
////                            style: RowStyle(),
////                          ),
////                          Text(
////                            item.name2.toString(),
////                            style: RowStyle(),
////                          ),
////                        ],
////                      ),
////                      Row(
////                        children: [
////                          Column(
////                            mainAxisAlignment: MainAxisAlignment.center,
////                            crossAxisAlignment: CrossAxisAlignment.center,
////                            children: [
////                              Text(
////                                format.format(item.date).toString(),
////                                style: RowStyle(),
////                              ),
////                              Center(
////                                  child: Text(
////                                    DateFormat.Hms().format(item.date).toString(),
////                                    style: RowStyle(),
////                                  )),
////                            ],
////                          ),
////                          Text(
////                            "To",
////                            maxLines: 1,
////                            overflow: TextOverflow.ellipsis,
////                            style: RowStyle(),
////                          ),
////                          Column(
////                            mainAxisAlignment: MainAxisAlignment.center,
////                            crossAxisAlignment: CrossAxisAlignment.center,
////                            children: [
////                              Text(
////                                format.format(item.deadline).toString(),
////                                style: RowStyle(),
////                              ),
////                              Center(
////                                  child: Text(
////                                    DateFormat.Hms().format(item.deadline).toString(),
////                                    style: RowStyle(),
////                                  )),
////                            ],
////                          ),
////                        ],
////                      )
////                    ],
////                  ),
////                  Column(
////                    children: [
////                      Container(
////                        width: MediaQuery.of(context).size.width * 0.4,
////                        height: 30.0,
////                        child: RawMaterialButton(
//////              onPressed: (){
//////                pages().elementAt(_selectedIndex);
//////                },
////                          elevation: 5.0,
////                          child: Text(
////                            item.status.toString(),
////                            style: TextStyle(
////                                fontSize: 12.0,
////                                fontFamily: "poppins",
////                                fontWeight: FontWeight.w600,
////                                color: Colors.white),
////                          ),
////                          shape: RoundedRectangleBorder(
////                              borderRadius: BorderRadius.circular(10.0)),
////                          fillColor: parseStatusIntoColor(item.status),
////                          highlightColor: app_color,
////                          onPressed: () {},
//////                padding: const EdgeInsets.all(10.0),
////                        ),
////                      ),
////                      Container(
////                        width: MediaQuery.of(context).size.width * 0.4,
////                        height: 30.0,
////                        child: RawMaterialButton(
//////              onPressed: (){
//////                pages().elementAt(_selectedIndex);
//////                },
////                          elevation: 5.0,
////                          child: Text(
////                            item.priority.toString(),
////                            style: TextStyle(
////                                fontSize: 12.0,
////                                fontFamily: "poppins",
////                                fontWeight: FontWeight.w600,
////                                color: Colors.white),
////                          ),
////                          shape: RoundedRectangleBorder(
////                              borderRadius: BorderRadius.circular(10.0)),
////                          fillColor: parsePriorityIntoColor(item.priority),
////                          highlightColor: app_color,
////                          onPressed: () {},
////                        ),
////                      ),
////                    ],
////                  )
////                ],
////              ),
////            ),
////          );
////        }
////    );
////  }
////
////  parseStatusIntoColor(String status) {
////    switch (status) {
////      case "Complete":
////        return Color(0xff22D071);
////      case "Not Started":
////        return Color(0xffF5E633);
////      case "In Progress":
////        return Color(0xffFFA500);
////      case "Waiting for Reply":
////        return Color(0xff00C6F8);
////      default:
////        return Colors.white;
////    }
////  }
////
////  parsePriorityIntoColor(String priority) {
////    switch (priority) {
////      case "High":
////        return Color(0xff22D071);
////      case "Medium":
////        return Color(0xff00C6F8);
////      case "Low":
////        return Color(0xffE795E7);
////      default:
////        return Color(0xffF5E633);
////    }
////  }
////
////  Widget errorDialog({double size}){
////    return SizedBox(
////      height: 180,
////      width: 200,
////      child:  Column(
////        mainAxisAlignment: MainAxisAlignment.center,
////        children: [
////          Text('An error occurred when fetching the posts.',
////            style: TextStyle(
////                fontSize: size,
////                fontWeight: FontWeight.w500,
////                color: Colors.black
////            ),
////          ),
////          const SizedBox(height: 10,),
////          FlatButton(
////              onPressed:  ()  {
////                setState(() {
////                  loading = true;
////                  error = false;
////                  task_manager();
////                });
////              },
////              child: const Text("Retry", style: TextStyle(fontSize: 20, color: Colors.purpleAccent),)),
////        ],
////      ),
////    );
////  }
////}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
////Task Owner
//
//FutureBuilder<List<Users>>(
//future: UsersService.users(),
//builder:(context,snapshot)
//{
//if(snapshot.hasData){
//
//return DropdownButtonFormField(
//validator: (value) {
//if (value == '' || value == null) {
//return "Plz Enter Task Owner";
//}
//},
//
//
//decoration: InputDecoration(
//enabledBorder: OutlineInputBorder(
//borderSide: BorderSide(color: app_color, width: 0.0),
//),
////                      errorText: "",
//errorStyle:
//TextStyle(color: Colors.redAccent, fontSize: 12.0),
//border: new OutlineInputBorder(
//borderRadius: new BorderRadius.circular(10.0),
//borderSide: new BorderSide(color: app_color),
//),
//),
//autovalidateMode: AutovalidateMode.onUserInteraction,
//hint: task_owner == null
//? Text(
//'Task Owner',
//style: TextStyle(color: app_color),
//)
//    : Text(
//task_owner,
//style: TextStyle(color: app_color),
//),
//isExpanded: true,
//iconEnabledColor: app_color,
//iconDisabledColor: app_color,
//iconSize: 30.0,
//style: TextStyle(color: app_color),
//items: User_list.map(
//(val) {
//
//return DropdownMenuItem<String>(
//value: val.id,
//child: Text(val.name),
//onTap: (){
//setState(() {
//task_owner=val.name;
//});
//},
//);
//},
//).toList(),
//
//onChanged: (val) {
//setState(() {
//print(val);
//task_owner_final = val;
//});
//
//},
//
//);
//
//}
//else{
//return CircularProgressIndicator(
//
//);
//}
//
//},
//),
//SizedBox(
//height: 30.0,
//),
//
////New client
////                  DropdownButtonFormField(
////                    validator: (value) {
////                      if (value == '' || value == null) {
////                        return "Plz Enter Client";
////                      }
////                    },
////                    decoration: InputDecoration(
////
////                      enabledBorder: OutlineInputBorder(
////                        borderSide: BorderSide(color: app_color, width: 0.0),
////                      ),
//////                      errorText: "",
////                      errorStyle:
////                      TextStyle(color: Colors.redAccent, fontSize: 12.0),
////                      border: new OutlineInputBorder(
////                        borderRadius: new BorderRadius.circular(10.0),
////                        borderSide: new BorderSide(color: app_color),
////                      ),
////                    ),
////                    autovalidateMode: AutovalidateMode.onUserInteraction,
////                    hint: client == null
////                        ? Text(
////                      'Client',
////                      style: TextStyle(color: app_color),
////                    )
////                        : Text(
////                      client,
////                      style: TextStyle(color: app_color),
////                    ),
////                    isExpanded: true,
////                    iconEnabledColor: app_color,
////                    iconDisabledColor: app_color,
////                    iconSize: 30.0,
////                    style: TextStyle(color: app_color),
////                    items: client_list.map(
////                          (val) {
////                        return DropdownMenuItem<String>(
////                          value: val,
////                          child: Text(val),
////                        );
////                      },
////                    ).toList(),
////                    onChanged: (val) {
////                      setState(
////                            () {
////                          client = val;
////                        },
////                      );
////                    },
////                  ),
////
////
////                  SizedBox(
////                    height: 30.0,
////                  ),
//
////Assigned by
//
//FutureBuilder<List<Users>>(
//future: UsersService.users(),
//builder: (context,snapshot)
//{
//if(snapshot.hasData){
//return DropdownButtonFormField(
//validator: (value) {
//if (value == '' || value == null) {
//return "Plz Enter Assigned By";
//}
//},
//decoration: InputDecoration(
//
//enabledBorder: OutlineInputBorder(
//borderSide: BorderSide(color: app_color, width: 0.0),
//),
////                      errorText: "",
//errorStyle:
//TextStyle(color: Colors.redAccent, fontSize: 12.0),
//border: new OutlineInputBorder(
//borderRadius: new BorderRadius.circular(10.0),
//borderSide: new BorderSide(color: app_color),
//),
//),
//autovalidateMode: AutovalidateMode.onUserInteraction,
//hint: assigned_by == null
//? Text(
//'Assigned By',
//style: TextStyle(color: app_color),
//)
//    : Text(
//assigned_by,
//style: TextStyle(color: app_color),
//),
//isExpanded: true,
//iconEnabledColor: app_color,
//iconDisabledColor: app_color,
//iconSize: 30.0,
//style: TextStyle(color: app_color),
//items: snapshot.data.map(
//(val) {
//return DropdownMenuItem<String>(
//value: val.id,
//child: Text(val.name),
//onTap: (){
//setState(() {
//assigned_by=val.name;
//});
//},
//);
//},
//).toList(),
//onChanged: (val) {
//setState(
//() {
//assigned_by_final = val;
//},
//);
//},
//);
//
//}
//else{
//
//return CircularProgressIndicator(
//color: app_color,
//);
//}
//
//}
//),
