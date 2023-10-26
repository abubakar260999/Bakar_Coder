

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Model/companies.dart';
import 'package:url_launcher/url_launcher.dart';

Company_title(context,company){
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
                style: RowStyle_grey(10.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );

}


bar(color){
  return Column(
    children: [
      Align(
        alignment: Alignment.center,
        child: Container(
          height: 5,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color:color,
          ),
        ),
      ),


    ],
  );
}


owner_name(context,name){
  return       Align(
    alignment: Alignment.topLeft,
    child: Container(
      height: 20.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Icon(CupertinoIcons.person,
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
              width: MediaQuery.of(context).size.width-140,
              height: 20.0,
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: RowStyle_grey(13.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


group_of_company(context,String company){
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


city(context,city){
  return   Align(
    alignment: Alignment.topLeft,
    child: Container(
      width: MediaQuery.of(context).size.width,
//      height: 20.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(Icons.location_city,
                color: app_color,
                size: 18.0,),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.02,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.32,
//              height: 20.0,
              child: Text(
                city,
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



email(context,email){
  return   Align(
    alignment: Alignment.topLeft,
    child: Container(
      width: MediaQuery.of(context).size.width,
//      height: 20.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(Icons.email_outlined,
                color: app_color,
                size: 18.0,),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.02,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.32,
//              height: 20.0,
              child: Text(
                email,
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
//      height: 20.0,
        child: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: MediaQuery.of(context).size.width*0.04,
                child: Icon(CupertinoIcons.phone,
                  color: app_color,
                  size: 18.0,),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.02,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: MediaQuery.of(context).size.width*0.5,
//              height: 20.0,
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



status(status){
  return   Align(
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Container(
          height: 15.0,
          child: Text(
            "Status",
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
              status,
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





detail_email(context,String email){
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
              child: Icon(Icons.mail_outline,
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
                email,
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


detail_city(context,city){
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
              child: Icon(Icons.location_city,
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
                city,
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


detail_state(context,state){
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
              child: Icon(Icons.location_city,
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
              child: Text(
                state,
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

detail_address(context,address){
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
              child: Icon(Icons.location_history_outlined,
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
                address,
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
//              height: 15.0,
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


detail_zip(context,zip){
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
              child: Icon(Icons.code,
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
                zip,
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


detail_dob(context,phone){
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
              child: Icon(Icons.calendar_today,
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
//              height  : 15.0,
              child: Text(
                phone,
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



detail_status(context,status){
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
              child: Icon(Icons.person_outline_outlined,
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
                status,
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



detail_type(context,type){
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
              child: Icon(Icons.person_outline_outlined,
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
                type,
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