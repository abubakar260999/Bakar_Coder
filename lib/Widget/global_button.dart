

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_n/Global/global.dart';

Widget filter_button(context){
  return Padding(
    padding: const EdgeInsets.only(bottom:5.0,right: 10.0),
    child: Container(
      height: 30,
      width: MediaQuery.of(context).size.width*0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Icon(Icons.filter_alt_outlined,color: app_color,)),
          Expanded(
            flex: 7,
            child: Text(
              'Filters'.toUpperCase(),
              style: TextStyle(
                  fontSize: 12.0,
                  color:app_color,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    ),
  );
}


Widget refresh_button(context){return  Padding(
  padding: const EdgeInsets.only(bottom:5.0),
  child: Container(
    height: 30,
    width: MediaQuery.of(context).size.width*0.28,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 3,
            child: Icon(Icons.refresh_outlined,color: app_color,)),
        Expanded(
          flex: 7,
          child: Text(
            'Refresh'.toUpperCase(),
            style: TextStyle(
                fontSize: 12.0,
                color:app_color,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  ),
);}

Widget add_button(context){return  Padding(
  padding: const EdgeInsets.only(bottom:5.0),
  child: Container(
    height: 30,
    width: MediaQuery.of(context).size.width*0.28,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 3,
            child: Icon(Icons.add_outlined,color: app_color,)),
        Expanded(
          flex: 7,
          child: Text(
            '  ADD  '.toUpperCase(),
            style: TextStyle(
                fontSize: 12.0,
                color:app_color,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  ),
);}

Widget global_back_button(context){
  return  GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.1,
            child: Icon(
              Icons.arrow_back_ios, color: Colors.white,
              size: 28.0,)),
      ));
}


Widget myrefresher(){
  return Center(
    child: Material(
      elevation: 20.0,
      borderRadius: BorderRadius.circular(100.0),
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircularProgressIndicator(
            color: app_color,

          ),
        ),
      ),
    ),
  );
}


my_nodata(){
  return Container(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20.0,),
        child: Image.asset("Assets/nodatafound.png",
        ),
      ),
    ),
  );
}



detail_back(){
  return          Align(
    alignment: Alignment.topLeft,
    child: GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios_outlined,
              color: app_color,
              size: 20.0,),

            Text(
              "BACK",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: RowStyle_app_color(12.0),
            ),

          ],
        ),
      ),
    ),
  );
}