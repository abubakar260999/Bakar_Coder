

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Model/companies.dart';
import 'package:url_launcher/url_launcher.dart';

business_name(context,String company){
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
            width: 4.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 35.0,
              width: MediaQuery.of(context).size.width-140 ,
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
              size: 13.0,),
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



Description(context,String description){
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
              child: Icon(Icons.description,
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
              height:15.0,
              width: MediaQuery.of(context).size.width-133 ,
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
              width: MediaQuery.of(context).size.width*0.32,
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
            width:4,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.32,
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
                size: 13.0,),
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



detail_business_name(context,String company){
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




detail_city(context,start_time){
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


detail_email(context,start_time){
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
              child: Icon(Icons.email_outlined,
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


detail_camera(context,text){
  return   Align(
    alignment: Alignment.topLeft,
    child: Container(
      width: MediaQuery.of(context).size.width*0.3,
//      height: 15.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(CupertinoIcons.camera,
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
              width: MediaQuery.of(context).size.width*0.2,
//              height: 15.0,
              child: Text(
                text,
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



detail_image(context,image1,image2){
  return   Align(
    alignment: Alignment.center,
    child: Container(
      width: MediaQuery.of(context).size.width,
//      height: 15.0,
      child: Center(
        child: Column(
          children: [

           Row(
             children: [
               detail_camera(context,"Front"),

               Spacer(),

               detail_camera(context,"Back"),

             ],
           ),


            SizedBox(
              height: 5.0,
            ),

            Row(
              children: [

              ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: FadeInImage(
                            height: 200,
                            width: MediaQuery.of(context).size.width*0.35,
                            image: NetworkImage(http_root+contact_image_path+image1),
                            placeholder: AssetImage("Assets/hover.gif",),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  'Assets/hover.gif',
                                  height: 200,
                                  width: MediaQuery.of(context).size.width*0.35,
                                  fit: BoxFit.fitWidth);
                            },
                            fit: BoxFit.fitWidth,
                          ),
                        ),


              Spacer(),


    ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: FadeInImage(
                            height: 200,
                            width: MediaQuery.of(context).size.width*0.35,
                            image: NetworkImage(http_root+contact_image_path+image2),
                            placeholder: AssetImage("Assets/hover.gif",),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  'Assets/hover.gif',
                                  height: 200,
                                  width: MediaQuery.of(context).size.width*0.35,
                                  fit: BoxFit.fitWidth);
                            },
                            fit: BoxFit.fitWidth,
                          ),
                        ),

                SizedBox(width: 10.0,),

              ],
            ),
          ],
        ),
      ),
    ),
  );
}