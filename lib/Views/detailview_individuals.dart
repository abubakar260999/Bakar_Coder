
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Widget/global_button.dart';
import 'package:triple_n/Widget/individual_widget.dart';

class detailview_individuals extends StatefulWidget {
  @override
  final String id;
  final String zip;
  final String dob;
  final String name;
  final String city;
  final String address;
  final String state;
  final String ssn;
  final String telephone;
  final String email;
  final String spouse_first_name;
  final String spouse_last_name;
  final String spouse_ssn;
  final String spouse_dob;
  final String status;
  final String type;


  detailview_individuals(
      this.id,
this.zip,
this.dob,
      this.name,
      this.city,
      this.address,
      this.state,
      this.ssn,
      this.telephone,
      this.email,
      this.spouse_first_name,
      this.spouse_last_name,
      this.spouse_ssn,
      this.spouse_dob,
      this.status,
      this.type,
      {Key key}): super(key: key);

  _detailview_individualsState createState() => _detailview_individualsState();
}

class _detailview_individualsState extends State<detailview_individuals> {
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


                      detail_name(context,widget.name),


                      SizedBox(
                        height: 5.0,
                      ),


                      detail_email(context,widget.email),

                      SizedBox(
                        height: 5.0,
                      ),


                      detail_phone(context,widget.telephone),


                      SizedBox(
                        height: 5.0,
                      ),


                      detail_phone(context,widget.ssn),

                      SizedBox(
                        height: 5.0,
                      ),



                      detail_city(context,widget.city),

                      SizedBox(
                        height: 5.0,
                      ),

                      detail_state(context,widget.state),

                      SizedBox(
                        height: 5.0,
                      ),

                      detail_address(context,widget.address),

                      SizedBox(
                        height: 5.0,
                      ),


                      detail_zip(context,widget.zip),

                                       SizedBox(
                        height: 5.0,
                      ),

                      detail_dob(context,widget.dob),


                      SizedBox(
                        height: 5.0,
                      ),

                      detail_status(context,widget.status),


                      SizedBox(
                        height: 5.0,
                      ),

                      detail_type(context,widget.type),

                      SizedBox(
                        height: 6.0,
                      ),

                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.4,
//                          height: 15.0,
                          child: Text(
                           "Spouse",
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
                            style: RowStyle_app_color(16.0),
                          ),
                        ),
                      ),



                      SizedBox(
                        height: 6.0,
                      ),
                      //spouse

                      detail_name(context,widget.spouse_first_name+" "+widget.spouse_last_name),

                      SizedBox(
                        height: 5.0,
                      ),

                      detail_dob(context,widget.spouse_dob),

                      SizedBox(
                        height: 5.0,
                      ),

                      detail_phone(context,widget.spouse_ssn),





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
//  return SafeArea(
//      child: Scaffold(
//          appBar: AppBar(
//            toolbarHeight: 70.0,
//            backgroundColor: Colors.white,
////        elevation: 6.0,
//            leading: Back_button(Colors.black),
//
//            title:Text("Individuals",style: RowStyle_black(20.0),),
//            centerTitle: true,
//
//          ),
//
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
//
//
//                ListTile(
//                  leading: Text("Name",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.name,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.person_outline,size: 20.0,),
//                ),
//                Divider(),
//
//
//                ListTile(
//                  leading: Text("Date of birth",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.dob,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.calendar_today_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text("Email",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.email,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.mail_outline,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Contact",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.telephone,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.phone_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Contact",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.ssn,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.phone_outlined,size: 20.0,),
//                ),
//
//
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Address",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.address,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.location_history_outlined,size: 20.0,),
//                ),
//
//
//
//                Divider(),
//
//
//                ListTile(
//                  leading: Text("State",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.state,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.location_city,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Zip",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.zip,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.code_sharp,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Status",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.status,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.person_outline_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Type",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.type,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.person_outline_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//
//
//                ListTile(
//                  leading: Text("Spouse Name",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.spouse_first_name+""+widget.spouse_first_name,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.person_outline_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//
//                ListTile(
//                  leading: Text("Spouse Dob",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.spouse_dob,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.calendar_today_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//
//                ListTile(
//                  leading: Text("Spouse Ssn",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.spouse_ssn,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.phone_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//              ],
//            ),
//          )
//
//      ),
//    );