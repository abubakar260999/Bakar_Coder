import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Model/task_manager.dart';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Views/detailview_task.dart';
import 'package:triple_n/Widget/task_widget.dart';

class completed extends StatefulWidget {
  @override
  _completedState createState() => _completedState();
}




class _completedState extends State<completed> {
  @override
  final TextEditingController searchtxt = TextEditingController();
  Widget showbar =view_appbar_txt("Completed Task");

  final RefreshController _refreshController = RefreshController(initialRefresh: true);
  List<TaskManager> completed_task_manager_list = [];
  int current_page = 0, current_search_page = 0;
  String searchedWord = "";
  bool keyboard=false;
  bool close = true;
  List empty_assign_to=["Empty"];
//  final _formKey = GlobalKey<FormState>();



  //simple data
  Future<List<TaskManager>> task_manager({bool isReload = false}) async {
    try {
      if (isReload) {
        current_page = 0;
      }
      String url = http_root + "complete.php?page_no=$current_page&size=20";
      final response = await http.get(url);
      List<TaskManager> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        print(parsed.map<TaskManager>((json) => TaskManager.fromJson(json)).toList());
        result = parsed.map<TaskManager>((json) => TaskManager.fromJson(json)).toList();

        if (result != null && result.isNotEmpty) {
          completed_task_manager_list.addAll(result);
          current_page++;
        }
        setState(() {});
        return result;
      } else {
        return <TaskManager>[];
      }
    } catch (e) {
      return <TaskManager>[];
    }
  }

//searched data
  Future<List<TaskManager>> task_manager_onsearch({bool isReload = false, String word}) async {
    try {
      if (isReload) {
        current_search_page = 0;
      }
      String url = http_root + "complete.php?page_no=$current_search_page&size=5&word=$word";
      final response = await http.get(url);
      List<TaskManager> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        result = parsed
            .map<TaskManager>((json) => TaskManager.fromJson(json))
            .toList();
        if (result != null && result.isNotEmpty) {
          this.searchedWord = word;
          current_search_page++;
          completed_task_manager_list.addAll(result);
          setState(() {});
        }
        if (result != null && result.isNotEmpty) {
          return result;
        }
      } else {
        return <TaskManager>[];
      }
    } catch (e) {
      return <TaskManager>[];
    }
  }

  //wait for search

  final _debouncer = Debouncer();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: background_view_color,
//      appBar: AppBar(
//        automaticallyImplyLeading: false,
//        toolbarHeight: 90.0,
//        backgroundColor: app_color,
//        elevation: 10.0,
//
//        title: GestureDetector(
//          onTap: (){
//            searchtxt.clear();
//          },
//          child: TextField(
//
//          onTap: ()  {
//
//          },
//          onChanged: (value) {
//
//            _debouncer.run(() async {
////                        if (completed_task_manager_list.isNotEmpty) {
//              //                        }
//              setState(() {
//                completed_task_manager_list = [];
//
////         close = false;
//              });
//              await task_manager_onsearch(
//                isReload: true,
//                word: value.toLowerCase(),
//              );
//              setState(() {});
//            });
//          },
//    controller: searchtxt,
//    decoration: InputDecoration(
//    contentPadding: EdgeInsets.only(
//    left: 10.0, right: 30.0, top: 10.0, bottom: 10.0),
//    isDense: true,
//    enabledBorder: OutlineInputBorder(
//    borderSide: const BorderSide(
//    color: Colors.white, width: 5.0),
//    borderRadius: BorderRadius.circular(8.0),
//    ),
//    focusedBorder: OutlineInputBorder(
//    borderSide: const BorderSide(
//    color: Colors.white, width: 5.0),
//    borderRadius: BorderRadius.circular(10.0),
//    ),
//    fillColor: w_color,
//    filled: true,
//    hintText: 'Search By Subject',
//    hintStyle: TextStyle(
//    color: Colors.grey,
//    fontSize: 16,
//    fontWeight: FontWeight.w500,
//    fontFamily: "poppins",
//    ),
//    ),
//    style: TextStyle(
//    color: Colors.black,
//    ),
//    ),
//        ),
//
////        actions: [
//////          close == true
//////              ? IconButton(
//////            onPressed: () {
//////                close=false;
//////          setState(() {});
//////            },
//////            icon: Icon(
//////              Icons.search,
//////              color: w_color,
//////            ),
//////          )
//////              : IconButton(
//////            icon: Icon(
//////              Icons.clear,
//////              color: Colors.white,
//////              size: 33.0,
//////            ),
//////            onPressed: () async {
//////              close = true;
//////              searchtxt.clear();
//////              completed_task_manager_list = [];
//////              await task_manager(isReload: true);
//////              setState(() {});
////////              showbar = view_appbar_txt("Completed");
//////            },
//////          )
//////        ],
//      ),

      body: body_layout(),
    );
  }
  body_layout() {
    return SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: () async {
          if (close == true) {
            final result = await task_manager(isReload: true);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          } else {
            final result =
            await task_manager_onsearch(isReload: true, word: searchedWord);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          }
        },
        onLoading: () async {
          if (close == true) {
            var result = await task_manager();
            if (result != null && result.isNotEmpty) {
              _refreshController.loadComplete();
            } else  {
              _refreshController.loadFailed();
              Message();
            }
          } else {
            final result = await task_manager_onsearch(word: searchedWord);
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
        child: completed_task_manager_list != null
            ? SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ListView.builder(
            shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),

                  itemCount:
                  completed_task_manager_list == null ? 0 : completed_task_manager_list.length,
                  itemBuilder: (context, index) {
                    print(completed_task_manager_list.length);
                    var list = completed_task_manager_list[index];
                    var start_date=DateFormat.d().format(list.date)+" "+DateFormat.MMM().format(list.date);
                    var last_date=DateFormat.d().format(list.deadline)+" "+DateFormat.MMM().format(list.deadline);
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
                                  completed_task_manager_list[index].assignto.isEmpty
//                                      ||list.name2.isNotEmpty
                                      ?empty_assign_to:completed_task_manager_list[index].assignto,
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

                        setState(() => completed_task_manager_list[index].status = updated_status);

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
                                                      child: Text(
                                                          completed_task_manager_list[index].status==null?"":completed_task_manager_list[index].status,
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
                                                  value: parseStatusindicatorvalue(completed_task_manager_list[index].status==null?"":completed_task_manager_list[index].status),
                                                  valueColor: parseStatusAnimationIntoColor(completed_task_manager_list[index].status==null?"":completed_task_manager_list[index].status),
                                                  backgroundColor:  parseStatusIntoOpacityColorandpercentage(completed_task_manager_list[index].status==null?"":completed_task_manager_list[index].status),
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
                  }),
            )
            : CircularProgressIndicator(
          color: app_color,
        ));
  }




}
//
//  body_layout() {
//    return SmartRefresher(
//        controller: _refreshController,
//        enablePullUp: true,
//        enablePullDown: true,
//        onRefresh: () async {
//          if (close == true) {
//            final result = await task_manager(isReload: true);
//            if (result != null && result.isNotEmpty) {
//              _refreshController.refreshCompleted();
//            } else {
//              _refreshController.refreshFailed();
//            }
//          } else {
//            final result =
//            await task_manager_onsearch(isReload: true, word: searchedWord);
//            if (result != null && result.isNotEmpty) {
//              _refreshController.refreshCompleted();
//            } else {
//              _refreshController.refreshFailed();
//            }
//          }
//        },
//        onLoading: () async {
//          if (close == true) {
//            var result = await task_manager();
//            if (result != null && result.isNotEmpty) {
//              _refreshController.loadComplete();
//            } else  {
//              _refreshController.loadFailed();
//             Message();
//            }
//          } else {
//            final result = await task_manager_onsearch(word: searchedWord);
//            print(result);
//            if (result != null && result.isNotEmpty) {
//              _refreshController.loadComplete();
//            } else {
//              print("failed");
//
//              _refreshController.loadFailed();
//            Message();
//
//
//            }
//          }
//        },
//        child: completed_task_manager_list != null
//            ? ListView.builder(
//
//            itemCount:
//            completed_task_manager_list == null ? 0 : completed_task_manager_list.length,
//            itemBuilder: (context, index) {
//              print(completed_task_manager_list.length);
//              var list = completed_task_manager_list[index];
//              return Padding(
//                padding: const EdgeInsets.all(10.0),
//                child: Material(
//                  elevation: 10.0,
//                  borderRadius: BorderRadius.circular(10.0),
//                  child: Padding(
//                    padding: const EdgeInsets.all(10.0),
//                    child: Container(
//                      height: 150,
//                      child: Row(
//                        children: [
//                          Expanded(
//                            flex: 2,
//                            child: Align(
//                              alignment: Alignment.topLeft,
//                              child: button(
//                                  null,
//                                  150,
//                                  list.id,
//                                  15.0,
//                                  Colors.white,
//                                  blue_color),
//                            ),
//                          ),
//
//                          SizedBox(
//                            width: 10.0,
//                          ),
//                          Expanded(
//
//                            flex: 8,
//                            child: Container(
//                              height: 150,
//                              child: Column(
//                                children: [
//
//                                  Expanded(
//                                    flex:2,
//                                    child: Align(
//                                      alignment: Alignment.centerLeft,
//                                      child: Container(
////                                              width: MediaQuery.of(context).size.width * 0.6,
//                                        height: 20,
//                                        child: Text(
//                                          list.subject==null||list.subject==""?"No Subject":list.subject
//                                              .replaceAll('-', ' ')
//                                              .toString(),
//                                          maxLines: 1,
//                                          style: RowStyle_grey(13.0),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//
//
//                                  Expanded(
//                                    flex: 2,
//                                    child: Row(
//                                      mainAxisAlignment:
//                                      MainAxisAlignment.spaceEvenly,
//                                      children: [
//                                        Expanded(
//                                          flex: 4,
//                                          child: button(null, 20,   list.name1==null||list.name1==""?"No Name":list.name1, 12.0,
//                                              Colors.white, blue_color),
//                                        ),
//                                        Spacer(),
//                                        Expanded(
//                                          flex: 1,
//                                          child: Text(
//                                            "To",
//                                            maxLines: 1,
//                                            overflow: TextOverflow.ellipsis,
//                                            style: RowStyle_grey(12.0),
//                                          ),
//                                        ),
//                                        Spacer(),
//                                        Expanded(
//                                          flex: 4,
//                                          child: button(null, 20,    list.name2 ==null||list.name2==""?"No Name":list.name2, 12.0,
//                                            Colors.white,blue_color,
//                                          ),),
//                                      ],
//                                    ),
//                                  ),
//
//                                  Expanded(
//                                    flex: 2,
//                                    child: Row(
//                                      mainAxisAlignment:
//                                      MainAxisAlignment.spaceEvenly,
//                                      children: [
//                                        Expanded(
//                                          flex:4,
//                                          child: date_button(null, 40,    list.date==null||list.date==""?"No Date":list.date, 12.0,
//                                              Colors.white,blue_color),
//                                        ),
//                                        Spacer(),
//                                        Expanded(
//                                          flex: 1,
//                                          child: Text(
//                                            "To",
//                                            maxLines: 1,
//                                            overflow: TextOverflow.ellipsis,
//                                            style: RowStyle_grey(12.0),
//                                          ),
//                                        ),
//                                        Spacer(),
//                                        Expanded(
//                                          flex: 4,
//                                          child: date_button(
//                                              null,
//                                              40,
//                                              list.deadline==null||list.deadline==""?"No Deadline":list.deadline,
//                                              12.0,
//                                              Colors.white,
//                                              blue_color),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  Expanded(
//                                    flex: 2,
//                                    child: Row(
//                                      children: [
//                                        Expanded(
//                                          flex:4,
//
//                                          child: button(
//                                              null,
//                                              20.0,
//                                              list.status==null?"No Status":list.status,
//                                              12.0,
//                                              Colors.white,
//                                              parseStatusIntoColor(list.status)),
//                                        ),
//                                        Spacer(),
//                                        Expanded(
//                                          flex: 1,
//                                          child: Text(
//                                            "--",
//                                            maxLines: 1,
//                                            overflow: TextOverflow.ellipsis,
//                                            style: RowStyle_grey(12.0),
//                                          ),
//                                        ),
//                                        Spacer(),
//                                        Expanded(
//                                          flex:4,
//                                          child: button(
//                                              null,
//                                              20.0,
//                                              list.priority==null?"No priority":list.priority,
//                                              12.0,
//                                              Colors.white,
//                                              parsePriorityIntoColor(
//                                                  list.priority)),
//                                        )
//                                      ],
//                                    ),
//                                  )
//                                ],
//                              ),
//                            ),
//                          ),
//                        ],
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

class Debouncer {
  int milliseconds;
  VoidCallback action;
  Timer timer;

  run(VoidCallback action) {
    if ( timer !=null) {
      timer.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}
