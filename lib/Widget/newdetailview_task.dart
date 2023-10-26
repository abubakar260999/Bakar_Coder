//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Widget/daily_task_widget.dart';
//
//
//class detailview_daily_task extends StatefulWidget {
//
//  final String id;
//  final String name;
//
//  final String start;
//  final String end;
//  final DateTime date;
//  final String note;
//  final String title;
//  final String status;
//
//  //if you have multiple values add here
//  detailview_daily_task(
//      this.id,this.name,this.start,this.end,this.date,this.note,this.title,this.status,
//      {Key key}): super(key: key);
//
//  @override
//  _detailview_daily_taskState createState() => _detailview_daily_taskState();
//}
//
//class _detailview_daily_taskState extends State<detailview_daily_task> {
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//      child: Scaffold(
//        body:SingleChildScrollView(
//          child: Padding(
//            padding: const EdgeInsets.all(15.0),
//            child: Material(
//              elevation: 10.0,
//              borderRadius: BorderRadius.circular(15.0),
//              child: Container(
//
//                decoration: BoxDecoration(
////            color: app_color.withOpacity(0.1),
//                  borderRadius: BorderRadius.circular(15.0),
//                ),
//                child: Padding(
//                  padding: const EdgeInsets.only(left: 20.0,right: 10.0,bottom: 10.0,top: 10.0),
//                  child: Column(
//                    children: [
//
//
//                      Align(
//                        alignment: Alignment.topLeft,
//                        child: GestureDetector(
//                          onTap: (){
//                            Get.back();
//                          },
//                          child: Container(
//                            child: Row(
//                              children: [
//                                Icon(Icons.arrow_back_ios_outlined,
//                                  color: app_color,
//                                  size: 20.0,),
//
//                                Text(
//                                  "BACK",
//                                  maxLines: 1,
//                                  overflow: TextOverflow.ellipsis,
//                                  textAlign: TextAlign.left,
//                                  style: RowStyle_app_color(12.0),
//                                ),
//
//                              ],
//                            ),
//                          ),
//                        ),
//                      ),
//
//
//                      SizedBox(
//                        height: 10.0,
//                      ),
//
//
//                      Row(
//                        children: [
//                          Container(
//                            height:20.0,
//                            child:Icon(Icons.label_outline_rounded,
//                              color:app_color,
//                              size: 20.0,),
//                          ),
//
//                          SizedBox(
//                            width: 4.0,
//                          ),
//
//                          Container(
//                            height: 20.0,
//                            child: Text(
//                              widget.id,
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                              textAlign: TextAlign.left,
//                              style: RowStyle_grey(14.0),
//                            ),
//                          ),
//
//                        ],
//                      ),
//
//                      SizedBox(
//                        height: 5.0,
//                      ),
//
//                      detail_subject(context,widget.title),
//
//
//                      SizedBox(
//                        height: 5.0,
//                      ),
//
//                      detail_name(context, widget.name),
//
//
//                      SizedBox(
//                        height: 5.0,
//                      ),
//
//
//
//                      detail_progress(widget.status),
//
//                      SizedBox(
//                        height: 5.0,
//                      ),
//
//                      detail_progress_linear_indicator(widget.status),
//
//
//
//                      SizedBox(
//                        height: 5.0,
//                      ),
//
//                      detail_time(context, widget.start, widget.end),
//
//
//
//                      SizedBox(
//                        height: 5.0,
//                      ),
//
//
//                      detail_date(context, widget.date.toString(),),
//
//
//
//
//                      SizedBox(
//                        height: 5.0,
//                      ),
//
//
//
//
//                      detail_Description(context, widget.note),
//
//                      SizedBox(
//                        height: 5.0,
//                      ),
//
//
//
//
//
//
//
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),
//        ) ,
//      ),
//    );
//
//  }
//}
