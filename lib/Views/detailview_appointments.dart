import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Widget/appointment_widget.dart';
import 'package:triple_n/Widget/global_button.dart';

class detailview_appointments extends StatefulWidget {
  @override
  final String id;
  final String company;
  final String description;
  final String name;
  final String date;
  final String time;
  final String status;
  final String phone;
  //if you have multiple values add here
  detailview_appointments(
this.id,this.company,this.description,this.name,this.date,this.time,this.status,this.phone,
      {Key key}): super(key: key);
  _detailview_appointmentsState createState() => _detailview_appointmentsState();
}

class _detailview_appointmentsState extends State<detailview_appointments> {
  @override

  Widget build(BuildContext context) {
    String date= DateFormat("dd-MM-yyyy").format(DateTime.parse(widget.date)).toString();
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
                  padding: const EdgeInsets.only(left: 20.0,right: 10.0,bottom: 10.0,top: 10.0),
                  child: Column(
                    children: [

                    detail_back(),

                      SizedBox(
                        height: 10.0,
                      ),


                    detail_id(context,widget.id),


                      SizedBox(
                        height: 5.0,
                      ),


                      detail_companies(context,widget.company),


                      SizedBox(
                        height: 5.0,
                      ),
                      detail_progress(parseAppointmentsPriorityIntoText(widget.status)),

                      SizedBox(
                        height: 5.0,
                      ),

                      detail_progress_linear_indicator(widget.status),
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

                      detail_Description(context,widget.description),

                      SizedBox(
                        height: 5.0,
                      )



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
//SafeArea(
//      child: Scaffold(
//          appBar: AppBar(
//            toolbarHeight: 70.0,
//            backgroundColor: Colors.white,
////        elevation: 6.0,
//            leading: Back_button(Colors.black),
//
//            title:Text("Appointment",style: RowStyle_black(20.0),),
//            centerTitle: true,
//
//          ),
//
//          backgroundColor: Colors.white,
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
//                  leading: Text("Comapny Name",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.company,textAlign: TextAlign.center,style: RowStyle_black(12.0),)),
//                  trailing: Icon(CupertinoIcons.building_2_fill,size: 20.0,),
//                ),
//                Divider(),
//                ListTile(
//                  leading: Text("Description",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.description,textAlign:TextAlign.center,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.description_outlined,size: 20.0,),
//                ),
//                Divider(),
//
//                ListTile(
//                  leading: Text("Name (For)",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.name,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.person_outline,size: 20.0,),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text("Data and Time",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(date + "   " +widget.time,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.access_time,size: 20.0,),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text("Status",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(parseAppointmentsPriorityIntoText(widget.status),style: RowStyle_black(12.0),)),
//                  trailing: Container(
//                    height: 20,width:20,
//                    color: parseAppointmentsPriorityIntocolor(widget.status),
//                  ),
//                ),
//                Divider(),
//              ],
//            ),
//          )
//      ),
//    );