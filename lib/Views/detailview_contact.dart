import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Widget/contact_widget.dart';
import 'package:triple_n/Widget/global_button.dart';

class detailview_contact extends StatefulWidget {
  @override

  final String id;
  final String name;
  final String businessname;
  final String email;
  final String city;
  final String moible;
  final String phone;
   final String image1;
   final String image2;
  //if you have multiple values add here
  detailview_contact(
      this.id,
      this.name,
      this.businessname,
      this.email,
      this.city,
      this.moible,
      this.phone,
      this.image1,
      this.image2,

      {Key key}): super(key: key);
  _detailview_contactState createState() => _detailview_contactState();
}

class _detailview_contactState extends State<detailview_contact> {
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


                      detail_business_name(context,widget.businessname),


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

                      detail_city(context,widget.city),

                      SizedBox(
                        height: 5.0,
                      ),

                      detail_phone(context,widget.moible),

                      SizedBox(
                        height: 5.0,
                      ),

                      detail_phone(context,widget.phone),


                      SizedBox(
                        height: 10.0,
                      ),

                      detail_image(context,widget.image1,widget.image2),

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
//return SafeArea(
//      child: Scaffold(
//
//          appBar: AppBar(
//            toolbarHeight: 70.0,
//            backgroundColor: Colors.white,
////        elevation: 6.0,
//            leading: Back_button(Colors.black),
//
//            title:Text("Contact",style: RowStyle_black(20.0),),
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
//
//                Divider(),
//
//
//                ListTile(
//                  leading: Text("Owner Name",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.name,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.person_outline,size: 20.0,),
//                ),
//
//
//                Divider(),
//                ListTile(
//                  leading: Text("Business Name",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.businessname,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.business,size: 20.0,),
//                ),
//                Divider(),
//                ListTile(
//                  leading: Text("Email",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.email,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.mail_outline,size: 20.0,),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text("City",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.city,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.location_city_outlined,size: 20.0,),
//                ),
//                Divider(),
//                ListTile(
//                  leading: Text("Mobile Number",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.moible,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.mobile_screen_share_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text("Phone Number",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.phone,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.phone_outlined,size: 20.0,),
//                ),
//                Divider(),
//                ListTile(
//                  leading: Text("Front Side",style: RowStyle_black_bold(12.0),),
//                  title:     ClipRRect(
//                    borderRadius: BorderRadius.circular(10.0),
//                    child: FadeInImage(
//                      height: 280,
//                      width: MediaQuery.of(context).size.width*0.45,
//                      image: NetworkImage(http_root+contact_image_path+widget.image1),
//                      placeholder: AssetImage("Assets/hover.gif",),
//                      imageErrorBuilder: (context, error, stackTrace) {
//                        return Image.asset(
//                            'Assets/hover.gif',
//                            height: 280,
//                            width: MediaQuery.of(context).size.width*0.45,
//                            fit: BoxFit.fitWidth);
//                      },
//                      fit: BoxFit.fitWidth,
//                    ),
//                  ),
//
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text("Back Side",style: RowStyle_black_bold(12.0),),
//                  title:     ClipRRect(
//                    borderRadius: BorderRadius.circular(10.0),
//                    child: FadeInImage(
//                      height: 280,
//                      width: MediaQuery.of(context).size.width*0.45,
//                      image: NetworkImage(http_root+contact_image_path+widget.image2),
//                      placeholder: AssetImage("Assets/hover.gif",),
//                      imageErrorBuilder: (context, error, stackTrace) {
//                        return Image.asset(
//                            'Assets/hover.gif',
//                            height: 280,
//                            width: MediaQuery.of(context).size.width*0.45,
//                            fit: BoxFit.fitWidth);
//                      },
//                      fit: BoxFit.fitWidth,
//                    ),
//                  ),
//
//                ),
//
//Divider(),
//
//
//              ],
//
//            ),
//          ),
//
//
//      ),
//    );