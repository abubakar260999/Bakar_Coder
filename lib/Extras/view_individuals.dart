//import 'package:flutter/material.dart';
//import 'package:triple_n/Global/global.dart';
//
//class view_individuals extends StatefulWidget {
//  @override
//  _view_individualsState createState() => _view_individualsState();
//}
//
//class _view_individualsState extends State<view_individuals> {
//  @override
//  final TextEditingController searchtxt = TextEditingController();
//  Widget showbar = Text("");
//  bool close = true;
//  final search_list = [
//    'Home',
//    'News',
//    'Business',
//    'Technology',
//    'Sports',
//    'Islamic',
//    'Entertainment',
//    'Showbiz',
//    'More',
//    'World'
//  ];
//
//  List<String> custombody_list;
//
//  void initState() {
//    custombody_list = List.from(search_list);
//    super.initState();
//  }
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
//              : null,
//          actions: [
//            close == true
//                ? IconButton(
//                    onPressed: () {
//                      setState(() {
//                        showbar = TextField(
//                          onChanged: (value) {
//                            if (search_list.isNotEmpty) {
//                              setState(() {
//                                custombody_list = search_list
//                                    .where((string) => string
//                                        .toLowerCase()
//                                        .contains(value.toLowerCase()))
//                                    .toList();
//                                print(custombody_list);
//                              });
//                            } else {
//                              print("list is empty");
//                            }
//                          },
//                          controller: searchtxt,
//                          decoration: InputDecoration(
//                            contentPadding: EdgeInsets.only(
//                                left: 10.0,
//                                right: 30.0,
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
//                              borderRadius: BorderRadius.circular(10.0),
//                            ),
//                            fillColor: w_color,
//                            filled: true,
//                            hintText: 'Search here',
//                            hintStyle: TextStyle(
//                              color: Colors.black,
//                              fontSize: 18,
//                              fontWeight: FontWeight.w500,
//                              fontFamily: "poppins",
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
//                      size: 33.0,
//                    ),
//                    onPressed: () {
//                      setState(() {
//                        close = true;
//                        showbar = Text("");
//                      });
//                    },
//                  )
//          ],
//        ),
//        body: SingleChildScrollView(
//          scrollDirection: Axis.vertical,
//          child: PaginatedDataTable(columns: [
//            DataColumn(label: Text("NO"), numeric: true),
//            DataColumn(label: Text("Company Name"), numeric: false),
//            DataColumn(label: Text("group"), numeric: false),
//            DataColumn(label: Text("Client"), numeric: false),
//            DataColumn(label: Text("Contact"), numeric: false),
//            DataColumn(label: Text("Year End"), numeric: false),
//            DataColumn(label: Text("FQ"), numeric: false),
//          ],
//            columnSpacing: 30,
//            horizontalMargin: 10,
//            rowsPerPage: 8,
//            showCheckboxColumn: false,
//            source:MyData(),),
//        ));
//  }
//}
//
//class MyData extends DataTableSource {
//  final List<Map<String, dynamic>> _data = List.generate(
//      200,
//      (index) => {
//            "id": index,
//            "companyname": "11-11-22",
//            "group": "11-11-22",
//            "client": "irs balancce",
//            "contact": "arsalan",
//            "yearend": "afzal",
//            "fq": "afzal",
//          });
//
//  @override
//  bool get isRowCountApproximate => false;
//
//  @override
//  int get rowCount => _data.length;
//
//  @override
//  int get selectedRowCount => 0;
//
//  @override
//  DataRow getRow(int index) {
//    return DataRow(cells: [
//      DataCell(Text(_data[index]['id'].toString())),
//      DataCell(Text(_data[index]["companyname"].toString())),
//      DataCell(Text(_data[index]["group"].toString())),
//      DataCell(Text(_data[index]['client'].toString())),
//      DataCell(Text(_data[index]["contact"].toString())),
//      DataCell(Text(_data[index]["yearend"].toString())),
//      DataCell(Text(_data[index]["fq"].toString())),
//    ]);
//  }
//}






