import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Widget/call_widget.dart';
import 'package:triple_n/Widget/global_button.dart';

class detailview_call extends StatefulWidget {
  @override
  final String id;
  final String attender_name;
  final String call_for_name;
  final String type;
  final String subject;
  final String business_name;
  final String date;
  final String time;
  final String phone;
  final String phone2;
  //if you have multiple values add here
  detailview_call(
      this.id,this.attender_name,this.call_for_name,this.type,this.subject,this.business_name,this.date,this.time,this.phone,this.phone2,
      {Key key}): super(key: key);
  _detailview_callState createState() => _detailview_callState();
}

class _detailview_callState extends State<detailview_call> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
//            color: app_color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0,top: 10.0),
                  child: Column(
                    children: [

                      detail_back(),

                      SizedBox(
                        height: 10.0,
                      ),


                      detail_id(context,widget.id,widget.type),


                      SizedBox(
                        height: 5.0,
                      ),


                      detail_business_name(context,widget.business_name),


                      SizedBox(
                        height: 5.0,
                      ),

                      detail_subject(context,widget.subject),


                      SizedBox(
                        height: 5.0,
                      ),


                      detail_name(context, widget.call_for_name),

                      SizedBox(
                        height: 5.0,
                      ),

                      detail_name(context, widget.attender_name),

                      SizedBox(
                        height: 5.0,
                      ),



                      detail_date(context,widget.date),

                      SizedBox(
                        height: 5.0,
                      ),

                      detail_time(context,widget.time),

                      SizedBox(
                        height: 5.0,
                      ),

                      detail_phone(context,widget.phone),



                      SizedBox(
                        height: 5.0,
                      ),


                      detail_phone(context,widget.phone2),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ) ,
      ),
    );
  }
}
// return SafeArea(
//      child: Scaffold(
//        appBar: AppBar(
//          toolbarHeight: 70.0,
//          backgroundColor: Colors.white,
////        elevation: 6.0,
//          leading: Back_button(Colors.black),
//
//          title:Text("Call Detail",style: RowStyle_black(20.0),),
//          centerTitle: true,
//
//        ),
//
//          body:Padding(
//            padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0,top: 20.0),
//            child: ListView(
//              children: [
//
//                ListTile(
//                  leading: Text("Id",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.id,style: RowStyle_black(12.0),)),
//                  trailing: Icon(CupertinoIcons.number,size: 20.0,),
//                ),
//                Divider(),
//                ListTile(
//                  leading: Text("Subject", style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.subject,textAlign: TextAlign.center,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.subject,size: 20.0,),
//                ),
//                Divider(),
//                ListTile(
//                  leading: Text("Business Name",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.business_name,textAlign:TextAlign.center,style: RowStyle_black(12.0),)),
//                  trailing: Icon(CupertinoIcons.building_2_fill,size: 20.0,),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text("Attender",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.attender_name,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.person_outline,size: 20.0,),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text("Call For",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.call_for_name,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.person_outline,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Data and Time",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.date + "   " +widget.time,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.access_time,size: 20.0,),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text("Type",style: RowStyle_black_bold(12.0)),
//                  title: Center(child: Text(widget.type,style: RowStyle_black(12.0),)),
//                  trailing: Container(
//                    height: 20,width:20,
//                    color: parseDailyCallsStatusIntoColor(widget.type),
//                  ),
//                ),
//                Divider(),
//                ListTile(
//                  leading: Text("Phone",style: RowStyle_black_bold(12.0)),
//                  title: Center(child: Text(widget.phone,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.phone_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//
//              ],
//            ),
//          )
//      ),
//    );