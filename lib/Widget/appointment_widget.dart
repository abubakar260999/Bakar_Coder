

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Model/companies.dart';
import 'package:url_launcher/url_launcher.dart';

Companies(context,String company){
  return    Align(
    alignment: Alignment.topLeft,
    child: Container(
      height: 35.0,
      child: Row(
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Icon(Icons.business,
                color: app_color,
                size: 13.0,),
            ),
          ),

          SizedBox(
            width: 2.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 35.0,
              width: MediaQuery.of(context).size.width-133 ,
              child: Text(
                company,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
//                                                textAlign: TextAlign.left,
                style: RowStyle_grey(13.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );

}



name(context,name){
  return       Align(
    alignment: Alignment.topLeft,
    child: Container(
      height: 15.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Icon(CupertinoIcons.person,
              color: app_color,
              size: 15.0,),
          ),
          SizedBox(
            width: 4.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width-140,
              height: 15.0,
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: RowStyle_grey(10.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}



progress(String progress){
  return   Align(
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Container(
          height: 15.0,
          child: Text(
            "Progress",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: RowStyle_grey(10.0),
          ),
        ),
        Spacer(),

        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Container(
            height: 15.0,
            child: Text(
              progress,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: RowStyle_grey(10.0),
            ),
          ),
        ),


      ],
    ),
  );
}

progress_linear_indicator(String value){

  return  Container(
      height: 5,
//                               alignment: Alignment.topCenter,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
      ),
      child: LinearProgressIndicator(
        value: parseAppointmentsPriorityIntoValue(value),
        valueColor:  parseAppointmentsPriorityIntoAnimation(value),
        backgroundColor:   parseAppointmentsPriorityIntoPercentage(value),
      )
  );
}



Description(context,String description){
  return    Align(
    alignment: Alignment.topLeft,
    child: Container(
      height: 15.0,
      child: Row(
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.description,
              color: app_color,
              size: 13.0,),
          ),

          SizedBox(
            width: 4.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 15.0,
              width: MediaQuery.of(context).size.width-140 ,
              child: Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
//                                                textAlign: TextAlign.left,
                style: RowStyle_grey(10.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );

}


time(context,start_time){
  return   Align(
    alignment: Alignment.topLeft,
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 15.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(CupertinoIcons.clock,
                color: app_color,
                size: 13.0,),
            ),
          ),
          SizedBox(
            width: 4.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.32,
              height: 15.0,
              child: Text(
                start_time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: RowStyle_grey(10.0),
              ),
            ),
          ),

        ],
      ),
    ),
  );
}



id(id,bool comment_flag){

  return     Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        height: 15.0,
        child: Row(
          children: [
            Container(
              height:15.0,
              child:Icon(Icons.label_outline_rounded,
                color:app_color,
                size: 15.0,),
            ),

            SizedBox(
              width: 4.0,
            ),


            Container(
              height: 15.0,
              child: Text(
                id,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: RowStyle_grey(10.0),
              ),
            ),

          ],
        ),
      ),
    ),
  );
}



phone(context,phone){
  return   Align(
    alignment: Alignment.topLeft,
    child: GestureDetector(
      onTap: () async {
        Uri url = Uri(scheme: "tel", path: phone);
        if (await canLaunch(url.toString())) {
          await launch(url.toString());
        } else {
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 15.0,
        child: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: MediaQuery.of(context).size.width*0.04,
                child: Icon(CupertinoIcons.phone,
                  color: app_color,
                  size: 13.0,),
              ),
            ),
            SizedBox(
              width: 4.0,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: MediaQuery.of(context).size.width*0.5,
                height: 15.0,
                child: Text(
                  phone,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: RowStyle_appcolor(10.0),
                ),
              ),
            ),

          ],
        ),
      ),
    ),
  );
}




//details

detail_id(context,id){
  return Row(
    children: [
      Container(
        width: MediaQuery.of(context).size.width*0.04,
//        height:20.0,
        child:Icon(Icons.label_outline_rounded,
          color:app_color,
          size: 20.0,),
      ),

      SizedBox(
        width: MediaQuery.of(context).size.width*0.05,
      ),

      Container(
//        height: 20.0,
        child: Text(
          id,
//          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: RowStyle_grey(14.0),
        ),
      ),

    ],
  );
}



detail_companies(context,String company){
  return    Align(
    alignment: Alignment.topLeft,
    child: Container(
//      height: 35.0,
      child: Row(
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.04,
                child: Icon(Icons.business,
                  color: app_color,
                  size: 20.0,),
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width*0.05,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
//              height: 35.0,
  width: MediaQuery.of(context).size.width*0.7,
              child: Text(
                company,
//                maxLines: 2,
//                overflow: TextOverflow.ellipsis,
//                                                textAlign: TextAlign.left,
                style: RowStyle_grey(14.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );

}




detail_name(context,name){
  return       Align(
    alignment: Alignment.topLeft,
    child: Container(
//      height: 15.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(CupertinoIcons.person,
                color: app_color,
                size: 20.0,),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.05,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.7,
//              height: 15.0,
              child: Text(
                name,
//                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
                style: RowStyle_grey(14.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}




detail_progress(String progress){
  return  Align(
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Container(
//          height: 20.0,
          child: Text(
            "Progress",
//            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: RowStyle_grey(14.0),
          ),
        ),
        Spacer(),

        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Container(
//            height: 20.0,
            child: Text(
              progress,
//              maxLines: 1,
//              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: RowStyle_grey(14.0),
            ),
          ),
        ),
      ],
    ),
  );
}




detail_progress_linear_indicator(String value){

  return  Container(
      height: 5.0,
//                               alignment: Alignment.topCenter,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
      ),
      child: LinearProgressIndicator(
        value: parseAppointmentsPriorityIntoValue(value),
        valueColor:  parseAppointmentsPriorityIntoAnimation(value),
        backgroundColor:   parseAppointmentsPriorityIntoPercentage(value),
      )
  );
}



detail_Description(context,String description){
  return    Align(
    alignment: Alignment.topLeft,
    child: Container(

//      height: 15.0,
      child: Row(
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(Icons.description,
                color: app_color,
                size: 20.0,),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width*0.05,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
//              height: 15.0,
              width: MediaQuery.of(context).size.width*0.7,
              child: Text(
                description,
//                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
//                                                textAlign: TextAlign.left,
                style: RowStyle_grey(14.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );

}


detail_time(context,start_time){
  return   Align(
    alignment: Alignment.topLeft,
    child: Container(
      width: MediaQuery.of(context).size.width,
//      height: 15.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(CupertinoIcons.clock,
                color: app_color,
                size: 20.0,),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.05,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.7,
              height: 15.0,
              child: Text(
                start_time,
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
                style: RowStyle_grey(14.0),
              ),
            ),
          ),

        ],
      ),
    ),
  );
}


detail_date(context,start_time){
  return   Align(
    alignment: Alignment.topLeft,
    child: Container(
      width: MediaQuery.of(context).size.width,
//      height: 15.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(CupertinoIcons.calendar,
                color: app_color,
                size: 20.0,),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.05,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.7,
//              height: 15.0,
              child: Text(
                start_time,
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
                style: RowStyle_grey(14.0),
              ),
            ),
          ),

        ],
      ),
    ),
  );
}



detail_phone(context,phone){
  return   Align(
    alignment: Alignment.topLeft,
    child: GestureDetector(
      onTap: () async {
        Uri url = Uri(scheme: "tel", path: phone);
        if (await canLaunch(url.toString())) {
          await launch(url.toString());
        } else {
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
//      height: 15.0,
        child: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: MediaQuery.of(context).size.width*0.04,
                child: Icon(CupertinoIcons.phone,
                  color: app_color,
                  size: 20.0,),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.05,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: MediaQuery.of(context).size.width*0.7,
                height: 15.0,
                child: Text(
                  phone,
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
                  style: RowStyle_appcolor(14.0),
                ),
              ),
            ),

          ],
        ),
      ),
    ),
  );
}