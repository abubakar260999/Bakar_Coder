//Daily Task

//import 'dart:async';
//import 'dart:convert';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
//import 'package:flutter/services.dart';
//import 'package:intl/intl.dart';
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/daily_task_widget.dart';
//import 'package:triple_n/Service/Daily_task.dart';
//
//
//
//class view_daily_task extends StatefulWidget {
//  @override
//  _view_daily_taskState createState() => _view_daily_taskState();
//}
//
//class _view_daily_taskState extends State<view_daily_task> {
//  @override
//  final TextEditingController searchtxt = TextEditingController();
//
//
//  List<DailyTask> daily_task_list = [];
//  List<DailyTask> filtereddaily_task_list = [];
//
//  Future get_appointment() async {
//    await Daily_taskService.daily_task().then((daily_task) {
//      setState(() {
//        daily_task_list = daily_task;
//        filtereddaily_task_list = daily_task;
//      });
//    });
//  }
//
//  void initState() {
//    get_appointment();
//    super.initState();
//  }
//
//  Widget showbar = Text(
//    "Daily Task",
//    style: TextStyle(
//      fontFamily: "poppins",
//      fontSize: 24.0,
//      color: Colors.white,
//    ),
//  );
//  bool close = true;
//
//
//
//  final key = new GlobalKey<PaginatedDataTableState>();
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          toolbarHeight: 90.0,
//          brightness: Brightness.light,
//          backgroundColor: app_color,
//          elevation: 10.0,
//          title: showbar,
//          leading: close == true
//              ? GestureDetector(
//              onTap: () {
//                Navigator.pop(context);
//              },
//              child: Icon(
//                Icons.arrow_back_ios,
//                color: w_color,
//              ))
//              : null,
//          actions: [
//            close == true
//                ? IconButton(
//              onPressed: () {
//                setState(() {
//                  close = false;
//                  showbar = TextField(
//                    onChanged: (value) {
//
////                            if (search_list.isNotEmpty) {
//
//                      filtereddaily_task_list = daily_task_list
//                          .where((element) => (element.user
//                          .toLowerCase()
//                          .contains(value.toLowerCase())
//                      )).toList();
//                      setState(() {});
//
//
//
//                      print(value);
////                                custombody_list = search_list
////                                    .where((string) => string
////                                        .toLowerCase()
////                                        .contains(value.toLowerCase()))
////                                    .toList();
//////                                print(custombody_list);
////                              });
////                            }
////                            else {
////                              print("list is empty");
////                            }
//                    },
//                    controller: searchtxt,
//                    onTap: (){
//                      key.currentState.pageTo(0);
//                    },
//                    decoration: InputDecoration(
//                      contentPadding: EdgeInsets.only(
//                          left: 10.0,
//                          right: 30.0,
//                          top: 10.0,
//                          bottom: 10.0),
//                      isDense: true,
//                      enabledBorder: OutlineInputBorder(
//                        borderSide: const BorderSide(
//                            color: Colors.white, width: 2.0),
//                        borderRadius: BorderRadius.circular(8.0),
//                      ),
//                      focusedBorder: OutlineInputBorder(
//                        borderSide: const BorderSide(
//                            color: Colors.white, width: 2.0),
//                        borderRadius: BorderRadius.circular(10.0),
//                      ),
//                      fillColor: w_color,
//                      filled: true,
//                      hintText: 'Search here',
//                      hintStyle: TextStyle(
//                        color: Colors.grey,
//                        fontSize: 16,
//                        fontWeight: FontWeight.w500,
//                        fontFamily: "poppins",
//                      ),
//                      border: InputBorder.none,
//                    ),
//                    style: TextStyle(
//                      color: Colors.black,
//                    ),
//                  );
//                });
//              },
////            showSearch(
////                context: context,
////                delegate: search(search_list));
//
//              icon: Icon(
//                Icons.search,
//                color: w_color,
//              ),
//            )
//                : IconButton(
//              icon: Icon(
//                Icons.clear,
//                color: Colors.white,
//                size: 33.0,
//              ),
//              onPressed: () {
//                setState(() {
//                  close = true;
//                  showbar = Text(
//                    "Daily Task",
//                    style: TextStyle(
//                      fontFamily: "poppins",
//                      fontSize: 24.0,
//                      color: Colors.white,
//                    ),
//                  );
//                });
//              },
//            )
//          ],
//        ),
////        ListView.builder(
////            itemCount: custombody_list.length,
////            itemBuilder: (BuildContext context,position){
////              return ListTile(
////                  title: GestureDetector(
////                      onTap: () {},
////                      child: Text(custombody_list[position])));
////            })
//        body: SingleChildScrollView(
//            scrollDirection: Axis.vertical,
//            child: PaginatedDataTable(
//                columns: [
//                  DataColumn(label: Text("Id",style: ColumnStyle(),), numeric: true),
//                  DataColumn(label: Text("User",style: ColumnStyle(),), numeric: true),
//                  DataColumn(label: Text("Title",style: ColumnStyle(),), numeric: false),
//                  DataColumn(label: Text("Date",style: ColumnStyle(),), numeric: false),
//                  DataColumn(label: Text("Time",style: ColumnStyle(),), numeric: false),
//                  DataColumn(label: Text("Status",style: ColumnStyle(),), numeric: false),
//                ],
//                columnSpacing: 10,
//                horizontalMargin: 10,
//                rowsPerPage: no_of_rows,
//                showCheckboxColumn: false,
//                source: MyData(filtereddaily_task_list.reversed.toList(),
//
//                ))));
//  }
//}
//
//class MyData extends DataTableSource {
//  List<DailyTask> filtereddaily_task_list;
//
//  MyData(this.filtereddaily_task_list);
//
////  final List<Map<String, dynamic>> daily_task_data = List.generate(
////    200,
////      (index) => {
////            "id": index,
////            "date": "11-11-22",
////            "name": "Raoabubakar",
////            "phone": "03012323909",
////            "company": "abode",
////            "status": "yes",
////          });
//
//
//  @override
//  bool get isRowCountApproximate => false;
//
//  @override
//  int get rowCount =>
//      filtereddaily_task_list == null ? 0 : filtereddaily_task_list.length;
//
//  @override
//  int get selectedRowCount => 0;
//
//  @override
//  DataRow getRow(int index) {
//    return DataRow.byIndex(
//        index: index,
//        color: MaterialStateProperty.resolveWith<Color>(
//                (Set<MaterialState> states) {
//              if (index % 2 == 0) {
//                return Colors.lightBlueAccent.withOpacity(0.3);
//              } else {
//                return Colors.white60;
//              }
//            }),cells: [
//      DataCell(Text(filtereddaily_task_list[index].id.toString(),style: RowStyle(15.0),)),
//
//      DataCell(Text(filtereddaily_task_list[index].name.toString(),style: RowStyle(15.0),)),
//      DataCell(Container(
//          width: 140,
//          child: Text(filtereddaily_task_list[index].title.toString(),
//            maxLines: 2,style: RowStyle(15.0),))),
//      DataCell(Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: [
//            Text(
//              DateFormat("dd-MM-yyyy")
//                  .format(filtereddaily_task_list[index].date)
//                  .toString(),
//              style: RowStyle(15.0),
//            ),
//            Center(
//              child: Text(
//                DateFormat.Hms()
//                    .format(filtereddaily_task_list[index].date)
//                    .toString(),
//                style: RowStyle(15.0),
//              ),
//            ),
//          ],
//        ),
//      )),
//      DataCell(Text(filtereddaily_task_list[index].end.toString(),style: RowStyle(15.0),)),
//      DataCell(
//        Container(
//          height: 30.0,
//          child: RawMaterialButton(
//
////              onPressed: (){
////                pages().elementAt(_selectedIndex);
////                },
//              elevation: 5.0,
//              child:   Text(filtereddaily_task_list[index].status.toString(),style: TextStyle(
//                  fontSize: 12.0,
//                  fontFamily: "poppins",
//                  fontWeight: FontWeight.w600,
//                  color: Colors.white
//              ),),
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//              fillColor:  parseDailyTaskStatusIntoColor(filtereddaily_task_list[index].status)
////                padding: const EdgeInsets.all(10.0),
//
//          ),
//        ),
//
//      ),
//    ]);
//  }
//}
//

//Appointimport 'package:triple_n/Model/appointments.dart';

//import 'dart:async';
//import 'dart:ui';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:intl/intl.dart';
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/appointments.dart';
//import 'package:triple_n/Service/Viewappointment.dart';
//
//class view_appointments extends StatefulWidget {
//  @override
//  _view_appointmentsState createState() => _view_appointmentsState();
//}
//
//class _view_appointmentsState extends State<view_appointments> {
//  @override
//  final TextEditingController searchtxt = TextEditingController();
//
//  List<Appointment> appointments_list = [];
//  List<Appointment> filteredappointments_list = [];
//
//  Future get_appointment() async {
//    await AppointmentService.appointment().then((appointments) {
//      setState(() {
//        appointments_list = appointments;
//        filteredappointments_list = appointments;
//      });
//    });
//  }
//
//  void initState() {
//    get_appointment();
//    super.initState();
//  }
//
//  Widget showbar = Text(
//    "Appointments",
//    style: TextStyle(
//      fontFamily: "poppins",
//      fontSize: 24.0,
//      color: Colors.white,
//    ),
//  );
//  bool close = true;
//
//  final key = new GlobalKey<PaginatedDataTableState>();
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          toolbarHeight: 90.0,
//          brightness: Brightness.light,
//          backgroundColor: app_color,
//          elevation: 10.0,
//          title: showbar,
//          leading: close == true
//              ? GestureDetector(
//                  onTap: () {
//                    Navigator.pop(context);
//                  },
//                  child: Icon(
//                    Icons.arrow_back_ios,
//                    color: w_color,
//                  ))
//              : GestureDetector(
//                  onTap: () {
//                    Navigator.pop(context);
//                  },
//                  child: Icon(
//                    Icons.arrow_back_ios,
//                    color: w_color,
//                  )),
////          null,
//
//          actions: [
//            close == true
//                ? IconButton(
//                    onPressed: () {
//                      setState(() {
//                        showbar = TextField(
//                          onChanged: (value) {
////                            if (search_list.isNotEmpty) {
//
//                            filteredappointments_list = appointments_list
//                                .where((element) => (element.name
//                                    .toLowerCase()
//                                    .contains(value.toLowerCase())))
//                                .toList();
//                            setState(() {});
//
//                            print(value);
////                                custombody_list = search_list
////                                    .where((string) => string
////                                        .toLowerCase()
////                                        .contains(value.toLowerCase()))
////                                    .toList();
//////                                print(custombody_list);
////                              });
////                            }
////                            else {
////                              print("list is empty");
////                            }
//                          },
//                          controller: searchtxt,
//                          onTap: () {
//                            key.currentState.pageTo(0);
//                          },
//                          decoration: InputDecoration(
//                            contentPadding: EdgeInsets.only(
//                                left: 10.0,
//                                right: 10.0,
//                                top: 10.0,
//                                bottom: 10.0),
//                            isDense: true,
//                            enabledBorder: OutlineInputBorder(
//                              borderSide: const BorderSide(
//                                  color: Colors.white, width: 2.0),
//                              borderRadius: BorderRadius.circular(8.0),
//                            ),
//                            focusedBorder: OutlineInputBorder(
//                              borderSide: const BorderSide(
//                                  color: Colors.white, width: 2.0),
//                              borderRadius: BorderRadius.circular(5.0),
//                            ),
//                            fillColor: w_color,
//                            filled: true,
//                            hintText: 'Search By Name',
//                            hintStyle: TextStyle(
//                              color: Colors.grey,
//                              fontSize: 16,
//                              fontWeight: FontWeight.w500,
//                              fontFamily: "poppins",
////                              fontFamily: "poppins",
//                            ),
//                            border: InputBorder.none,
//                          ),
//                          style: TextStyle(
//                            color: Colors.black,
//                          ),
//                        );
//                        close = false;
//                      });
//                    },
////            showSearch(
////                context: context,
////                delegate: search(search_list));
//
//                    icon: Icon(
//                      Icons.search,
//                      color: w_color,
//                    ),
//                  )
//                : IconButton(
//                    icon: Icon(
//                      Icons.clear,
//                      color: Colors.white,
//                      size: 30.0,
//                    ),
//                    onPressed: () {
//                      setState(() {
//                        close = true;
//                        showbar = Text(
//                          "Appointments",
//                          style: TextStyle(
//                            fontFamily: "poppins",
//                            fontSize: 24.0,
//                            color: Colors.white,
//                          ),
//                        );
//                      });
//                    },
//                  )
//          ],
//        ),
////        ListView.builder(
////            itemCount: custombody_list.length,
////            itemBuilder: (BuildContext context,position){
////              return ListTile(
////                  title: GestureDetector(
////                      onTap: () {},
////                      child: Text(custombody_list[position])));
////            })
//        body: SingleChildScrollView(
//            scrollDirection: Axis.vertical,
//            child: Padding(
//              padding: const EdgeInsets.symmetric(vertical: 10.0),
//              child: PaginatedDataTable(
//                key: key,
//                sortAscending: true,
////                header: Align(
////                  alignment: Alignment.centerLeft,
////                  child: Text(
////                    "Appointments",
////                    style: TextStyle(
////                      fontFamily: "poppins",
////                  fontSize: 24.0,
//////                      fontWeight: FontWeight.w600,
////                      color: Colors.grey,
////                    ),
////                  ),
////                ),
//                columns: [
//                  DataColumn(
//                      label: Text("No",
//                          textAlign: TextAlign.left, style: ColumnStyle()),
//                      numeric: true),
//                  DataColumn(
//                      label: Align(
//                        alignment: Alignment.centerLeft,




//                        child: Text("Date",
//                            textAlign: TextAlign.left, style: ColumnStyle()),
//                      ),
//                      numeric: true),
//                  DataColumn(
//                      label: Text("Name",
//                          textAlign: TextAlign.left, style: ColumnStyle()),
//                      numeric: false),
//                  DataColumn(
//                      label: Text("Phone",
//                          textAlign: TextAlign.left, style: ColumnStyle()),
//                      numeric: false),
//                  DataColumn(
//                      label: Text("Company",
//                          textAlign: TextAlign.left, style: ColumnStyle()),
//                      numeric: false),
//                  DataColumn(
//                      label: Text("Status",
//                          textAlign: TextAlign.left, style: ColumnStyle()),
//                      numeric: false),
//                ],
//
//                columnSpacing: 10,
//                horizontalMargin: 10,
//                rowsPerPage: no_of_rows,
//                showCheckboxColumn: false,
//                source: MyData(filteredappointments_list),
//
////                    rows:
////                    (appointments_list != null && appointments_list.isNotEmpty)
////                        ? appointments_list
////                            .map((e) => DataRow(cells: [
////                                  DataCell(Text(e.date.toString())),
////                                  DataCell(Text(e.name.toString())),
////                                  DataCell(Text(e.phone.toString())),
////                                  DataCell(Text(e.company.toString())),
////                                  DataCell(Text(e.status.toString())),
////                                ]))
////                            .toList()
////                        : []);
//                //run kar
//              ),
//            )));
//  }
//}
//
//class MyData extends DataTableSource {
//  List<Appointment> filteredappointments_list;
//
//  MyData(this.filteredappointments_list);
//
////  final List<Map<String, dynamic>> appointments_data = List.generate(
////    200,
////      (index) => {
////            "id": index,
////            "date": "11-11-22",
////            "name": "Raoabubakar",
////            "phone": "03012323909",
////            "company": "abode",
////            "status": "yes",
////          });
//
//  @override
//  bool get isRowCountApproximate => false;
//
//  @override
//  int get rowCount =>
//      filteredappointments_list == null ? 0 : filteredappointments_list.length;
//
//  @override
//  int get selectedRowCount => 0;
//
//  @override
//  DataRow getRow(int index) {
//    return DataRow.byIndex(
//        index: index,
//        color: MaterialStateProperty.resolveWith<Color>(
//            (Set<MaterialState> states) {
//          if (index % 2 == 0) {
//            return Colors.lightBlueAccent.withOpacity(0.3);
//          } else {
//            return Colors.white60;
//          }
//        }),
//        cells: [
//          DataCell(Text(
//            (index + 1).toString(),
//            style: RowStyle(15.0),
//          )),
//          DataCell(Center(
//              child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: [
//                Text(
//                  DateFormat("dd-MM-yyyy")
//                      .format(DateTime.parse(
//                          filteredappointments_list[index].date))
//                      .toString(),
//                  style: RowStyle(15.0),
//                ),
//                Center(
//                  child: Text(
//                    DateFormat.Hms()
//                        .format(DateTime.parse(
//                            filteredappointments_list[index].date))
//                        .toString(),
//                    style: RowStyle(15.0),
//                  ),
//                ),
//              ]))),
//          DataCell(Container(
//            width: 140.0,
//            child: Text(
//              filteredappointments_list[index].name.toString(),
//              maxLines: 2,
//              style: RowStyle(15.0),
//            ),
//          )),
//          DataCell(Text(
//            filteredappointments_list[index].phone.toString(),
//            style: RowStyle(15.0),
//          )),
//          DataCell(Text(
//            filteredappointments_list[index].company.toString(),
//            style: RowStyle(15.0),
//          )),
//          DataCell(
//            filteredappointments_list[index].status.toString() == "Done"
//                ? Text(
//                    filteredappointments_list[index].status.toString(),
//                    style: RowStyle(15.0),
//                  )
//                : filteredappointments_list[index].status.toString() == "" ? Status.EMPTY
//                    : filteredappointments_list[index].status.toString() ==
//                            "Finished"
//                        ? Status.FINISHED
//                        : filteredappointments_list[index].status.toString() ==
//                                "New"
//                            ? Status.NEW
//                            : filteredappointments_list[index]
//                                        .status
//                                        .toString() ==
//                                    "Not Attended"
//                                ? Status.NOT_ATTENDED
//                                : filteredappointments_list[index]
//                                            .status
//                                            .toString() ==
//                                        "Rescheduled"
//                                    ? Status.RESCHEDULED
//                                    : filteredappointments_list[index]
//                                                .status
//                                                .toString() ==
//                                            "new"
//                                        ? Status.STATUS_NEW
//                                        : Container(
//                                            height: 30.0,
//                                            child: RawMaterialButton(
////              onPressed: (){
////                pages().elementAt(_selectedIndex);
////                },
//                                              elevation: 5.0,
//                                              child: Text(
//                                                filteredappointments_list[index]
//                                                            .status
//                                                            .toString() ==
//                                                        "Status.DONE"
//                                                    ? "Done"
//                                                    : filteredappointments_list[
//                                                                    index]
//                                                                .status
//                                                                .toString() ==
//                                                            "Status.EMPTY"
//                                                        ? "Empty"
//                                                        : filteredappointments_list[
//                                                                        index]
//                                                                    .status
//                                                                    .toString() ==
//                                                                "Status.FINISHED"
//                                                            ? "Finished"
//                                                            : filteredappointments_list[
//                                                                            index]
//                                                                        .status
//                                                                        .toString() ==
//                                                                    "Status.NEW"
//                                                                ? "New"
//                                                                : filteredappointments_list[index]
//                                                                            .status
//                                                                            .toString() ==
//                                                                        " Status.NOT_ATTENDED"
//                                                                    ? "Not Attended"
//                                                                    : filteredappointments_list[index].status.toString() ==
//                                                                            "Status.RESCHEDULED"
//                                                                        ? "Rescheduled"
//                                                                        : filteredappointments_list[index].status.toString() ==
//                                                                                "Status.NEW"
//                                                                            ? "New"
//                                                                            : "Nothing",
//                                                style: TextStyle(
//                                                    fontSize: 12.0,
//                                                    fontFamily: "poppins",
//                                                    fontWeight: FontWeight.w600,
//                                                    color: Colors.white),
//                                              ),
//                                              shape: RoundedRectangleBorder(
//                                                  borderRadius:
//                                                      BorderRadius.circular(
//                                                          10.0)),
//                                              fillColor: filteredappointments_list[
//                                                              index]
//                                                          .status
//                                                          .toString() ==
//                                                      "Status.DONE"
//                                                  ? Color(0xff22D071)
//                                                  : filteredappointments_list[index]
//                                                              .status
//                                                              .toString() ==
//                                                          "Status.EMPTY"
//                                                      ? Color(0xffF04520)
//                                                      : filteredappointments_list[
//                                                                      index]
//                                                                  .status
//                                                                  .toString() ==
//                                                              "Status.FINISHED"
//                                                          ? Color(0xffF5E633)
//                                                          : filteredappointments_list[
//                                                                          index]
//                                                                      .status
//                                                                      .toString() ==
//                                                                  "Status.NEW"
//                                                              ? Color(
//                                                                  0xff00C6F8)
//                                                              : filteredappointments_list[index]
//                                                                          .status
//                                                                          .toString() ==
//                                                                      " Status.NOT_ATTENDED"
//                                                                  ? Color(
//                                                                      0xffE795E7)
//                                                                  : filteredappointments_list[index]
//                                                                              .status
//                                                                              .toString() ==
//                                                                          "Status.RESCHEDULED"
//                                                                      ? Color(
//                                                                          0xffFFA500)
//                                                                      : filteredappointments_list[index].status.toString() ==
//                                                                              "Status.STATUS_NEW"
//                                                                          ? Color(
//                                                                              0xff00C6F8)
//                                                                          : Colors
//                                                                              .white,
//                                              highlightColor: app_color,
////                padding: const EdgeInsets.all(10.0),
//                                            ),
//                                          ),
//          ),
//        ]);
//  }
//}
//
////   DataRow(
////
////   cells: [
////   DataCell(Text(_data[index]["date"].toString())),
////   DataCell(Text(_data[index]["name"].toString())),
////   DataCell(Text(_data[index]["phone"].toString())),
////   DataCell(Text(_data[index]["company"].toString())),
////   DataCell(Text(_data[index]["status"].toString())),
////   ]);
////
////
////
//
////leading: close == true
////? GestureDetector(
////onTap: () {
////Navigator.pop(context);
////},
////child: Icon(
////Icons.arrow_back_ios,
////color: w_color,
////))
////: null,
////actions: [
////close == true
////? IconButton(
////onPressed: () {
////setState(() {
////showbar = TextField(
////onChanged: (value) {
////if (search_list.isNotEmpty) {
////setState(() {
////custombody_list = search_list
////    .where((string) => string
////    .toLowerCase()
////    .contains(value.toLowerCase()))
////    .toList();
//////                                print(custombody_list);
////});
////} else {
//////                              print("list is empty");
////}
////},
////controller: searchtxt,
////decoration: InputDecoration(
////contentPadding: EdgeInsets.only(
////left: 10.0,
////right: 30.0,
////top: 10.0,
////bottom: 10.0),
////isDense: true,
////enabledBorder: OutlineInputBorder(
////borderSide: const BorderSide(
////color: Colors.white, width: 2.0),
////borderRadius: BorderRadius.circular(8.0),
////),
////focusedBorder: OutlineInputBorder(
////borderSide: const BorderSide(
////color: Colors.white, width: 2.0),
////borderRadius: BorderRadius.circular(10.0),
////),
////fillColor: w_color,
////filled: true,
////hintText: 'Search here',
////hintStyle: TextStyle(
////color: Colors.black,
////fontSize: 18,
////fontWeight: FontWeight.w500,
////fontFamily: "poppins",
////),
////border: InputBorder.none,
////),
////style: TextStyle(
////color: Colors.black,
////),
////);
////close = false;
////});
////},



//add_conimport 'package:triple_n/Forms/add_contact.dart';



import 'package:flutter/material.dart';
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/Contact.dart';
//import 'package:triple_n/Service/ViewContact.dart';
//
//
//class view_contact extends StatefulWidget {
//  @override
//  _view_contactState createState() => _view_contactState();
//}
//
//class _view_contactState extends State<view_contact> {
//  @override
//
//
//  List<Contact> contact_list = [];
//  List<Contact> filteredcontact_list = [];
//
//  Future get_contact() async {
//    await ContactService.contact().then((contact) {
//      setState(() {
//        contact_list = contact;
//        filteredcontact_list = contact;
//      });
//    });
//  }
//
//  void initState() {
//    get_contact();
//    super.initState();
//  }
//
//  final TextEditingController searchtxt = TextEditingController();
//
//
//
//  Widget showbar = Text(
//    "Contact Directory",
//    style: TextStyle(
//      fontFamily: "poppins",
//      fontSize: 24.0,
//      color: Colors.white,
//    ),
//  );
//  bool close = true;
//
//
//  final key = new GlobalKey<PaginatedDataTableState>();
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//
//
//      appBar: AppBar(
//        toolbarHeight: 90.0,
//        brightness: Brightness.light,
//        backgroundColor: app_color,
//        elevation: 10.0,
//        title: showbar,
//        leading: close == true
//            ? GestureDetector(
//            onTap: () {
//              Navigator.pop(context);
//
//            },
//            child: Icon(
//              Icons.arrow_back_ios,
//              color: w_color,
//            ))
//            : GestureDetector(
//            onTap: () {
//              Navigator.pop(context);
//            },
//            child: Icon(
//              Icons.arrow_back_ios,
//              color: w_color,
//            )),
//        actions: [
//          close == true
//              ? IconButton(
//            onPressed: () {
//              setState(() {
//                showbar = TextField(
//                  onChanged: (value) {
//                    filteredcontact_list = contact_list
//                        .where((element) => (element.name
//                        .toLowerCase()
//                        .contains(value.toLowerCase())
//                    )).toList();
//                    setState(() {});
//
////                    if (search_list.isNotEmpty) {
////                      setState(() {
////                        custombody_list = search_list
////                            .where((string) => string
////                            .toLowerCase()
////                            .contains(value.toLowerCase()))
////                            .toList();
////                        print(custombody_list);
////                      });
////                    } else {
////                      print("list is empty");
////                    }
//                  },
//                  controller: searchtxt,
//                  onTap: (){
//                    key.currentState.pageTo(0);
//                  },
//                  decoration: InputDecoration(
//                    contentPadding: EdgeInsets.only(left: 10.0,right: 30.0,top: 10.0,bottom: 10.0),
//                    isDense: true,
//                    enabledBorder: OutlineInputBorder(
//                      borderSide: const BorderSide(
//                          color: Colors.white, width: 2.0),
//                      borderRadius: BorderRadius.circular(8.0),
//                    ),
//                    focusedBorder: OutlineInputBorder(
//                      borderSide: const BorderSide(
//                          color: Colors.white, width: 2.0),
//                      borderRadius: BorderRadius.circular(10.0),
//                    ),
//                    fillColor: w_color,
//                    filled: true,
//                    hintText: 'Search by Name' ,
//                    hintStyle: TextStyle(
//                      color: Colors.grey,
//                      fontSize: 16,
//                      fontWeight: FontWeight.w500,
//                      fontFamily: "poppins",
//                    ),
//                    border: InputBorder.none,
//                  ),
//                  style: TextStyle(
//                    color: Colors.black,
//                  ),
//                );
//                close = false;
//              });
//            },
////            showSearch(
////                context: context,
////                delegate: search(search_list));
//
//            icon: Icon(
//              Icons.search,
//              color: w_color,
//            ),
//          )
//              : IconButton(
//            icon:Icon(Icons.clear,color: Colors.white,size: 33.0,),
//
//            onPressed: () {
//              setState(() {
//                close = true;
//                showbar = Text(
//                  "Contact Directory",
//                  style: TextStyle(
//                    fontFamily: "poppins",
//                    fontSize: 24.0,
//                    color: Colors.white,
//                  ),
//                );
//              });
//            },
//          )
//        ],
//      ),
//
//
//        body: SingleChildScrollView(
//          scrollDirection: Axis.vertical,
//          child: PaginatedDataTable(
//            key: key,
//            columns: [
//
//              DataColumn(
//                  label: Text("Id",
//                      textAlign: TextAlign.left,
//                      style: ColumnStyle()
//                  ), numeric: true),
//              DataColumn(label: Text("Name",  textAlign: TextAlign.left,
//                  style: ColumnStyle()), numeric: false),
//              DataColumn(label: Text("Business",  textAlign: TextAlign.left,
//                  style: ColumnStyle()), numeric: false),
//              DataColumn(label: Text("Phone",  textAlign: TextAlign.left,
//                  style: ColumnStyle()), numeric: false),
//              DataColumn(label: Text("Email",  textAlign: TextAlign.left,
//                  style: ColumnStyle()), numeric: false),
//              DataColumn(label: Text("city",  textAlign: TextAlign.left,
//                  style: ColumnStyle()), numeric: false),
//
//            ],
//            columnSpacing: 10,
//            horizontalMargin: 10,
//            rowsPerPage: no_of_rows,
//
//            showCheckboxColumn: false,
//            source:MyData(filteredcontact_list.reversed.toList()),
//          ),
//        )
//    );
//  }
//}
//
//class MyData extends DataTableSource {
//
//  List<Contact> filteredcontact_list;
//
//  MyData(this.filteredcontact_list);
//
//
////  final List<Map<String, dynamic>> _data = List.generate(
////      200,
////          (index) => {
////            "id": index,
////            "name": "afzal",
////            "business": "Irs balancce",
////            "phone": "03012323909",
////            "email": "afzal@abconline.us",
////            "city": "brooklyn",
////      });
//
//  @override
//  bool get isRowCountApproximate => false;
//  @override
//  int get rowCount => filteredcontact_list == null ? 0 : filteredcontact_list.length;
//  @override
//  int get selectedRowCount => 0;
//  @override
//  DataRow getRow(int index) {
//    return DataRow.byIndex(
//        index: index,
//        color: MaterialStateProperty.resolveWith<Color>(
//                (Set<MaterialState> states) {
//              if (index % 2 == 0) {
//                return Colors.lightBlueAccent.withOpacity(0.3);
//              } else {
//                return Colors.white60;
//              }
//            }),
//        cells: [
//          DataCell(Text(filteredcontact_list[index].id.toString(),style: RowStyle(15.0),)),
//      DataCell(Text(filteredcontact_list[index].name.toString(),style: RowStyle(15.0),)),
//      DataCell(Text(filteredcontact_list[index].business.toString(),style: RowStyle(15.0),)),
//      DataCell(Text(filteredcontact_list[index].phone.toString(),style: RowStyle(15.0),)),
//      DataCell(Text(filteredcontact_list[index].email.toString(),style: RowStyle(15.0),)),
//      DataCell(Text(filteredcontact_list[index].city.toString(),style: RowStyle(15.0),)),
//    ]);
//
//  }
//}





//coooperation




import 'package:flutter/material.dart';
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/cooperation.dart';
//import 'package:triple_n/Service/Cooperation.dart';
//
//class view_coperation extends StatefulWidget {
//  @override
//  _view_coperationState createState() => _view_coperationState();
//}
//
//class _view_coperationState extends State<view_coperation> {
//  @override
//  final TextEditingController searchtxt = TextEditingController();
//  Widget showbar = Text(
//    "Cooperations",
//    style: TextStyle(
//      fontFamily: "poppins",
//      fontSize: 24.0,
//      color: Colors.white,
//    ),
//  );
//  bool close = true;
//
//
//  List<Cooperation> cooperation_list = [];
//  List<Cooperation> filteredcooperation_list = [];
//
//  Future get_cooperation() async {
//    await CooperationService.cooperation().then((cooperation) {
//      setState(() {
//        cooperation_list = cooperation;
//        filteredcooperation_list = cooperation;
//      });
//    });
//  }
//
//  void initState() {
//    get_cooperation();
//    super.initState();
//  }
//
//  ColumnStyle() {
//    return TextStyle(
//      fontFamily: "poppins",
//      fontWeight: FontWeight.w500,
//      color: Colors.grey,
//    );
//  }
//  final key = new GlobalKey<PaginatedDataTableState>();
//
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//
//      appBar: AppBar(
//        toolbarHeight: 90.0,
//        brightness: Brightness.light,
//        backgroundColor: app_color,
//        elevation: 10.0,
//        title: showbar,
//        leading: close == true
//            ? GestureDetector(
//            onTap: () {
//              Navigator.pop(context);
//            },
//            child: Icon(
//              Icons.arrow_back_ios,
//              color: w_color,
//            ))
//            : null,
//        actions: [
//          close == true
//              ? IconButton(
//            onPressed: () {
//              setState(() {
//                showbar = TextField(
//                  onChanged: (value) {
//
//
//                    filteredcooperation_list = cooperation_list
//                        .where((element) => (element.companyTitle
//                        .toLowerCase()
//                        .contains(value.toLowerCase())
//                    )).toList();
//                    setState(() {});
//
//
////                    if (search_list.isNotEmpty) {
////                      setState(() {
////                        custombody_list = search_list
////                            .where((string) => string
////                            .toLowerCase()
////                            .contains(value.toLowerCase()))
////                            .toList();
////                        print(custombody_list);
////                      });
////                    } else {
////                      print("list is empty");
////                    }
//                  },
//                  controller: searchtxt,
//                  onTap: (){
//                    key.currentState.pageTo(0);
//                  },
//                  decoration: InputDecoration(
//                    contentPadding: EdgeInsets.only(left: 10.0,right: 30.0,top: 10.0,bottom: 10.0),
//                    isDense: true,
//                    enabledBorder: OutlineInputBorder(
//                      borderSide: const BorderSide(
//                          color: Colors.white, width: 2.0),
//                      borderRadius: BorderRadius.circular(8.0),
//                    ),
//                    focusedBorder: OutlineInputBorder(
//                      borderSide: const BorderSide(
//                          color: Colors.white, width: 2.0),
//                      borderRadius: BorderRadius.circular(10.0),
//                    ),
//                    fillColor: w_color,
//                    filled: true,
//                    hintText: 'Search By Company Name',
//                    hintStyle: TextStyle(
//                      color: Colors.grey,
//                      fontSize: 16,
//                      fontWeight: FontWeight.w500,
//                      fontFamily: "poppins",
//                    ),
//                    border: InputBorder.none,
//                  ),
//                  style: TextStyle(
//                    color: Colors.black,
//                  ),
//                );
//                close = false;
//              });
//            },
////            showSearch(
////                context: context,
////                delegate: search(search_list));
//
//            icon: Icon(
//              Icons.search,
//              color: w_color,
//            ),
//          )
//              : IconButton(
//            icon:Icon(Icons.clear,color: Colors.white,size: 33.0,),
//
//            onPressed: () {
//              setState(() {
//                close = true;
//                showbar = Text(
//                  "Cooperation",
//                  style: TextStyle(
//                    fontFamily: "poppins",
//                    fontSize: 24.0,
//                    color: Colors.white,
//                  ),
//                );
//              });
//            },
//          )
//        ],
//      ),
//
//
//        body: SingleChildScrollView(
//          scrollDirection: Axis.vertical,
//          child: PaginatedDataTable(
//           key: key,
//
//            columns: [
//              DataColumn(label: Text("No",style: ColumnStyle(),), numeric: true),
//              DataColumn(label: Text("Company Name",style: ColumnStyle(),), numeric: false),
//             DataColumn(label: Text("group",style: ColumnStyle(),), numeric: false),
//              DataColumn(label: Text("Client",style: ColumnStyle(),), numeric: false),
//              DataColumn(label: Text("Contact",style: ColumnStyle(),), numeric: false),
//              DataColumn(label: Text("Year End",style: ColumnStyle(),), numeric: false),
////              DataColumn(label: Text("FQ"), numeric: false),
//            ],
//            columnSpacing: 20,
//            horizontalMargin: 10,
//            rowsPerPage: no_of_rows,
//            showCheckboxColumn: false,
//            source:MyData(filteredcooperation_list),
//
//          ),
//        )
//    );
//  }
//}
//
//
//class MyData extends DataTableSource {
//
//  List<Cooperation> filteredcooperation_list;
//
//  MyData(this.filteredcooperation_list);
////  final List<Map<String, dynamic>> _data = List.generate(
////      200,
////          (index) => {
////            "id": index,
////            "companyname": "11-11-22",
////            "group": "11-11-22",
////            "client": "irs balancce",
////            "contact": "arsalan",
////            "yearend": "afzal",
////            "fq": "afzal",
////      });
//
//  @override
//  bool get isRowCountApproximate => false;
//  @override
//  int get rowCount =>     filteredcooperation_list == null ? 0 : filteredcooperation_list.length;
//  @override
//  int get selectedRowCount => 0;
//  @override
//  DataRow getRow(int index) {
//    return DataRow.byIndex(
//      index:index,
//        color: MaterialStateProperty.resolveWith<Color>(
//                (Set<MaterialState> states) {
//              if (index % 2 == 0) {
//                return Colors.lightBlueAccent.withOpacity(0.3);
//              } else {
//                return Colors.white60;
//              }
//            }),
//        cells: [
//      DataCell(Text((index+1).toString(),style: RowStyle(15.0),)),
//      DataCell(Text(filteredcooperation_list[index].companyTitle.toString(),style: RowStyle(15.0),)),
//      DataCell(Text(filteredcooperation_list[index].groupOfCompanies.toString(),style: RowStyle(15.0),)),
//      DataCell(Text(filteredcooperation_list[index].ownerFirstName.toString()+" "+filteredcooperation_list[index].ownerLastName.toString(),style: RowStyle(15.0),)),
//      DataCell(Text(filteredcooperation_list[index].companyContact.toString(),style: RowStyle(15.0),)),
//      DataCell(Text(filteredcooperation_list[index].yearend.toString(),style: RowStyle(15.0),)),
////      DataCell(Text(filteredcooperation_list[index].companyFax.toString())),
//    ]);
//  }
//}




//