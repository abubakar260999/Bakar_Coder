import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:triple_n/Authetication/storage.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Ui/home.dart';
import 'signin.dart';


class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  var final_email;
  void initState() {
    super.initState();
    get_validation().whenComplete(() async{
      print(final_email);
            Timer(Duration(seconds: 2),
              ()=>Get.off(()=> final_email==null ? signin():home()));

    });


  }

  Future get_validation() async{
    var obtained_email=await usesecurestorage.read_data();
   setState(() {
     final_email=obtained_email;
   });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_color,
//      body: Center(
//        child:Image.asset("assets/images/ServePak.png"),
//      ),2

    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            "NNN",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.white
            ),
          ),

          SizedBox(
            height: 7.0,
          ),
          Text(
            "FASTPRO",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white
            ),
          ),

          SizedBox(
            height: 7.0,
          ),

          Text(
            "DATABASE",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.white
            ),
          ),
        ],
      ),
    ),

    );
  }
}
