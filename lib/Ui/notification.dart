import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';


class notification extends StatefulWidget {
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  FirebaseMessaging _firebaseMessaging=FirebaseMessaging();
  String token;
  Future<void> _handleNotification (Map<dynamic, dynamic> message, bool dialog) async {
    var data = message['data'] ?? message;
    String expectedAttribute = data['expectedAttribute'];
    print(data);
  }



  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
//_showNotification();

  }

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((value){


        token=value;
        setState(() {});
        print(token);
    });

}


Future Notifier() async
{
  if(token!=null)
    {

        await _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(
              sound: true, badge: true, alert: true, provisional: false),
        );

    var response=await http.post(http_root+notification_url,body: { 'Content-Type': "application/json","token":token});
    print("inbetween");
     json.decode(response.body);
    print(response.body);

    print('yes ');
    return;

    }
  else{

print("no post");
    print("no token found");}


}

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: app_color,
      appBar: AppBar(
        toolbarHeight: 60.0,
        backgroundColor: app_color,
        titleSpacing:0.0,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(Icons.arrow_back_ios,color: w_color,),
            )),

        title:  Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text("Notifications",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: w_color,
              fontFamily: "poppins",
            ),),
        ),
        centerTitle: false,
        leadingWidth: 30.0,
      ),


      body:SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder:(context, index) {
              return Container(
                height: 100,
                child: Card(
                  elevation: 10.0,
                  color:app_color,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                         children: [
                           Text("Notification",
                             style: TextStyle(
                               fontWeight: FontWeight.w800,
                               color:w_color,
                               fontFamily: "poppins",
                             ),),

                           Spacer(),

                           Text("11-12 10:00 AM",
                             style: TextStyle(
                               fontWeight: FontWeight.w500,
                               color:w_color,
                               fontFamily: "poppins",
                             ),),
                         ],
                        ),
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      Text("Subject is that y0u are involved in it plz coperate",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color:w_color,
                          fontFamily: "poppins",
                        ),),

                    ],
                  ),
                ),
              );
            },),
          ),
        ),
      )
    );
  }
}
