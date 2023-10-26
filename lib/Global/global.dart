import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triple_n/Forms/add_appointment.dart';
import 'package:triple_n/Ui/home.dart';
import 'package:triple_n/Views/view_appointments.dart';
import 'package:triple_n/Views/view_contact.dart';
import 'package:triple_n/main.dart';
import 'package:url_launcher/url_launcher.dart';
//
//Color blue_color=Color(0xff00C6F8);
Color blue_color =Color(0xffEFEFEF);
Color card_color =null;
Color background_view_color=null;

Color app_color =Color(0xff248AFD);
Color shade =Color(0xff248AFD);
Color in_color =Color(0xff248AFD);
Color w_color =Color(0xffffffff);
Color textcolor1 =Color(0xff000000);
Color grey_color =Colors.grey;

final double card_height=130.0;

TextStyle ColumnStyle(){
  return  TextStyle(
    fontFamily: "poppins",
    fontWeight: FontWeight.w700,
    color: Colors.grey,
  );

}

view_appbar_txt(String txt)
{
 return  Text(
    txt,
    style: TextStyle(
      fontFamily: "poppins",
      fontSize: 20.0,
      color: Colors.white,
    ),
  );

}


TextStyle RowStyle(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "poppins",
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}

TextStyle RowStyle_black(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "poppins",
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}

TextStyle RowStyle_white(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "poppins",
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}


TextStyle RowStyle_black_bold(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "poppins",
    fontWeight: FontWeight.w900,
    color: Colors.black,
  );
}



TextStyle RowStyle_grey(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "poppins",
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
}

TextStyle RowStyle_appcolor(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "poppins",
    fontWeight: FontWeight.w600,
    color: app_color,
  );
}


TextStyle RowStyle_real_grey(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "poppins",
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );
}

TextStyle RowStyle_app_color(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "poppins",
    fontWeight: FontWeight.w600,
    color: app_color,
  );
}

Widget  button(width,double heigth,txt,double size,txt_color,color){
  return Container(
      width: width,
  height: heigth,
  child: RawMaterialButton(
  elevation: 5.0,
  child: Text(
  txt,
    style:txt_color==Colors.white?RowStyle_black(size):RowStyle(size),
  overflow: TextOverflow.ellipsis,
  textAlign: TextAlign.center,
  ),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
  fillColor:color,
  ),
  );
}


Widget priorty_task_button(width,double heigth,txt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      elevation: 5.0,
      child: Text(
        txt,
        style:txt_color=RowStyle_white(size),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      fillColor:color,
    ),
  );
}




Widget  button_moretxt(width,double heigth,txt,moretxt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      elevation: 5.0,
      child: Text(
        moretxt+"\n"+txt,
        style:txt_color==Colors.white?RowStyle_black(size):RowStyle(size),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      fillColor:color,
    ),
  );
}

Widget  date_button(width,double heigth,txt,double size,txt_color,color){
  return Container(

    width: width,
    height: heigth,

    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Icon(Icons.watch_later_outlined,size: 15.0,))),


        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    DateFormat("dd-MM-yyyy").format(txt).toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style:RowStyle_black(size),
//              style: txt_color==Colors.black?RowStyle_black(size):RowStyle(size),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                      child: Text(DateFormat.Hms().format(txt).toString(),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style:RowStyle_black(size),
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}



Widget  assigned_button(width,double heigth,txt_by,txt_to,double size,txt_color,color){
  List<String> result = txt_to.split(',');
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      elevation: 5.0,
      child:  Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 2.0,
            ),
            Align(
              alignment:Alignment.centerLeft,
              child: Text(
                "Assign By",
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 8.0,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 2.0,
            ),

            Text(
             txt_by,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color:Colors.black,
                fontSize: 9.0,
                fontFamily: "poppins",
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(
              height: 2.0,
            ),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Assign TO",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                color:Colors.black,
                fontSize: 8.0,
                fontFamily: "poppins",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

ListView.builder(
  physics: NeverScrollableScrollPhysics(),
  shrinkWrap: true,
    itemCount: result.length<=3?result.length:3,
    itemBuilder: (context,index){
  return   Align(
    alignment: Alignment.centerLeft,
    child: Text(
      result[index],
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.left,
      style: TextStyle(
        color:Colors.black,
        fontSize: 9.0,
        fontFamily: "poppins",
        fontWeight: FontWeight.w400,
      ),
    ),
  );

}),
            SizedBox(
              height: 2.0,
            ),

                  ],
                ),
      ),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      fillColor:blue_color,

    ),
  );
}


Widget  ID_button(width,double heigth,txt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      elevation: 5.0,
      child:  Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Row(

          children: [
            Expanded(
                flex:1,child: Text(
                " "
            )),

            Expanded(
              flex: 2,
              child: Align(
                alignment:Alignment.centerLeft,
                child: Text(
                  "ID",
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color:Colors.black,
                    fontSize: 8.0,
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
                flex:1,child: Text(
                " "
            )),
            Expanded(
              flex: 6,
              child: Text(
                txt,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 8.0,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

          ],
        ),
      ),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      fillColor:blue_color,

    ),
  );
}



parseStatusIntoColor(String status) {
  switch (status) {
    case "Complete":
      return Color(0xff22D071);
    case "Completed":
      return Color(0xff22D071);
    case "Closed":
      return Color(0xff22D071);
    case "Close":
      return Color(0xff22D071);
    case "Not Started":
      return Color(0xffF70000);
    case "not started":
      return Color(0xffF70000);
    case "In Progress":
      return Color(0xffF5E633);
    case "Updated":
    return Color(0xffF5E633);
    case "Continue":
      return Color(0xffF5E633);
    case "Waiting for Reply":
      return Color(0xff00C6F8);
    case "Under Review":
      return Color(0xff00C6F8);
    case "Waiting":
      return Color(0xff00C6F8);
    case "Waiting for Someone":
      return Color(0xff00C6F8);
    case "Overdue":
      return Color(0xffF70000);
    case "Not Started(Overdue)":
      return Color(0xffF70000);
    default:
      return Color(0xffF5E633);
  }
}

parseStatusAnimationIntoColor(String status) {
  switch (status) {
  case "Complete":
  return AlwaysStoppedAnimation<Color>(Color(0xff22D071));
    case "Completed":
      return AlwaysStoppedAnimation<Color>(Color(0xff22D071));
  case "Closed":
  return AlwaysStoppedAnimation<Color>(Color(0xff22D071));
  case "Close":
  return AlwaysStoppedAnimation<Color>( Color(0xff22D071));
  case "Not Started":
  return AlwaysStoppedAnimation<Color>(Color(0xffF70000));
    case "not started":
      return AlwaysStoppedAnimation<Color>(Color(0xffF70000));
    case "Updated":
    return AlwaysStoppedAnimation<Color>(Color(0xffF5E633));
    case "Continue":
      return AlwaysStoppedAnimation<Color>(Color(0xffF5E633));
  case "In Progress":
  return AlwaysStoppedAnimation<Color>(Color(0xffF5E633));
    case "Under Review":
      return AlwaysStoppedAnimation<Color>( Color(0xff00C6F8));
    case "Waiting":
    return AlwaysStoppedAnimation<Color>( Color(0xff00C6F8));
  case "Waiting for Reply":
  return AlwaysStoppedAnimation<Color>( Color(0xff00C6F8));
  case "Waiting for Someone":
  return AlwaysStoppedAnimation<Color>( Color(0xff00C6F8));
  case "Overdue":
  return AlwaysStoppedAnimation<Color>( Color(0xffF70000));
  case "Not Started(Overdue)":
  return AlwaysStoppedAnimation<Color>( Color(0xffF70000));
  default:
  return AlwaysStoppedAnimation<Color>( Color(0xffF5E633));

  }
}

parseStatusindicatorvalue(String status) {
  switch (status) {
    case "Complete":
      return 1.0;
    case "Complete":
    return 1.0;
    case "Continue":
      return 0.3;
    case "Not Started":
      return 0.1;
    case "In Progress":
      return 0.7;
    case "Waiting for Reply":
      return 0.5;
    case "":
      return 0.5;
    default:
      return 0.5;
  }
}


parseStatusIntoOpacityColorandpercentage(String status) {
  switch (status) {
    case "Complete":
      return Color(0xff22D071).withOpacity(0.3);
    case "Completed":
      return Color(0xff22D071).withOpacity(0.3);
    case "Closed":
      return Color(0xff22D071).withOpacity(0.3);
    case "Close":
      return Color(0xff22D071).withOpacity(0.3);
    case "Not Started":
      return Color(0xffF70000).withOpacity(0.3);
    case "not started":
      return Color(0xffF70000).withOpacity(0.3);
    case "In Progress":
      return Color(0xffF5E633).withOpacity(0.3);
    case "Updated":
      return Color(0xffF5E633).withOpacity(0.3);
    case "Waiting for Reply":
      return Color(0xff00C6F8).withOpacity(0.3);
    case "Under Review":
      return Color(0xff00C6F8).withOpacity(0.3);
    case "Waiting":
      return Color(0xff00C6F8).withOpacity(0.3);
    case "Waiting for Someone":
      return Color(0xff00C6F8).withOpacity(0.3);
    case "Overdue":
      return Color(0xffF70000).withOpacity(0.3);
    case "Not Started(Overdue)":
      return Color(0xffF70000).withOpacity(0.3);
    default:
      return Color(0xffF5E633).withOpacity(0.3);
  }
}


parsePriorityIntoColor(String priority) {
  switch (priority) {
    case "High":
      return Color(0xffEE0033);//high
    case "high":
      return Color(0xffEE0033);//h
    case "Medium"://medium
    return Color(0xff22D071);
    case "Low"://low
      return Color(0xff00C6F8);

    default:
      return Color(0xffF5E633);
  }
}


//daiy status

parseDailyTaskStatusIntoColor(String status) {
  switch (status) {
    case "Completed":
      return  Color(0xff22D071);
    case "Continue":
      return Color(0xff00C6F8);
    case "":
      return Color(0xffF5E633);
    default:
      return Color(0xffF5E633);
  }
}


//appointments

parseAppointmentsPriorityIntoText(String priority) {
  switch (priority) {
    case "Status.FINISHED":
      return "Finished";
    case "Status.DONE":
      return "Done";
    case "Status.EMPTY":
    return "Empty";
    case "Status.NOT_ATTENDED":
      return "Not Attented";
    case "Status.RESCHEDULED":
      return "New";
    default:
      return "Nothing";
  }
}



parseAppointmentsPriorityIntocolor(String priority) {
  switch (priority) {
    case "Status.FINISHED":
      return  Color(0xff22D071);
    case "Status.DONE":
      return  Color(0xff22D071);
    case "Status.EMPTY":
      return Color(0xffF70000);
    case "Status.NOT_ATTENDED":
      return Color(0xff00C6F8);
    case "Status.RESCHEDULED":
      return Color(0xffF5E633);
    default:
      return Color(0xffE795E7);
  }
}



parseAppointmentsPriorityIntoAnimation(String priority) {
  switch (priority) {
    case "Status.FINISHED":
      return AlwaysStoppedAnimation<Color>( Color(0xff22D071));
    case "Status.DONE":
      return AlwaysStoppedAnimation<Color>( Color(0xff22D071));
    case "Status.EMPTY":
      return AlwaysStoppedAnimation<Color>(Color(0xffF70000));
    case "Status.NOT_ATTENDED":
      return AlwaysStoppedAnimation<Color>(Color(0xff00C6F8));
    case "Status.RESCHEDULED":
      return AlwaysStoppedAnimation<Color>(Color(0xffF5E633));
    default:
      return AlwaysStoppedAnimation<Color>(Color(0xffE795E7));
  }
}


parseAppointmentsPriorityIntoValue(String priority) {
  switch (priority) {
    case "Status.FINISHED":
      return  1.0;
    case "Status.DONE":
      return  1.0;
    case "Status.EMPTY":
      return 0.2;
    case "Status.NOT_ATTENDED":
      return 0.1;
    case "Status.RESCHEDULED":
      return 0.5;
    default:
      return 0.5;
  }
}



parseAppointmentsPriorityIntoPercentage(String priority) {
  switch (priority) {
    case "Status.FINISHED":
      return  Color(0xff22D071).withOpacity(0.3);
    case "Status.DONE":
      return  Color(0xff22D071).withOpacity(0.3);
    case "Status.EMPTY":
      return Color(0xffF70000).withOpacity(0.3);
    case "Status.NOT_ATTENDED":
      return Color(0xff00C6F8).withOpacity(0.3);
    case "Status.RESCHEDULED":
      return Color(0xffF5E633).withOpacity(0.3);
    default:
      return Color(0xffE795E7).withOpacity(0.3);
  }
}



//call  directory


parseDailyCallsStatusIntoColor(String status) {
  switch (status) {
    case "Incoming":
      return  Color(0xff22D071);
    case "Outgoing":
      return Color(0xff00C6F8);
    default:
      return Color(0xffF5E633);
  }
}



//view_appointments



Widget  time_button(width,double heigth,txt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      child: Row(

        children: [
          Expanded(
              flex:1,child: Text(
              " "
          )),

          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Icon(Icons.watch_later_outlined,size: 10.0,),
              )),

          Expanded(
              flex:1,child: Text(
            " "
          )),
          Expanded(
            flex: 6,
            child: Text(
             txt,
              overflow: TextOverflow.ellipsis,
              style:RowStyle_black(size),
//              style: txt_color==Colors.black?RowStyle_black(size):RowStyle(size),
            ),
          ),
        ],
      ),
      fillColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

    ),
  );
}
Widget  app_date_button(width,double heigth,txt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex:1,child: Text(
              " "
          )),

          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Icon(Icons.calendar_today_outlined,size: 10.0,),
              )),

          Expanded(
              flex:1,child: Text(
              " "
          )),
          Expanded(
            flex: 6,
            child: Text(
              txt,
              maxLines: 2,

              overflow: TextOverflow.ellipsis,
              style:RowStyle_black(size),
//              style: txt_color==Colors.black?RowStyle_black(size):RowStyle(size),
            ),
          ),
        ],
      ),
      fillColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

    ),
  );
}
Widget phone_button(width,double heigth,txt,double size,txt_color,color){
  return GestureDetector(
    onTap: () async {
      Uri url = Uri(scheme: "tel", path: txt);
      if (await canLaunch(url.toString())) {
        await launch(url.toString());
      } else {
      }
    },
    child: Container(
      width: width,
      height: heigth,
      child: RawMaterialButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex:1,child: Text(
                " "
            )),

            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Icon(Icons.phone_outlined,size: 10.0,color: app_color,),
                )),

            Expanded(
                flex:1,child: Text(
                " "
            )),
            Expanded(
              flex: 6,
              child: Text(
                txt,
                maxLines: 2,

                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: size,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w500,
                  color: app_color,
                )
//              style: txt_color==Colors.black?RowStyle_black(size):RowStyle(size),
              ),
            ),
          ],
        ),
        fillColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

      ),
    ),
  );
}


Widget  name_button(width,double heigth,txt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      elevation: 5.0,
      child: Text(
        txt,
        style:txt_color==Colors.white?RowStyle_black(size):RowStyle(size),
        maxLines: 4,

        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      fillColor:color,
    ),
  );
}

Widget email_button(width,double heigth,txt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//          Expanded(
//              flex:1,child: Text(
//              " "
//          )),

          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Icon(Icons.email_outlined,size: 10.0,),
              )),

//          Expanded(
//              flex:1,child: Text(
//              " "
//          )),
          Expanded(
            flex: 6,
            child: Text(
              txt,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:RowStyle_black(size),
//              style: txt_color==Colors.black?RowStyle_black(size):RowStyle(size),
            ),
          ),
        ],
      ),
      fillColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

    ),
  );
}


Widget  cooperation_name_button(width,double heigth,txt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      elevation: 5.0,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          txt,
          style:txt_color==Colors.white?RowStyle_black(size):RowStyle(size),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      fillColor:color,
    ),
  );
}


Widget cooperation_file_button(width,double heigth,txt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex:2,child: Text(
              " "
          )),

          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Icon(Icons.file_copy_outlined,size: 10.0,),
              )),

          Expanded(
              flex:2,child: Text(
              " "
          )),


          Expanded(
            flex: 6,
            child: Text(
              txt,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:RowStyle_black(size),
//              style: txt_color==Colors.black?RowStyle_black(size):RowStyle(size),
            ),
          ),
        ],
      ),
      fillColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

    ),
  );
}

//call s

Widget  calls_assigned_button(width,double heigth,txt_by,txt_to,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      elevation: 5.0,
      child:  Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 4.0,
            ),
            Align(
              alignment:Alignment.centerLeft,
              child: Text(
                "Attended By",
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 8.0,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 2.0,
            ),

            Text(
              txt_by,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color:Colors.black,
                fontSize: 10.0,
                fontFamily: "poppins",
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(
              height: 4.0,
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Call For",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 8.0,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text(
              txt_to,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color:Colors.black,
                fontSize: 10.0,
                fontFamily: "poppins",
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
          ],
        ),
      ),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      fillColor:blue_color,

    ),
  );
}




//back button


Back_button(color) {
  return GestureDetector(
    onTap: () {
      Get.back();
    },

    child: Padding(
      padding: const EdgeInsets.only(left: 4.0,top: 10.0,bottom: 10.0),
      child: Material(
        elevation: 10.0,
        borderRadius: BorderRadius.circular(10.0),

        child: Container(
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: app_color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_back_ios
                    , color: color,
                    size: 15.0,
                  ),
                ),

                Expanded(
                    flex: 1,
                    child: Text("")
                ),


                Expanded(
                  flex: 8,
                  child: Container(
                    child: Text("Back",
                      style: TextStyle(
                          color: color,
                          fontFamily: "poppins",
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}






Widget  individuals_address_button(width,double heigth,txt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          txt,
          style:txt_color==Colors.white?RowStyle_black(size):RowStyle(size),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      fillColor:color,
    ),
  );
}




Widget individuals_date_button(width,double heigth,txt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
//          Expanded(
//              flex:1,child: Text(
//              " "
//          )),

          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Icon(Icons.watch_later_outlined,size: 10.0,),
              )),

//          Expanded(
//              flex:1,child: Text(
//              " "
//          )),
          Expanded(
            flex: 6,
            child: Text(
              txt,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:RowStyle_black(size),
//              style: txt_color==Colors.black?RowStyle_black(size):RowStyle(size),
            ),
          ),
        ],
      ),
      fillColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),

    ),
  );
}








Widget  call_type_button(width,double heigth,txt,double size,txt_color,color){
  return Container(
    width: width,
    height: heigth,
    child: RawMaterialButton(
      elevation: 5.0,
      child: Text(
        txt,
        style:txt_color==Colors.white?RowStyle_white(size):RowStyle(size),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      fillColor:color,
    ),
  );
}




home_button(context){
  return  new FloatingActionButton(
    onPressed: (){
      Navigator.pop(context);
    },
    backgroundColor: app_color,
    child: const Icon(Icons.home,
      color: Colors.white,
    ),
  );
}