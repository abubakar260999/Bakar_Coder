import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:triple_n/Forms/add_call.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Model/call.dart';
import 'package:triple_n/Model/companies.dart';
import 'package:triple_n/Model/task_manager.dart';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Service/Companies.dart';
import 'package:triple_n/Views/detailview_call.dart';
import 'package:triple_n/Widget/call_widget.dart';
import 'package:triple_n/Widget/global_button.dart';

class view_call extends StatefulWidget {
  @override
  _view_callState createState() => _view_callState();
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

class _view_callState extends State<view_call> {
  @override
  final TextEditingController searchtxt = TextEditingController();
  Widget showbar = view_appbar_txt("Call Directory");

  final RefreshController _refreshController = RefreshController(initialRefresh: true);
  List<Calls> calls_list = [];
  int current_page = 0, current_search_page = 0;
  String searchedWord = "";


  final TextEditingController calls_business_name = TextEditingController();
  final TextEditingController calls_phone = TextEditingController();
  final TextEditingController calls_email = TextEditingController();

  String call_name = "";
  String call_phno = "";
  String call_email = "";

  bool onsearch = false;
  bool filter_flag =false;
  int current_filter_page = 0;
  bool no_data_present=false;

  List _list = new List();

  static const customer_label = "Business Name";


  onstart() async {
    await calls_manager(isReload: true);
  }

  void initState() {
    super.initState();
    filter_flag = false;
    onstart();
  }

  //simple data
  Future<List<Calls>> calls_manager({bool isReload = false}) async {
    try {
      if (isReload) {
        current_page = 0;
      }
      String flag = "onstart";
      String url = http_root + "calls.php?page_no=$current_page&size=20&flag=$flag";
      final response = await http.get(url);

      List<Calls> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        print(parsed.map<Calls>((json) => Calls.fromJson(json)).toList());
        result = parsed.map<Calls>((json) => Calls.fromJson(json)).toList();

        print(calls_list);
//        if (result != null && result.isNotEmpty) {
          calls_list.addAll(result);
          current_page++;
          print(calls_list);
//        }
        setState(() {
          if(calls_list==[] || calls_list.isEmpty)
          {
            no_data_present=true;
          }
        });
        return result;
      }
//      else {
//        return <Calls>[];
//      }
    } catch (e) {
      print(e);
      return <Calls>[];
    }
  }

//searched data
  Future<List<Calls>> calls_manager_onsearch(
      {bool isReload = false, String word}) async {
    try {
      if (isReload) {
        current_search_page = 0;
      }

      String flag = "onsearch";
      String url = http_root + "calls.php?page_no=$current_search_page&size=5&word=$word&flag=$flag";


      final response = await http.get(url);
      List<Calls> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        result = parsed
            .map<Calls>((json) => Calls.fromJson(json))
            .toList();
        if (result != null && result.isNotEmpty) {
          this.searchedWord = word;
          current_search_page++;
          calls_list.addAll(result);
          setState(() {
            if(calls_list==[] || calls_list.isEmpty)
            {
              no_data_present=true;
            }
          });
        }
//        if (result != null && result.isNotEmpty) {
          return result;
        }
//      } else {
//        return <Calls>[];
//      }
    } catch (e) {
      return <Calls>[];
    }
  }

  Future<List<Calls>> calls_filter_manager(
      {bool isReload = false, String name, String phone, String email}) async {
    try {
      if (isReload) {
        current_filter_page = 0;
      }

//      print(name);
//      print(phoneno);
//      print(date);

      String flag = "onfilter";
      String url = http_root + "calls.php?page_no=$current_filter_page&size=20&business_name=$name&phone=$phone&email=$email&flag=$flag";
      final response = await http.get(url);
      List<Calls> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        result = parsed
            .map<Calls>((json) => Calls.fromJson(json))
            .toList();

        print(result);
//        if (result != null && result.isNotEmpty) {
//          this.app_name = appointment_name.text;
//          this.app_date=appintment_date.text;
//          this.app_phno=appointment_phoneno.text;
          current_filter_page++;
          calls_list.addAll(result);
          setState(() {
            if(calls_list==[] || calls_list.isEmpty)
            {
              no_data_present=true;
            }
          });
          return result;
//        } else {
//          return <Calls>[];
//        }
      }
    } catch (e) {
      return <Calls>[];
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
        height: 170,
        child: Column(
          children: [

            Container(
              height: 45,
              child: new TextField(
                controller: calls_business_name,
                decoration: new InputDecoration(
                  labelText: "Business Name",
                  fillColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  prefixIcon: Icon(
                    Icons.business_outlined,
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
            ),

          SizedBox(
            height: 10.0,
          ),
            Expanded(
              child: new TextField(
                controller: calls_email,
                decoration: new InputDecoration(
                  labelText: "Email",
                  fillColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  prefixIcon: Icon(
                    Icons.email_outlined,
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
            ),

          SizedBox(
            height: 10.0,
          ),
            //phone
            Container(
              height: 45,
              child: TextField(
                controller: calls_phone,
                decoration: new InputDecoration(
                  labelText: "Phone number",
                  fillColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
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
            ),


//
//          SizedBox(
//            height: 30.0,
//          ),

          ],
        ),
      ),

      actions: [
        GestureDetector(
          onTap: () {
if(calls_business_name.text.isEmpty && calls_email.text.isEmpty && calls_phone.text.isEmpty){

  _debouncer.run(() async {
    setState(() {
      no_data_present=false;
      calls_list = [];
      searchtxt.clear();
      onsearch = false;
      filter_flag = false;
    });
    await calls_manager(isReload: true);
    setState(() {});
  });
}else{
  _debouncer.run(() async {
    setState(() {
      filter_flag = true;
      if (calls_list.isNotEmpty) {
        calls_list = [];
      }

      call_name=calls_business_name.text;
      call_email=calls_email.text;
      call_phno=calls_phone.text;

    });

    calls_filter_manager(
        isReload: true,
        name:calls_business_name.text,
        email:calls_email.text,
        phone:calls_phone.text);
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
                                  no_data_present=false;
                                  setState(() {
                                    if (calls_list.isNotEmpty) {
                                      calls_list = [];
                                    }
                                    onsearch = true;
                                  });
                                  await calls_manager_onsearch(
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
                                hintText: "By subject or description",
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



                      GestureDetector(
                        onTap: () async {
                          Get.to(add_call());
                        },
                        child: add_button(context),
                      ),

                      Container(width: MediaQuery.of(context).size.width * 0.01),

                      GestureDetector(
                        onTap: () async {
                          _debouncer.run(() async {
                            setState(() {
                              no_data_present=false;
                              calls_list = [];
                              searchtxt.clear();
                              onsearch = false;
                              filter_flag = false;
                            });
                            await calls_manager(isReload: true);
                            setState(() {});
                          });

                        },
                        child: refresh_button(context),
                      ),


//                      Container(
//                          width: MediaQuery.of(context).size.width * 0.3),
                      Container(width: MediaQuery.of(context).size.width * 0.01),
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
            final result = await calls_filter_manager(
                isReload: true,
                name:calls_business_name.text,
                email:calls_email.text,
                phone:calls_phone.text);
            print(result);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          } else if (onsearch == false && filter_flag == false) {
            final result = await calls_manager(isReload: true);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          } else if (onsearch == true && filter_flag == false) {
            final result = await calls_manager_onsearch(
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
            final result = await calls_filter_manager(
                name:calls_business_name.text,
                email:calls_email.text,
                phone:calls_phone.text);
            print(result);
            if (result != null && result.isNotEmpty) {
              _refreshController.loadComplete();
            } else {
              print("failed");
              _refreshController.loadFailed();
              Message();
            }
          } else if (onsearch == false && filter_flag == false) {
            var result = await calls_manager();
            if (result != null && result.isNotEmpty) {
              _refreshController.loadComplete();
            } else {
              _refreshController.loadFailed();
              Message();
            }
          } else if (onsearch == true && filter_flag == false) {
            final result =
            await calls_manager_onsearch(word: searchedWord);
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
        child:  (no_data_present==true && calls_list.isEmpty)?
        my_nodata():calls_list.isNotEmpty
            ? ListView.builder(
            itemCount:
            calls_list == null ? 0 : calls_list.length,
            itemBuilder: (context, index) {
              print(calls_list.length);
              var list = calls_list[index];


    String date= DateFormat("dd-MM-yyyy").format(list.date).toString();
String time=DateFormat.Hm().format(list.date!=null?list.date:"").toString();



           var start_date=DateFormat.d().format(list.date)+" "+DateFormat.MMM().format(list.date);


              return GestureDetector(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>detailview_call(
                   list.id!=null
//                       ||list.id.isNotEmpty
                       ?list.id:"",
                   list.attenderName!=null
//                       ||list.attenderName.isNotEmpty
                       ? list.attenderName:"",
                   list.callForName!=null
//                       ||list.callForName.isNotEmpty
                       ?list.callForName:"",
                   list.type!=null
//                       ||list.type.isNotEmpty
                       ? list.type:"",
                   list.subject!=null
//                       ||list.subject.isNotEmpty
                       ?list.subject:"",
                   list.businessName!=null
//                       ||list.businessName.isNotEmpty
                       ?list.businessName:"",
                   date,
                   time,
                   list.phone!=null
//                       ||list.phone.isNotEmpty
                       ?list.phone:"",
                   list.phone2!=null
//                       ||list.phone.isNotEmpty
                       ?list.phone2:"",
                 ),));

               },

                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      color: card_color,
                      height:164,
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

                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 3,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50.0),
                                        color: app_color,
                                      ),
                                    ),
                                  ),



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
                                  padding: const EdgeInsets.only(top:8.0,bottom:6.0,left: 15.0,right: 8.0),
                                  child: Column(
                                    children: [


                                      business_name(context, list.businessName==null ?"  ":list.businessName.replaceAll('-', ' ').toString(),),

                                      SizedBox(height: 2.0,),

                                      name(context,list.callForName==null?"":list.callForName,),


                                      SizedBox(
                                        width: 2.0,
                                      ),

                                      name(context,list.attenderName==null?"":list.attenderName,),

                                      SizedBox(
                                        height: 2.0,
                                      ),


                                      subject(context, list.subject==null ?"  ":list.subject.replaceAll('-', ' ').toString(),),


                                      SizedBox(
                                        height: 2.0,
                                      ),


                                      Description(context,  list.description==null?"  ":Bidi.stripHtmlIfNeeded(list.description).replaceFirst("p","").replaceAll("/p", "").toString(),),

                                      SizedBox(
                                        height: 2.0,
                                      ),
//
                                      phone(context, list.phone==null ?"  ":list.phone,),

                                      SizedBox(
                                        height: 2.0,
                                      ),


                                      phone(context, list.phone2==null ?"  ":list.phone2,),

                                      SizedBox(
                                        height: 2.0,
                                      ),

                                     id(list.id, true,list.type),



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
//Padding(
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
//
//                           Expanded(
//                             flex: 2,
//                             child: Column(
//                               children: [
//
//                                 Expanded(
//                                   flex: 1,
//                                   child: ID_button(
//                                       null,
//                                       null,
//                                       list.id,
//                                       8,
//                                       Colors.white,
//                                       blue_color),
//                                 ),
//
//
//
//                                 SizedBox(
//                                   height: 5.0,
//                                 ),
//
//
//                                 Expanded(
//                                   flex: 3,
//                                   child: calls_assigned_button(
//                                       null,
//                                       null,
//                                       list.attenderName!=null?list.attenderName:"",
//                                       list.callForName!=null?list.callForName:"",
//                                       8,
//                                       Colors.white,
//                                       blue_color),
//                                 ),
//
//                                 SizedBox(
//                                   height: 5.0,
//                                 ),
//
//
//                                 Expanded(
//                                   flex:1,
//                                   child: button(
//                                       null,
//                                       null,
//                                       list.type==null?"No data":list.type,
//                                       10,
//                                       Colors.white,
//                                       parseDailyCallsStatusIntoColor(list.type)),
//                                 )
//
//                               ],
//                             ),
//                           ),
//
//                            SizedBox(
//                              width: 10.0,
//                            ),
//
//                            Expanded(
//
//                              flex: 8,
//                              child: Container(
//                                height:card_height,
//                                child: Column(
//                                  children: [
//
//                                    Expanded(
//                                      flex:2,
//                                      child: Align(
//                                        alignment: Alignment.topLeft,
//                                        child: Container(
////                                              width: MediaQuery.of(context).size.width * 0.6,
//                                          height: null,
//                                          child: Text(
////                                            list.subject==""||
//                                                list.subject==null?"No Subject":list.subject
//                                                .replaceAll('-', ' ')
//                                                .toString(),
//                                            maxLines: 2,
//                                            overflow: TextOverflow.ellipsis,
//                                            style: RowStyle_grey(13.0),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//
//                                    SizedBox(
//                                      height: 5.0,
//                                    ),
//
//
//                                    Expanded(
//                                      flex:2,
//                                      child: Align(
//                                        alignment: Alignment.topLeft,
//                                        child: Container(
////                                              width: MediaQuery.of(context).size.width * 0.6,
//                                          height: null,
//                                          child: Text(
////                                            list.businessName==""||
//                                                list.businessName==null?"No Business name":list.businessName
//                                                .replaceAll('-', ' ')
//                                                .toString(),
//                                            maxLines: 2,
//                                            overflow: TextOverflow.ellipsis,
//                                            style: RowStyle_grey(10),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//
//                                    SizedBox(
//                                      height: 5.0,
//                                    ),
//
////                                  Expanded(
////                                    flex: 2,
////                                    child: Row(
////                                      mainAxisAlignment:
////                                      MainAxisAlignment.spaceEvenly,
////                                      children: [
////                                        Expanded(
////                                          flex: 4,
////                                          child: button(null, null, list.attenderName==""||list.attenderName==null?"No Attender Name":list.attenderName, 12.0,
////                                              Colors.white, blue_color),
////                                        ),
////                                        Spacer(),
////                                        Expanded(
////                                          flex: 1,
////                                          child: Text(
////                                            "For",
////                                            maxLines: 1,
////                                            overflow: TextOverflow.ellipsis,
////                                            style: RowStyle_grey(12.0),
////                                          ),
////                                        ),
////                                        Spacer(),
////                                        Expanded(
////                                          flex: 4,
////                                          child: button(null, 20, list.callForName==""||list.callForName==null?"No Call For Name":list.callForName, 12,
////                                            Colors.white,blue_color,
////                                          ),),
////                                      ],
////                                    ),
////                                  ),
//
//                                    Expanded(
//                                      flex: 1,
//                                      child: Row(
//                                        children: [
//                                         Expanded(
//                                             flex:5,
//                                             child: app_date_button(null, null,date , 8, Colors.white,blue_color)),
//
//                                          Spacer(),
//
//     Expanded(
//         flex:5,child: time_button(null, null, time, 8, Colors.white,blue_color)),
//
//                                        ],
//                                      )
//                                    ),
//
//
//                                    SizedBox(
//                                      height: 2.0,
//                                    ),
//
//                                    Expanded(
//                                      flex:1,
//
//                                      child: phone_button(
//                                          MediaQuery.of(context).size.width,
//                                          null,
//                                          list.phone2==null?"No Phone":list.phone2,
//                                          8,
//                                          Colors.white,
//                                          blue_color),
//                                    ),
//
//
//
//                                        ],
//                                      ),
//                                    )
//                                ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                ),