import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:triple_n/Forms/add_appointment.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Model/appointments.dart';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Views/detailview_appointments.dart';
import 'package:triple_n/Widget/appointment_widget.dart';
import 'package:triple_n/Widget/global_button.dart';

class view_appointments extends StatefulWidget {
  @override
  _view_appointmentsState createState() => _view_appointmentsState();
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

class _view_appointmentsState extends State<view_appointments> {
  @override
  final TextEditingController searchtxt = TextEditingController();
  final TextEditingController appintment_date = TextEditingController();
  final TextEditingController appointment_phoneno = TextEditingController();
  final TextEditingController appointment_name = TextEditingController();

  Widget showbar = view_appbar_txt("Appointments");
  final RefreshController _refreshController = RefreshController(initialRefresh: true);
  List<Appointment> appointment_list = [];
  int current_page = 0, current_search_page = 0, current_filter_page = 0;
  String searchedWord = "";
  String app_name = "";
  String app_phno = "";
  String app_date = "";
  bool onsearch = false;
  bool filter_flag =false;

  bool no_data_present=false;
  //simple data
  Future<List<Appointment>> appointment_manager({bool isReload = false}) async {
    try {
      if (isReload) {
        current_page = 0;
      }

      String flag = "onstart";
      String url = http_root + "appointment.php?page_no=$current_page&size=20&flag=$flag";
      final response = await http.get(url);
      List<Appointment> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        print(parsed
            .map<Appointment>((json) => Appointment.fromJson(json))
            .toList());
        result = parsed
            .map<Appointment>((json) => Appointment.fromJson(json))
            .toList();

        if (result != null && result.isNotEmpty) {
          appointment_list.addAll(result);
          current_page++;
          setState(() {
            if(appointment_list==[] || appointment_list.isEmpty)
            {
              no_data_present=true;
            }
          });
          return result;
        } else {
          return <Appointment>[];
        }
      }
    } catch (e) {
      return <Appointment>[];
    }
  }

//searched data
  Future<List<Appointment>> appointment_manager_onsearch(
      {bool isReload = false, String word}) async {
    try {
      if (isReload) {
        current_search_page = 0;
      }

      String flag = "onsearch";
      String url = http_root + "appointment.php?page_no=$current_search_page&size=5&word=$word&flag=$flag";
      final response = await http.get(url);
      List<Appointment> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        result = parsed
            .map<Appointment>((json) => Appointment.fromJson(json))
            .toList();

//        if (result != null && result.isNotEmpty) {
          this.searchedWord = word;
          current_search_page++;
          appointment_list.addAll(result);

          setState(() {
            if(appointment_list==[] || appointment_list.isEmpty)
            {
             no_data_present=true;
            }
          });


          return result;
//        } else {
//          return <Appointment>[];
//        }
      }
    } catch (e) {
      return <Appointment>[];
    }
  }

  Future<List<Appointment>> appointment_filter_manager(
      {bool isReload = false, String name, String phoneno, String date}) async {
    try {
      if (isReload) {
        current_filter_page = 0;
      }

      print(name);
      print(phoneno);
      print(date);

      String flag = "onfilter";
      String url = http_root + "appointment.php?page_no=$current_filter_page&size=20&username=$name&phoneno=$phoneno&date=$date&flag=$flag";
      final response = await http.get(url);
      List<Appointment> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        result = parsed
            .map<Appointment>((json) => Appointment.fromJson(json))
            .toList();

        print(result);
//        if (result != null && result.isNotEmpty) {
//          this.app_name = appointment_name.text;
//          this.app_date=appintment_date.text;
//          this.app_phno=appointment_phoneno.text;
          current_filter_page++;
          appointment_list.addAll(result);
          setState(() {
            if(appointment_list==[] || appointment_list.isEmpty)
            {
              no_data_present=true;
            }
          });

          return result;
//        } else {
//          return <Appointment>[];
//        }
      }
    } catch (e) {
      return <Appointment>[];
    }
  }

  final _debouncer = Debouncer();

  onstart() async {
    await appointment_manager(isReload: true);
  }

  void initState() {
    super.initState();
    filter_flag = false;
    onstart();
  }

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
                controller: appointment_name,
                decoration: new InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
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
            ),

          SizedBox(
            height: 10.0,
          ),
            //phone
            Container(
              height: 45,
              child: TextField(
                controller: appointment_phoneno,
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

          SizedBox(
            height: 10.0,
          ),
            //date
            Container(
              height: 45,
              child: TextField(
                controller: appintment_date,
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
            ),

//          SizedBox(
//            height: 30.0,
//          ),

          ],
        ),
      ),

      actions: [
        GestureDetector(
          onTap: () {
          if(appointment_name.text.isEmpty && appointment_phoneno.text.isEmpty && appintment_date.text.isEmpty){

            _debouncer.run(() async {
              setState(() {
                no_data_present=false;
                appointment_list = [];
                searchtxt.clear();
                onsearch = false;
                filter_flag = false;
              });
              await appointment_manager(isReload: true);
              setState(() {});
            });


          }
          else{
            _debouncer.run(() async {
              setState(() {
                filter_flag = true;
                if (appointment_list.isNotEmpty) {
                  appointment_list = [];
                }

                app_name = appointment_name.text;
                app_phno = appointment_phoneno.text;
                app_date = appintment_date.text;
              });

              appointment_filter_manager(
                  isReload: true,
                  name: appointment_name.text,
                  date: appintment_date.text,
                  phoneno: appointment_phoneno.text);
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
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            height: 35,
                            width: MediaQuery.of(context).size.width * 0.83,
                            child:  TextField(
                              onChanged: (value) {
                                _debouncer.run(() async {
                                  setState(() {
                                    no_data_present=false;
                                    if (appointment_list.isNotEmpty) {
                                      appointment_list = [];
                                    }
                                    onsearch = true;
                                  });
                                  await appointment_manager_onsearch(
                                    isReload: true,
                                    word: searchtxt.text.toLowerCase(),
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
                                hintText: "By company name or desc",
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
                        Container(
                            width: MediaQuery.of(context).size.width * 0.12),


                        GestureDetector(
                          onTap: () async {
                      Get.to(add_appoitment());

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
                                appointment_list = [];
                                searchtxt.clear();
                                onsearch = false;
                                filter_flag = false;
                              });
                              await appointment_manager(isReload: true);
                              setState(() {});
                            });

                          },
                          child: refresh_button(context),
                        ),

                        Container(width: MediaQuery.of(context).size.width * 0.01),
//                        Container(
//                            width: MediaQuery.of(context).size.width * 0.30),
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
          body: body_layout()

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
            final result = await appointment_filter_manager(
                isReload: true,
                name: app_name,
                phoneno: app_phno,
                date: app_date);
            print(result);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          } else if (onsearch == false && filter_flag == false) {
            final result = await appointment_manager(isReload: true);
            print(result);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          } else if (onsearch == true && filter_flag == false) {
            final result = await appointment_manager_onsearch(
                isReload: true, word: searchedWord);
            print(result);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          }
        },
        onLoading: () async {
          if (filter_flag == true) {
            final result = await appointment_filter_manager(
                name: app_name, phoneno: app_phno, date: app_date);
            print(result);

            if (result != null && result.isNotEmpty) {
              _refreshController.loadComplete();
            } else {
              print("failed");
              _refreshController.loadFailed();
              Message();
            }
          } else if (onsearch == false && filter_flag == false) {
            var result = await appointment_manager();
            if (result != null && result.isNotEmpty) {
              _refreshController.loadComplete();
            } else {
              _refreshController.loadFailed();
              Message();
            }
          } else if (onsearch == true && filter_flag == false) {
            final result =
                await appointment_manager_onsearch(word: searchedWord);
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
        child: (no_data_present==true && appointment_list.isEmpty)?
        my_nodata():appointment_list.isNotEmpty
            ? ListView.builder(
                itemCount:
                    appointment_list == null ? 0 : appointment_list.length,
                itemBuilder: (context, index) {
                  print(appointment_list.length);

                  var list = appointment_list[index];
                  var start_date=DateFormat.d().format(DateTime.parse(list.date))+" "+DateFormat.MMM().format(DateTime.parse(list.date));


//              String time= DateFormat("HH:mm:ss").format(list.start);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => detailview_appointments(
                                  list.id==null
//                                      || list.id.isEmpty
                                      ?""
                                      :list.id,
                                  list.company==null
//                                      || list.company.isEmpty
                                      ?"":list.company,
                                  list.description==null
//                                      || list.description.isEmpty
                                   ? "":list.description,
                                  list.name==null
//                                      || list.name.isEmpty
                                      ?"":list.name,
                                  list.date==null
//                                      || list.date.isEmpty
                                      ?"":list.date,
                                  list.time==null
//                                      || list.time.isEmpty
                                      ?"":list.time,
                                  list.status==null
//                                      || list.status.toString().isEmpty
                                      ?
                                  "":list.status.toString(),

                                  list.phone==null
//                                      || list.phone.isEmpty
                                      ?"":list.phone,
                                  )));
                    },
                    child:  Padding(
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
                                      padding: const EdgeInsets.only(top:8.0,bottom:6.0,left: 20.0,right: 8.0),
                                      child: Column(
                                        children: [


                                          Companies(context, list.company==null ?"  ":list.company.replaceAll('-', ' ').toString(),),

                                          SizedBox(
                                            height: 2.0,
                                          ),


                                          Description(context,  list.description==null?"  ":Bidi.stripHtmlIfNeeded(list.description).replaceFirst("p","").replaceAll("/p", "").toString(),),



                                          SizedBox(
                                            width: 2.0,
                                          ),


                                          progress( parseAppointmentsPriorityIntoText(list.status ==null?'':list.status.toString()),),

                                          SizedBox(
                                            height: 2.0,
                                          ),

                                          progress_linear_indicator( list.status ==null?'':list.status.toString(),),

                                          SizedBox(height: 2.0,),

                                          name(context,list.name==null?" ":list.name,),

                                          SizedBox(
                                            height: 2.0,
                                          ),


                                          time(context,list.time==null ?"" :list.time ),


                                          SizedBox(
                                            height: 2.0,
                                          ),

                                          phone(context,  list.phone==null?"  ":Bidi.stripHtmlIfNeeded(list.phone).replaceFirst("p","").replaceAll("/p", "").toString(),),

                                          SizedBox(
                                            height: 5.0,
                                          ),

                                          id(list.id, true),



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
            : myrefresher()
    );
  }
}
//Padding(
//                      padding: const EdgeInsets.all(10.0),
//                      child: Material(
//                        elevation: 10.0,
//                        borderRadius: BorderRadius.circular(10.0),
//                        child: Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Container(
//                            color: card_color,
//                            height: card_height,
//                            child: Row(
//                              children: [
//                                Expanded(
//                                  flex: 2,
//                                  child: Column(
//                                    children: [
//                                      Expanded(
//                                        flex: 1,
//                                        child: ID_button(null, null, list.id,
//                                            8.0, Colors.white, blue_color),
//                                      ),
//
//                                      SizedBox(
//                                        height: 10.0,
//                                      ),
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
//                                      Expanded(
//                                        flex: 3,
//                                        child: name_button(
//                                            null,
//                                            null,
//                                            list.name == null
////                                                || list.name == ""
//                                                ? "No Name"
//                                                : list.name,
//                                            10.0,
//                                            Colors.white,
//                                            blue_color),
//                                      ),
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
//                                    ],
//                                  ),
//                                ),
//                                SizedBox(
//                                  width: 20.0,
//                                ),
//                                Expanded(
//                                  flex: 8,
//                                  child: Container(
//                                    height: card_height,
//                                    child: Column(
//                                      children: [
//                                        Expanded(
//                                          flex: 2,
//                                          child: Align(
//                                            alignment: Alignment.topLeft,
//                                            child: Container(
////                                              width: MediaQuery.of(context).size.width * 0.6,
//                                              height: null,
//                                              child: Text(
//                                                list.company == null
//                                                    ? "No Company Name"
//                                                    : list.company
//                                                        .replaceAll('-', ' ')
//                                                        .toString(),
//                                                maxLines: 2,
//                                                overflow: TextOverflow.ellipsis,
//                                                textAlign: TextAlign.left,
//                                                style: RowStyle_grey(12.0),
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//
//                                        SizedBox(
//                                          height: 5.0,
//                                        ),
//
//                                        Expanded(
//                                          flex: 2,
//                                          child: Align(
//                                            alignment: Alignment.topLeft,
//                                            child: Container(
////                                              width: MediaQuery.of(context).size.width * 0.6,
//                                              height: null,
//                                              child: Text(
//                                                list.description == null
//                                                    ? "No Discription"
//                                                    : list.description
//                                                        .replaceAll('-', ' ')
//                                                        .toString(),
//                                                maxLines: 2,
//                                                overflow: TextOverflow.ellipsis,
//                                                textAlign: TextAlign.left,
//                                                style: RowStyle_grey(10.0),
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//
//                                        SizedBox(
//                                          height: 5.0,
//                                        ),
//
//                                        Expanded(
//                                            flex: 1,
//                                            child: Row(
//                                              children: [
//                                                Expanded(
//                                                  flex: 5,
//                                                  child: time_button(
//                                                      null,
//                                                      null,
//                                                      list.time == null
////                                                          &&
////                                                              list.time.isEmpty
//                                                          ? " "
//                                                          : list.time,
//                                                      8.0,
//                                                      Colors.white,
//                                                      blue_color),
//                                                ),
//                                                Spacer(),
//                                                Expanded(
//                                                  flex: 5,
//                                                  child: app_date_button(
//                                                      null,
//                                                      null,
//                                                      list.date == null
////                                                          &&
////                                                              list.date.isEmpty
//                                                          ? " "
//                                                          : DateFormat(
//                                                                  'dd-MM-yyyy')
//                                                              .format(DateTime
//                                                                  .parse(list
//                                                                      .date)),
//                                                      8.0,
//                                                      Colors.white,
//                                                      blue_color),
//                                                ),
//                                              ],
//                                            )),
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
//                                        SizedBox(
//                                          height: 5.0,
//                                        ),
//
//                                        Expanded(
//                                          flex: 1,
//                                          child: Row(
//                                            children: [
//                                              Expanded(
//                                                flex: 3,
//                                                child: button(
//                                                  null,
//                                                  null,
//                                                  parseAppointmentsPriorityIntoText(
//                                                      list.status!=null?'':list.status.toString()),
//                                                  10.0,
//                                                  Colors.white,
//                                                  parseAppointmentsPriorityIntocolor(
//                                                      list.status.toString()),
//                                                ),
//                                              ),
//                                              Spacer(),
//                                              Expanded(
//                                                flex: 7,
//                                                child: phone_button(
//                                                    null,
//                                                    null,
//                                                    list.phone == null
//                                                        ? "No phone"
//                                                        : list.phone,
//                                                    8.0,
//                                                    Colors.white,
//                                                    blue_color),
//                                              ),
//                                            ],
//                                          ),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),