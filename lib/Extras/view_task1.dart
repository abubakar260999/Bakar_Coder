//import 'dart:async';
//
//import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//import 'package:intl/intl.dart';
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/task_manager.dart';
//import 'package:triple_n/Pagination_Controller/tickets_controller.dart';
//
//class ViewTask extends StatefulWidget {
//  @override
//  _ViewTaskState createState() => _ViewTaskState();
//}
//
//class _ViewTaskState extends State<ViewTask> {
//  var format = DateFormat("dd-MM-yyyy");
//  var get_controller = Get.put(paging_controller());
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: PagedListView<int, TaskManager>(
//        scrollController: get_controller.scrollController,
//        pagingController: get_controller.pagingController,
//        builderDelegate: PagedChildBuilderDelegate<TaskManager>(
//          itemBuilder: listItem,
//        ),
//      ),
//      floatingActionButton: Obx(
//            () =>
//        get_controller.showBackToTopButton == false
//            ? Container()
//            : FloatingActionButton(
//          onPressed: get_controller.scrollToTop,
//          child: const Icon(Icons.arrow_upward),
//        ),
//      ),
//    );
//  }
//
//  Widget listItem(BuildContext context, TaskManager item, int index) {
//    return Container(
//      width: MediaQuery
//          .of(context)
//          .size
//          .width,
//      height: 200,
//      child: Padding(
//        padding: const EdgeInsets.all(10.0),
//        child: Row(
//          children: [
//            Column(
//              children: [
//                Text(
//                  item.id.toString(),
//                  style: RowStyle(),
//                ),
//                Container(
//                  width: 100,
//                  height: 60,
//                  child: Text(
//                    item.subject.toString(),
//                    maxLines: 2,
//                    overflow: TextOverflow.ellipsis,
//                    style: RowStyle(),
//                  ),
//                ),
//                Row(
//                  children: [
//                    Text(
//                      item.name1.toString(),
//                      style: RowStyle(),
//                    ),
//                    Text(
//                      "To",
//                      maxLines: 1,
//                      overflow: TextOverflow.ellipsis,
//                      style: RowStyle(),
//                    ),
//                    Text(
//                      item.name2.toString(),
//                      style: RowStyle(),
//                    ),
//                  ],
//                ),
//                Row(
//                  children: [
//                    Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: [
//                        Text(
//                          format.format(item.date).toString(),
//                          style: RowStyle(),
//                        ),
//                        Center(
//                            child: Text(
//                              DateFormat.Hms().format(item.date).toString(),
//                              style: RowStyle(),
//                            )),
//                      ],
//                    ),
//                    Text(
//                      "To",
//                      maxLines: 1,
//                      overflow: TextOverflow.ellipsis,
//                      style: RowStyle(),
//                    ),
//                    Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: [
//                        Text(
//                          format.format(item.deadline).toString(),
//                          style: RowStyle(),
//                        ),
//                        Center(
//                            child: Text(
//                              DateFormat.Hms().format(item.deadline).toString(),
//                              style: RowStyle(),
//                            )),
//                      ],
//                    ),
//                  ],
//                )
//              ],
//            ),
//            Column(
//              children: [
//                Container(
//                  width: MediaQuery
//                      .of(context)
//                      .size
//                      .width * 0.4,
//                  height: 30.0,
//                  child: RawMaterialButton(
////              onPressed: (){
////                pages().elementAt(_selectedIndex);
////                },
//                    elevation: 5.0,
//                    child: Text(
//                      item.status.toString(),
//                      style: TextStyle(
//                          fontSize: 12.0,
//                          fontFamily: "poppins",
//                          fontWeight: FontWeight.w600,
//                          color: Colors.white),
//                    ),
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10.0)),
//                    fillColor: parseStatusIntoColor(item.status),
//                    highlightColor: app_color,
//                    onPressed: () {},
////                padding: const EdgeInsets.all(10.0),
//                  ),
//                ),
//                Container(
//                  width: MediaQuery
//                      .of(context)
//                      .size
//                      .width * 0.4,
//                  height: 30.0,
//                  child: RawMaterialButton(
////              onPressed: (){
////                pages().elementAt(_selectedIndex);
////                },
//                    elevation: 5.0,
//                    child: Text(
//                      item.priority.toString(),
//                      style: TextStyle(
//                          fontSize: 12.0,
//                          fontFamily: "poppins",
//                          fontWeight: FontWeight.w600,
//                          color: Colors.white),
//                    ),
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10.0)),
//                    fillColor: parsePriorityIntoColor(item.priority),
//                    highlightColor: app_color,
//                    onPressed: () {},
//                  ),
//                ),
//              ],
//            )
//          ],
//        ),
//      ),
//    );
//  }
//
//  parseStatusIntoColor(String status) {
//    switch (status) {
//      case "Complete":
//        return Color(0xff22D071);
//      case "Not Started":
//        return Color(0xffF5E633);
//      case "In Progress":
//        return Color(0xffFFA500);
//      case "Waiting for Reply":
//        return Color(0xff00C6F8);
//      default:
//        return Colors.white;
//    }
//  }
//
//  parsePriorityIntoColor(String priority) {
//    switch (priority) {
//      case "High":
//        return Color(0xff22D071);
//      case "Medium":
//        return Color(0xff00C6F8);
//      case "Low":
//        return Color(0xffE795E7);
//      default:
//        return Color(0xffF5E633);
//    }
////  }
//  }
//}