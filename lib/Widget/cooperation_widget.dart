

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
                style: RowStyle_grey(13.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );

}



owner_name(context,name){
  return       Align(
    alignment: Alignment.topLeft,
    child: Container(
      height: 15.0,
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


group_of_company(context,String company){
  return    Align(
    alignment: Alignment.topLeft,
    child: Container(
      height: 15.0,
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
            width: 4.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 15.0,
              width: MediaQuery.of(context).size.width-140 ,
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
      height: 15.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(Icons.location_city,
                color: app_color,
                size: 13.0,),
            ),
          ),
          SizedBox(
            width: 4,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width-140 ,
              height: 15.0,
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
      height: 15.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(Icons.email_outlined,
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
              width: MediaQuery.of(context).size.width-140 ,
              height: 15.0,
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
                width: MediaQuery.of(context).size.width-140 ,
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



yearend(context,phone){
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
              child: Icon(CupertinoIcons.calendar,
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
              width: MediaQuery.of(context).size.width-140 ,
              height: 15.0,
              child: Text(
                phone,
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






detail_company(context,name){
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
              child: Icon(Icons.business,
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


detail_fax(context,fax){
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
              child: Icon(Icons.contact_phone_outlined,
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
                fax,
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



detail_ein(context,ein){
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
              width: MediaQuery.of(context).size.width*0.25,
//              height: 15.0,
              child: Text(
                "Ein",
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
                style: RowStyle_app_color(14.0),
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width*0.05,
          ),



          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.3,
//              height: 15.0,
              child: Text(
                ein,
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


detail_other_cooperation(context,heading,txt){
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
              child: Icon(Icons.business,
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
              width: MediaQuery.of(context).size.width*0.25,
//              height: 15.0,
              child: Text(
                heading,
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
                style: RowStyle_app_color(14.0),
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width*0.05,
          ),



          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.3,
//              height: 15.0,
              child: Text(
                txt,
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


detail_company_website(context,heading,txt){
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
              child: Icon(Icons.web,
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
              width: MediaQuery.of(context).size.width*0.25,
//              height: 15.0,
              child: Text(
                heading,
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
                style: RowStyle_app_color(14.0),
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width*0.05,
          ),



          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.3,
//              height: 15.0,
              child: Text(
                txt,
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


detail_other_cooperation_date(context,heading,txt){
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
              width: MediaQuery.of(context).size.width*0.25,
//              height: 15.0,
              child: Text(
                heading,
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
                style: RowStyle_app_color(14.0),
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width*0.05,
          ),



          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.3,
//              height: 15.0,
              child: Text(
                txt,
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



detail_created_by_name(context,txt){
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
              child: Icon(Icons.business,
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
              width: MediaQuery.of(context).size.width*0.25,
//              height: 15.0,
              child: Text(
               "Created by",
//                  maxLines: 1,
//                  overflow: TextOverflow.ellipsis,
                style: RowStyle_app_color(14.0),
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width*0.05,
          ),



          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.3,
//              height: 15.0,
              child: Text(
                txt,
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