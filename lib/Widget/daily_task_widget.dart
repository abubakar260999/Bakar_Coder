import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triple_n/Global/global.dart';

title(context,String subject){
  return  Align(
    alignment: Alignment.topLeft,
    child: Container(
      height: 35.0,
      child: Row(
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Icon(Icons.subject_outlined,
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
                subject,
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


note(context,String description){
  return    Align(
    alignment: Alignment.topLeft,
    child: Container(
      height: 25.0,
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
            width: 2.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 25.0,
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



Assigned_by(context,name2) {
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      height: 20.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Icon(CupertinoIcons.person,
              color: app_color,
              size: 15.0,),
          ),
          SizedBox(
            width: 2.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 140,
              height: 20.0,
              child: Text(
                name2,
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




bar(){
  return Column(
    children: [
      Align(
        alignment: Alignment.center,
        child: Container(
          height: 3,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: app_color,
          ),
        ),
      ),


    ],
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
      height: 5.0,
//                               alignment: Alignment.topCenter,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
      ),
      child: LinearProgressIndicator(
        value: parseStatusindicatorvalue(value),
        valueColor: parseStatusAnimationIntoColor(value),
        backgroundColor:  parseStatusIntoOpacityColorandpercentage(value),
      )
  );
}



commented_and_id(id,bool comment_flag){

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

            Spacer(),

            Visibility(
              visible: comment_flag,
              child: Container(
                height:15.0,
                decoration: BoxDecoration(
                  color: app_color,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child:Icon(Icons.done,
                  color:Colors.white,
                  size: 15.0,),
              ),
            ),

            Visibility(
              visible: comment_flag,
              child: SizedBox(
                width: 4.0,
              ),
            ),

            Visibility(
              visible: comment_flag,
              child: Container(
                height: 15.0,
                child: Text(
                  "Commented",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: RowStyle_grey(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}







daily_task_time(context,start_time,end_time) {
  return Align(
    alignment: Alignment.topLeft,
    child: Container(
      height: 20.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.access_time_sharp,
              color: app_color,
              size: 15.0,),
          ),
          SizedBox(
            width: 2.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width*0.2,
//              width: 100,
//              width: MediaQuery
//                  .of(context)
//                  .size
//                  .width - 140/3,
              height: 20.0,
              child: Text(
                start_time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: RowStyle_grey(10.0),
              ),
            ),
          ),

//             SizedBox(
//            width: 10.0,
//          ),

        Spacer(),

          Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.access_time_sharp,
              color: app_color,
              size: 15.0,),
          ),
          SizedBox(
            width: 2.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
//              width: 100,
              width: MediaQuery
                  .of(context)
                  .size
                  .width*0.2,
              height: 20.0,
              child: Text(
                end_time,
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




//detailview Widget

detail_subject(context,String subject){
  return    Align(
    alignment: Alignment.topLeft,
    child: Container(
//      height: 35.0,
      width: MediaQuery.of(context).size.width*0.76,
      child: Row(
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.04,
                child: Icon(Icons.subject_outlined,
                  color: app_color,
                  size: 20.0,),
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width*0.02,
//            width: 2.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
//              height: 35.0,
              width: MediaQuery.of(context).size.width*0.7 ,
              child: Text(
                subject,
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



detail_progress_linear_indicator(String value){

  return  Container(
      height: 8.0,
//                               alignment: Alignment.topCenter,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
      ),
      child: LinearProgressIndicator(
        value: parseStatusindicatorvalue(value),
        valueColor: parseStatusAnimationIntoColor(value),
        backgroundColor:  parseStatusIntoOpacityColorandpercentage(value),
      )
  );
}

detail_progress(String progress){
  return  Align(
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Container(
          height: 20.0,
          child: Text(
            "Progress",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: RowStyle_grey(12.0),
          ),
        ),
        Spacer(),

        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Container(
            height: 20.0,
            child: Text(
              progress,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: RowStyle_grey(12.0),
            ),
          ),
        ),
      ],
    ),
  );
}





detail_date(context,value){
  return   Align(
    alignment: Alignment.topLeft,
    child: Container(
      width: MediaQuery.of(context).size.width*0.38,
//      height: 20.0,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(CupertinoIcons.calendar,
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
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: RowStyle_grey(12.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


detail_Description(context,String description){
  return    Align(
    alignment: Alignment.topLeft,
    child: Container(
//      height: 25.0,
      width: MediaQuery.of(context).size.width*0.76,
      child: Row(
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.04,
                child: Icon(Icons.description,
                  color: app_color,
                  size: 18.0,),
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width*0.02,
//            width: 2.0,
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Container(
//              height: 25.0,
              width: MediaQuery.of(context).size.width* 0.7,
              child: Text(
                description,
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
      //height: 20.0,
      width: MediaQuery.of(context).size.width*0.76,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(Icons.account_box_outlined,
                color: app_color,
                size: 18.0,),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.02,
//            width: 2.0,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.7,
//              width: MediaQuery.of(context).size.width-140,
//              height: 20.0,
              child: Text(
                name,
//                maxLines: 1,
//                overflow: TextOverflow.ellipsis,
                style: RowStyle_grey(12.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}




detail_time(context,start_time,end_time){
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
              child: Icon(CupertinoIcons.clock,
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
               start_time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: RowStyle_grey(12.0),
              ),
            ),
          ),

          Spacer(),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: MediaQuery.of(context).size.width*0.04,
              child: Icon(CupertinoIcons.clock,
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
                start_time,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: RowStyle_grey(12.0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}