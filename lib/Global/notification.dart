import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_n/Global/global.dart';


Message(){
  return Get.snackbar('DATA LOADED', '',
    padding:  EdgeInsets.only(left: 10.0,right: 10.0,),
    backgroundColor: app_color,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Container(),
    messageText: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
//                color: Colors.black87
        ),
        child: Row(
          children: [
            Text(
              "DATA LOADED",
              style: TextStyle(color: Colors.white),
            ),
      Spacer(),
            Center(
              child: Container(
                height: 20.0,
                width: 20.0,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            )

          ],
        )),
    margin: const EdgeInsets.only(bottom: 15,left: 10.0,right: 10.0),
  );
}


Data_added_Message(){
  return Get.snackbar('Data has been added Succesfully', '',
    padding:  EdgeInsets.only(left: 10.0,right: 10.0,),
    backgroundColor: app_color,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Container(),
    messageText: Container(
      height: 50.0,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
//                color: Colors.black87
        ),
        child: Row(
          children: [
            Text(
              "Data has been added Succesfully",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),

            Container(
                height: 20.0,
                width: 20.0,
                child: Icon(Icons.done,color: Colors.white,
//                  size: 20.0,
                ))
          ],
        )),
    margin: const EdgeInsets.only(bottom: 15,left: 10.0,right: 10.0),
  );
}


Error_message(e){
  return Get.snackbar(e, '',
    padding:  EdgeInsets.only(left: 10.0,right: 10.0,),
    backgroundColor: app_color,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Container(),
    messageText: Container(
      height: 50.0,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
//                color: Colors.black87
        ),
        child: Row(
          children: [
            Text(
              e,
              style: TextStyle(color: Colors.white),
            ),

            Spacer(),
            Container(
              height: 20.0,
              width: 20.0,
              child: Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
            ),

          ],
        )),
    margin: const EdgeInsets.only(bottom: 15,left: 10.0,right: 10.0),
  );

}


Data_processing_Message(){
  return Get.snackbar('PROCESSING', '',
    padding:  EdgeInsets.only(left: 10.0,right: 10.0,),
    backgroundColor: app_color,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Container(),
    messageText: Container(
      height: 50.0,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
//                color: Colors.black87
        ),
        child: Row(
          children: [
            Text(
              "PROCESSING",
              style: TextStyle(color: Colors.white),
            ),
       Spacer(),

            Container(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          ],
        )),
    margin: const EdgeInsets.only(bottom: 15,left: 10.0,right: 10.0),
  );
}




files_error(){
  return Get.snackbar('Unable to launch', '',
    padding:  EdgeInsets.only(left: 10.0,right: 10.0,),
    backgroundColor: app_color,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Container(),
    messageText: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
//                color: Colors.black87
        ),
        child: Row(
          children: [
            Text(
              "UNABLE TO LAUNCH",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),

            Container(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          ],
        )),
    margin: const EdgeInsets.only(bottom: 15,left: 10.0,right: 10.0),
  );
}




any_data_show(msg){
  return Get.snackbar(msg, '',
    padding:  EdgeInsets.only(left: 10.0,right: 10.0,),
    backgroundColor: app_color,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Container(),
    messageText: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
//                color: Colors.black87
        ),
        child: Row(
          children: [
            Text(
              msg,
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),

            Container(
              height: 20.0,
              width: 20.0,
              child: Icon(Icons.done,color: Colors.white,)
            )
          ],
        )),
    margin: const EdgeInsets.only(bottom: 15,left: 10.0,right: 10.0),
  );
}





authentication_Message(){
  return Get.snackbar('Authentication Succesful', '',
    padding:  EdgeInsets.only(left: 10.0,right: 10.0,),
    backgroundColor: app_color,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Container(),
    messageText: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
//                color: Colors.black87
        ),
        child: Row(
          children: [
            Text(
              "Authentication Succesful",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Center(
              child: Container(
                height: 20.0,
                width: 20.0,
                child: Center(
                  child: Icon(Icons.done, color:Colors.white,),
                ),
              ),
            )

          ],
        )),
    margin: const EdgeInsets.only(bottom: 15,left: 10.0,right: 10.0),
  );
}

invalid_Message(){
  return Get.snackbar('INVALID CREDENTIAL', '',
    padding:  EdgeInsets.only(left: 10.0,right: 10.0,),
    backgroundColor: app_color,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Container(),
    messageText: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
//                color: Colors.black87
        ),
        child: Row(
          children: [
            Text(
              "INVALID CREDENTIAL",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Center(
              child: Container(
                height: 20.0,
                width: 20.0,
                child: Center(
                  child:Icon(Icons.info_outline, color:Colors.white,)
                ),
              ),
            )

          ],
        )),
    margin: const EdgeInsets.only(bottom: 15,left: 10.0,right: 10.0),
  );
}

processing_Message(){
  return Get.snackbar('Processing', '',
    padding:  EdgeInsets.only(left: 10.0,right: 10.0,),
    backgroundColor: app_color,
    snackPosition: SnackPosition.BOTTOM,
    titleText: Container(),
    messageText: Container(
        height: 50.0,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
//                color: Colors.black87
        ),
        child: Row(
          children: [
            Text(
              "Processing",
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Center(
              child: Container(
                height: 20.0,
                width: 20.0,
                child: Center(
                    child:CircularProgressIndicator(
                      color:Colors.white,
                    ),
                ),
              ),
            )

          ],
        )),
    margin: const EdgeInsets.only(bottom: 15,left: 10.0,right: 10.0),
  );
}