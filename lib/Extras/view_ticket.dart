//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/task_manager.dart';
//import 'package:triple_n/Model/users.dart';
//import 'package:triple_n/Service/Task_manager.dart';
//import 'package:triple_n/Service/Users.dart';
//import 'package:triple_n/Service/user_data.dart';
//
//
//
//class view_task extends StatefulWidget {
//  @override
//  _view_taskState createState() => _view_taskState();
//}
//
//class _view_taskState extends State<view_task> {
//  @override
//
//
//
//  final TextEditingController searchtxt = TextEditingController();
//  Widget  showbar = Text(
//    "Tickets",
//    style: TextStyle(
//      fontFamily: "poppins",
//      fontSize: 24.0,
//      color: Colors.white,
//    ),
//  );
//  bool close = true;
//  bool refresher=false;
//
//  List<TaskManager> task_manager_list = [];
//  List<TaskManager> filteredtask_manager_list = [];
//
//  Future get_appointment() async {
//    await Task_Manager_Service.task_manager().then((task_manager) {
//      setState(() {
//        task_manager_list = task_manager;
//        filteredtask_manager_list = task_manager;
//      });
//    });
//  }
//
//  void initState() {
//    get_appointment();
//    super.initState();
//  }
//  final key = new GlobalKey<PaginatedDataTableState>();
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//
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
//
//            close == true
//                ? IconButton(
//              onPressed: () {
//
//
//                setState(() {
//                  refresher=true;
////                key.currentState.pageTo(0);
//                  showbar = TextField(
//                    onChanged: (value) {
//
//                      filteredtask_manager_list = task_manager_list
//                          .where((element) => (element.subject
//                          .toLowerCase()
//                          .contains(value.toLowerCase())
//                      )).toList();
//                      setState(() {});
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
//                    },
//                    onTap: (){
//                      key.currentState.pageTo(0);
//                    },
//                    controller: searchtxt,
//                    decoration: InputDecoration(
//                      contentPadding: EdgeInsets.only(left: 10.0,right: 30.0,top: 10.0,bottom: 10.0),
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
//                      hintText: 'Search By Subject',
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
//                  close = false;
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
//              icon:Icon(Icons.clear,color: Colors.white,size: 33.0,),
//
//              onPressed: () {
//                setState(() {
//                  close = true;
//                  showbar = Text(
//                    "Tickets",
//                    style: TextStyle(
//                      fontFamily: "poppins",
//                      fontSize: 24.0,
//                      color: Colors.white,
//                    ),
//                  );
//                  refresher=false;
//                });
//              },
//            )
//          ],
//        ),
//
//
//        body: SingleChildScrollView(
//          scrollDirection: Axis.vertical,
//          child: Theme(
//            data: ThemeData(cardColor: Theme.of(context).cardColor, textTheme: TextTheme(caption: TextStyle(color: Colors.grey,fontSize: 12.0,fontWeight: FontWeight.w500,fontFamily: "poppins",))),
//            child: PaginatedDataTable(
//              key: key,
//              sortAscending: false,
//
//              columns: [
//                DataColumn(label: Text("Id",style: ColumnStyle(),), numeric: true),
//                DataColumn(label: Text("Status",style: ColumnStyle(),), numeric: false),
//                DataColumn(label: Text("Subject",style: ColumnStyle(),), numeric: false),
//                DataColumn(label: Text("Deadline",style: ColumnStyle(),), numeric: false),
//                DataColumn(label: Text("Assigned date",style: ColumnStyle(),), numeric: false),
//                DataColumn(label: Text("Assign by",style: ColumnStyle(),), numeric: false),
//                DataColumn(label: Text("Assign to",style: ColumnStyle(),), numeric: false),
////              DataColumn(label: Text("Forwarded to"), numeric: false),
//                DataColumn(label: Text("Priorty",style: ColumnStyle(),), numeric: false),
//              ],
//              columnSpacing: 20,
//              horizontalMargin: 10,
//              rowsPerPage: no_of_rows,
//              showCheckboxColumn: false,
//              source:MyData(filteredtask_manager_list.reversed.toList()),
//
//            ),
//          ),
//        )
//    );
//  }
//}
//
//class MyData extends DataTableSource {
//
//  Future<Widget> username(user_id) async{
//    return FutureBuilder<String>(
//        future: Users_data.users(user_id),
//        builder:(context,snapshot)
//        {
//          var ids=int.parse(user_id);
//          if(snapshot.hasData){
//            return Text(snapshot.data);
//          }
//          else{
//            Text("raooaoao");
//          }
//        }
//    );
//  }
//
//  List<TaskManager> filteredtask_manager_list;
//
//  MyData(this.filteredtask_manager_list);
//
////  final List<Map<String, dynamic>> _data = List.generate(
////      200,
////          (index) => {
////            "id": index,
////            "assign": "11-11-22",
////            "deadline": "11-11-22",
////            "subject": "irs balancce",
////            "assignby":"arsalan",
////            "assignto":"afzal",
////            "forwardedto": "afzal",
////            "status": "Incoming",
////            "priorty":"high",
////      });
//
//
//  @override
//  bool get isRowCountApproximate => false;
//  @override
//  int get rowCount =>    filteredtask_manager_list == null ? 0 : filteredtask_manager_list.length;
//  @override
//  int get selectedRowCount => 0;
//  @override
//  DataRow getRow(int index) {
//    return DataRow.byIndex(
//        index:index,
////        color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
////          if (filteredtask_manager_list[index].status.toString() ==
////              "Complete") {
////            return Colors.lightGreenAccent;
////          }
////          else if (filteredtask_manager_list[index].status.toString() ==
////          "Not Started") {
////            return Colors.redAccent;
////          }
////          else if (filteredtask_manager_list[index].status.toString() ==
////              "In Progress") {
////            return Colors.yellowAccent;
////          }
////          else if (filteredtask_manager_list[index].status.toString() ==
////              "Waiting for Reply") {
////            return Colors.purpleAccent;
////          }
////        }),
//        cells: [
//          DataCell(Text(filteredtask_manager_list[index].id.toString(),style: RowStyle(),),),
//
//    DataCell(
//    Container(
//    height: 30.0,
//    child: RawMaterialButton(
//
////              onPressed: (){
////                pages().elementAt(_selectedIndex);
////                },
//    elevation: 5.0,
//    child:   Text(filteredtask_manager_list[index].status.toString(),style: TextStyle(
//    fontSize: 12.0,
//    fontFamily: "poppins",
//    fontWeight: FontWeight.w600,
//    color: Colors.white
//    ),),
//    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//    fillColor:  (filteredtask_manager_list[index].status.toString() ==
//    "Complete") ?
//    Color(0xff22D071)
//        :
//    (filteredtask_manager_list[index].status.toString() ==
//    "Not Started") ?
//    Color(0xffF5E633)
//        :
//    (filteredtask_manager_list[index].status.toString() ==
//    "In Progress") ?
//    Color(0xffFFA500)
//        :
//    (filteredtask_manager_list[index]
//
//        .status.toString() ==
//    "Waiting for Reply")?
//    Color(0xff00C6F8):
//    Colors.white,
//    highlightColor: app_color,
////                padding: const EdgeInsets.all(10.0),
//    ),
//            ),
//          ),
//          DataCell(Container(
//            width: 140,
//            child: Text(filteredtask_manager_list[index].subject.toString(),
//              maxLines: 2,
//              style: RowStyle(),),
//          )),
//
//
//          DataCell(Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: [
//              Text(DateFormat("dd-MM-yyyy").format(filteredtask_manager_list[index].deadline).toString(),style: RowStyle(),),
//              Center(child: Text(DateFormat.Hms().format(filteredtask_manager_list[index].deadline).toString(),style: RowStyle(),)),
//            ],
//          )),
//          DataCell(Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: [
//              Text(DateFormat("dd-MM-yyyy").format(filteredtask_manager_list[index].date).toString(),style: RowStyle(),),
//              Center(child: Text(DateFormat.Hms().format(filteredtask_manager_list[index].date).toString(),style: RowStyle(),)),
//            ],
//          )),
//
////          filteredtask_manager_list[index].assignBy.toString()
//          DataCell(Text(filteredtask_manager_list[index].name1.toString(),style: RowStyle(),)),
//          DataCell(Text(filteredtask_manager_list[index].name2.toString(),style: RowStyle(),)),
////      DataCell(Text(filteredtask_manager_list[index].forward.toString())),
//          DataCell(
//            Container(
//              height: 30.0,
//              child: RawMaterialButton(
//
////              onPressed: (){
////                pages().elementAt(_selectedIndex);
////                },
//                elevation: 5.0,
//                child:   Text(filteredtask_manager_list[index].priority.toString(),style: TextStyle(
//                    fontSize: 12.0,
//                    fontFamily: "poppins",
//                    fontWeight: FontWeight.w600,
//                    color: Colors.white
//                ),),
//                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//                fillColor:  (filteredtask_manager_list[index].priority.toString() ==
//                    "High") ?
//                Color(0xff22D071)
//                    :
//                (filteredtask_manager_list[index].priority.toString() ==
//                    "Medium") ?
//                Color(0xff00C6F8) :
//                (filteredtask_manager_list[index].priority.toString() ==
//                    "Low") ?
//                Color(0xffE795E7) :
//                Colors.white,
//                highlightColor: app_color,
////                padding: const EdgeInsets.all(10.0),
//
//              ),
//            ),
//
//
////          Text(filteredtask_manager_list[index].priority.toString(),style: RowStyle(),)
//          ),
//        ]);
//  }
//}
//
