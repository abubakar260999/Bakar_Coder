import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Views/view_appointments.dart';
import 'package:triple_n/Views/view_call.dart';
import 'package:triple_n/Views/view_contact.dart';
import 'package:triple_n/Views/view_daily_task.dart';
import 'package:triple_n/Views/view_task.dart';

class custom_appbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  var address;
   custom_appbar(
    this.title,
      this.address,{
    Key key,
  }) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100.0);

  List pages=[
    view_task(),
    view_daily_task(),
    view_appointments(),
    view_call(),
    view_contact(),
  ];

  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
      ),
      brightness: Brightness.light,
      leadingWidth: 70.0,
      backgroundColor: app_color,
      centerTitle: true,
      elevation: 10.0,
      leading:Back_button(Colors.white),

        actions: [
        GestureDetector(
        onTap: () {
       Get.to(pages[address]);
    },

    child: Padding(
      padding: const EdgeInsets.only(right: 10.0,top: 10.0,bottom: 10.0),
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),

        child: Container(
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: app_color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Expanded(
            flex: 8,
            child: Container(
            child: Text("View",
            style: TextStyle(
            color: Colors.white,
            fontFamily: "poppins",
            fontWeight: FontWeight.w700,
            fontSize: 16.0
            ),
            ),
            ),
            ),



              Expanded(
                flex: 1,
                child: Icon(Icons.arrow_forward_ios
                  , color: Colors.white,
                  size: 15.0,
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Text("")
              ),



            ],
            ),
          ),
        ),
      ),
    ),
    )
      ],
    );
  }
}

//Padding(
//padding: const EdgeInsets.all(5.0),
//child: Card(
//elevation: 5.0,
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.all(Radius.circular(10.0)),
//),
//child: GestureDetector(
//onTap: () {
//Navigator.pop(context);
//},
//child: Icon(
//Icons.arrow_back_ios,
//color: app_color,
//))),
//),