import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:triple_n/Authetication/storage.dart';
import 'package:triple_n/Forms/add_appointment.dart';
import 'package:triple_n/Forms/add_call.dart';
import 'package:triple_n/Forms/add_contact.dart';
import 'package:triple_n/Forms/add_daily_task.dart';
import 'package:triple_n/Forms/add_task.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Model/users.dart';
import 'package:triple_n/Ui/FirstPart/signin.dart';
import 'package:triple_n/Ui/profile.dart';
import 'package:triple_n/Views/view_appointments.dart';
import 'package:triple_n/Views/view_call.dart';
import 'package:triple_n/Views/view_contact.dart';
import 'package:triple_n/Views/view_coperations.dart';
import 'package:triple_n/Views/view_daily_task.dart';
import 'package:triple_n/Views/view_individuals.dart';
import 'package:triple_n/Views/view_personal_task.dart';
import 'dart:io';
import 'package:triple_n/Views/view_task.dart';
import 'notification.dart';
import 'package:triple_n/fourmain/completed.dart';
import 'package:triple_n/fourmain/inprocess.dart';
import 'package:triple_n/fourmain/notstarted.dart';
import 'package:triple_n/fourmain/overdue.dart';
import 'package:triple_n/Service/user_profile.dart';
import 'package:triple_n/Service/badges_service.dart';


class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  final storage = new FlutterSecureStorage();

  File _image;
  int _selectedIndex = 2; //New
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//  Future getImage() async {
//    final picker = ImagePicker();
//    final imageFile =
//        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
//
//    if (imageFile != null) {
//      setState(() {
//      if (imageFile != null) {
//        _image = File(imageFile.path);
//      } else {
//        print('No image selected.');
//      }
//    });
//  }
//  }

  List<dynamic> pages(_scaffoldState) {
    return [
      completed(),
      inprogress(),
      home_in(_scaffoldState),
      notstarted(),
      overdue(),
    ];
  }

//for camera
//  openDeleteDialog(BuildContext context) {
//    containerForSheet<String>(
//      context: context,
//      child: CupertinoActionSheet(
//        actions: <Widget>[
//          CupertinoActionSheetAction(
//            child: Text(
//              "Camera",
//              style: TextStyle(
//                  color: appColorBlack,
//                  fontSize: 16,
//                  fontFamily: "MontserratBold"),
//            ),
//            onPressed: () async {
//              Navigator.of(context, rootNavigator: true).pop("Discard");
//
//              File _image;
//              final picker = ImagePicker();
//              final imageFile =
//              await picker.getImage(source: ImageSource.camera);
//
//              if (imageFile != null) {
//                setState(() {
//                  if (imageFile != null) {
//                    _image = File(imageFile.path);
//                   Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SendStory(imageFile: _image)),
//                    );
//                  } else {
//                    print('No image selected.');
//                  }
//                });
//              }
//            },
//          ),
//          CupertinoActionSheetAction(
//            child: Text(
//              "Gallery",
//              style: TextStyle(
//                  color: appColorBlack,
//                  fontSize: 16,
//                  fontFamily: "MontserratBold"),
//            ),
//            onPressed: () async {
//              Navigator.of(context, rootNavigator: true).pop("Discard");
//
//              File _image;
//              final picker = ImagePicker();
//              final imageFile =
//              await picker.getImage(source: ImageSource.gallery);
//
//              if (imageFile != null) {
//                setState(() {
//                  if (imageFile != null) {
//                    _image = File(imageFile.path);
//                   Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => SendStory(imageFile: _image)),
//                    );
//                  } else {
//                    print('No image selected.');
//                  }
//                });
//              }
//            },
//          ),
//        ],
//        cancelButton: CupertinoActionSheetAction(
//          child: Text(
//            "Cancel",
//            style: TextStyle(color: Colors.black, fontFamily: "MontserratBold"),
//          ),
//          isDefaultAction: true,
//          onPressed: () {
//            // Navigator.pop(context, 'Cancel');
//            Navigator.of(context, rootNavigator: true).pop("Discard");
//          },
//        ),
//      ),
//    );
//  }
//
//  void containerForSheet<T>({BuildContext context, Widget child}) {
//    showCupertinoModalPopup<T>(
//      context: context,
//      builder: (BuildContext context) => child,
//    ).then<void>((T value) {});
//  }
//}

  List<Users> user_data_list = [];
  var email;
  String image_id;

  void initState() {
     notification_badges="0";
     complete_badges="0" ;
     overdue_badges ="0";
    inprogress_badges="0";
     notstarted_badges ="0";
     get_badges_data();
     get_data();
    super.initState();

  }

  Future get_email() async {
    email = await usesecurestorage.read_data();
    setState(() {});
    print(email);
  }

  Future get_data() async {
    get_email().whenComplete(() async {
      user_data_list = await data.users(email);
      setState(() {
        image_id = user_data_list[0].id;
        image_id = image_id + ".jpg";
      });
    });
  }

  String notification_badges;
  String complete_badges ;
  String overdue_badges ;
  String inprogress_badges;
  String notstarted_badges ;


  Future get_badges_data() async {
    complete_badges = await badges.count('Completed');
    overdue_badges = await badges.count('Overdue');
    inprogress_badges = await badges.count('Inprocess');
    notstarted_badges = await badges.count('Notstarted');
    notification_badges = await badges.count('Notification');
    setState(() {});
  }


  Widget home_in(_scaffoldState) {
    return Stack(
      children: [
        //all taps
        Positioned(
           top: MediaQuery.of(context).size.height * 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            color: app_color,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                  child: IconButton(
                    icon: Image.asset("Assets/menu.png",color: w_color,width: 50.0,height: 50.0,),
                    onPressed: () {
                      _scaffoldState.currentState.openDrawer();
                    },
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.only(top: 30.0),
//                  child: new Stack(
//                    children: <Widget>[
//    globalImage.length > 0
//    ? CircleAvatar(
//    radius: 30,
//    Assetimage:
//    NetworkImage(globalImage),
//    )

//                      Padding(
//                        padding: const EdgeInsets.only(top: 30.0),
//                        child: Column(
//                          children: [
//                            CircleAvatar(
//                              radius: MediaQuery.of(context).size.height*0.05,
//                              backgroundImage: AssetImage("Assets/profile.jpg"),
//                              child: Stack(
//                                  children: [
//                                    GestureDetector(
//                                      onTap: (){
////                                  _showPicker(context);
//                                      },
//                                      child: Align(
//                                        alignment: Alignment.bottomRight,
//                                        child: CircleAvatar(
//                                          radius: 12,
//                                          backgroundColor: Colors.white70,
//                                          child: Icon(Icons.camera_alt_outlined,color: app_color,size: 15.0,),
//                                        ),
//                                      ),
//                                    ),
//                                  ]
//                              ),
//                            ),
//
//                            Expanded(
//                              child: Text("Zarwa Saqib",style: TextStyle(
//                                fontFamily: "poppins",
//                                fontWeight: FontWeight.w600,
//                                fontSize:12.0,
//                                color: Colors.white,
//                              ),),
//                            ),
//
//                          ],
//                        ),
//                      ),

                user_data_list != null && user_data_list.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Column(
                          children: [

                            Material(
                              elevation: 20.0,
                              borderRadius: BorderRadius.circular(100.0),
                              child: CircleAvatar(
                                radius: 33,
                                backgroundColor: Colors.white,
//                              backgroundImage: AssetImage("Assets/avatar.png",),
//                              backgroundColor: w_color,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      http_root + folder_path + "$image_id"),
                                ),
                              ),
                            ),

//                      CircleAvatar(
//
//                        child: FadeInImage(
//                          height: MediaQuery.of(context).size.height*0.12,
//                          width: MediaQuery.of(context).size.height*0.12,
//                          image: NetworkImage(http_root+folder_path + "$image_id"),
//                          placeholder: AssetImage("Assets/hover.gif",),
//                          imageErrorBuilder: (context, error, stackTrace) {
//                            return Image.asset(
//                                'Assets/hover.gif',
//                                height:MediaQuery.of(context).size.height*0.12,
//                                width: MediaQuery.of(context).size.height*0.12,
//                                fit: BoxFit.fitWidth);
//                          },
//                          fit: BoxFit.fitWidth,
//                        ),
//                      ),
                            SizedBox(
                              height: 5.0,
                            ),

                            Expanded(
                              child: Text(
                                user_data_list[0].name == null &&
                                        user_data_list[0].name.isEmpty
                                    ? "No Name"
                                    : user_data_list[0].name,
                                style: TextStyle(
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Column(
                          children: [

                            Material(
                              elevation: 20.0,
                              borderRadius: BorderRadius.circular(100.0),
                              child: CircleAvatar(
                                radius: 33,
                                backgroundColor: Colors.white,
//                                backgroundImage: AssetImage("Assets/avatar.png",),
//                              backgroundColor: w_color,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage("Assets/hover.gif"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Expanded(
                              child: Text(
                                "Loading...",
                                style: TextStyle(
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

//
//                      Container(
//                          height: 65,
//                          width: 65,
//                          decoration: BoxDecoration(
//                            color: Colors.grey[400],
//                            shape: BoxShape.circle,
//                            border: Border.all(color: Colors.white, width: 2),
//                          ),
//                          child: Padding(
//                            padding: const EdgeInsets.all(10.0),
//                            child: Image.asset(
//                              "Assets/profile.jpg",
//                              fit: BoxFit.fitWidth,
//                              color: Colors.white,
//                            ),
//                          )),
//                      Positioned(
//                          bottom: 0.9,
//                          right: 0.3,
//                          child: Container(
//                              height: 30,
//                              width: 30,
//                              decoration: BoxDecoration(
//                                  color: Colors.transparent, shape: BoxShape.circle),
//                              child: GestureDetector(
//                                onTap: () {
////                                  openDeleteDialog(context),
//                                },
//                                child: Icon(
//                                  Icons.camera_alt_outlined,
//                                  color: Colors.white,
//                                  size: 18,
//                                ),
//                              ))),
//                    ],
//                  ),
//                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30.0, right: 20.0),
                  child: IconButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                notification(),
                          ));
                    },
                    icon: Badge(
                        badgeContent:
                            Text(notification_badges, style: TextStyle(color: Colors.white)),
                        animationType: BadgeAnimationType.scale,
                        shape: BadgeShape.circle,
                        position: BadgePosition.topEnd(top: -15, end: -10),
                        child: Icon(
                          Icons.notifications_active_sharp,
                          size: 25.0,
                          color: w_color,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: MediaQuery.of(context).size.height * 0.25,
          right: 20.0,
          left: 20.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: shade,
                  width: 3,
                ),
                color: w_color),
            child: Column(
              children: [
                SizedBox(height: 15.0),
                //1st row
                Expanded(
                  child: Row(
                    children: [
                      //Tickets
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => view_task(),
                                      ));
                                },
                                elevation: 8.0,
                                child: new Icon(
                                  Icons.credit_card_sharp,
                                  color: app_color,
                                ),
                                shape: CircleBorder(),
                                fillColor: w_color,
                                highlightColor: app_color,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Tickets",
                                  style: TextStyle(
                                    fontFamily: "poppins",
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),



                      //personal ticket
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            view_personal_task(),
                                      ));
                                },
                                elevation: 8.0,
                                child: new Icon(
                                  Icons.person_outline_outlined,
                                  color: app_color,
                                ),
                                shape: CircleBorder(),
                                fillColor: w_color,
                                highlightColor: app_color,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Personal Tickets",
                                  style: TextStyle(
                                    fontFamily: "poppins",
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //2nd row
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            view_individuals(),
                                      ));
                                },
                                elevation: 8.0,
                                child: new Icon(
                                 Icons.person_pin_circle_outlined,
                                  color: app_color,
                                ),
                                shape: CircleBorder(),
                                fillColor: w_color,
                                highlightColor: app_color,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Individuals",
                                  style: TextStyle(
                                    fontFamily: "poppins",
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),



                      //company
                      Expanded(
                        child: Column(
                          children: [
                            //campany
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => view_coperation(),
                                      ));
                                },
                                elevation: 8.0,
                                child: new Icon(
                                  Icons.work,
                                  color: app_color,
                                ),
                                shape: CircleBorder(),
                                fillColor: w_color,
                                highlightColor: app_color,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Companies",
                                  style: TextStyle(
                                    fontFamily: "poppins",
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),



                    ],
                  ),
                ),

                //3rd row

                Expanded(
                  child: Row(
                    children: [
                      //call directory
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => view_call(),
                                      ));
                                },
                                elevation: 8.0,
                                child: new Icon(
                                  Icons.phone_in_talk,
                                  color: app_color,
                                ),
                                shape: CircleBorder(),
                                fillColor: w_color,
                                highlightColor: app_color,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Call Directory",
                                  style: TextStyle(
                                    fontFamily: "poppins",
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

//contact

                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => view_contact(),
                                      ));
                                },
                                elevation: 8.0,
                                child: new Icon(
                                  Icons.contact_page,
                                  color: app_color,
                                ),
                                shape: CircleBorder(),
                                fillColor: w_color,
                                highlightColor: app_color,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Contact Directory",
                                  style: TextStyle(
                                    fontFamily: "poppins",
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
//                SizedBox(height: 10.0),

//4th row
                Expanded(
                  child: Row(
                    children: [
                      //Appointment
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            view_appointments(),
                                      ));
                                },
                                elevation: 8.0,
                                child: new Icon(
                                  Icons.perm_contact_cal_rounded,
                                  color: app_color,
                                ),
                                shape: CircleBorder(),
                                fillColor: w_color,
                                highlightColor: app_color,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Appointments",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "poppins",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Daliy Task
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => view_daily_task(),
                                      ));
                                },
                                elevation: 8.0,
                                child: new Icon(
                                  Icons.menu_book,
                                  color: app_color,
                                ),
                                shape: CircleBorder(),
                                fillColor: w_color,
                                highlightColor: app_color,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Daily Task",
                                  style: TextStyle(
                                    fontFamily: "poppins",
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        //Graph
//        Positioned(
//          top: MediaQuery.of(context).size.height * 0.61,
//          right: 10.0,
//          left: 10.0,
//          bottom: 5.0,
//          child: Container(
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height * 0.2,
//            child: FittedBox(
//
//            ),
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                fit: BoxFit.fill,
//               image: AssetImage("Assets/graph.png",
//                ),
//              ),
//                borderRadius: BorderRadius.circular(10.0),
//                border: Border.all(
//                  color: shade,
//                  width: 3,
//                )),
//          ),
//        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldState,
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Drawer(
            elevation: 20.0,
            child: Container(
              color: app_color,
              child: ListView(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  //triple logo

                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.width * 0.09,
                      backgroundImage: AssetImage('Assets/home_logo.png'),
                    ),
                    title: Text(
                      "NNN",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: w_color),
                    ),
                  ),

//                Container(
//                  height: MediaQuery.of(context).size.height * 0.2,
//                  width: MediaQuery.of(context).size.width,
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.end,
//                    children: [
//                      Align(
//                         alignment: Alignment.centerLeft,
//                        child: Image.asset(
//                          "Assets/home_logo.png",
//                          fit: BoxFit.fitWidth,
//                          height: MediaQuery.of(context).size.height * 0.2,
//                          width: MediaQuery.of(context).size.width*0.4,
//                        ),
//                      ),
//
//                      Align(
//                        alignment: Alignment.centerLeft,
//                        child: FittedBox(
//                          fit: BoxFit.scaleDown,
//                          child: Text(
//                            "Triple n",
//                            style: TextStyle(
//                              fontSize: 12.0,
//                              fontFamily: "poppins",
//                              fontWeight: FontWeight.w600,
//                                color: Colors.white,
//                            ),
//                          ),
//                        ),
//                      )
//
//                    ],
//                  ),
//                ),

                  ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    leading: Icon(
                      Icons.menu_book_sharp,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Tickets",
                      style: TextStyle(
                          fontFamily: "poppins",
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => view_task()));
                            },
                            child: Text("View All",
                                style: TextStyle(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                      SizedBox(height: 2.0),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => add_task()));
                            },
                            child: Text("Add new",
                                style: TextStyle(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),

                  ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    leading: Icon(
                      Icons.phone_in_talk,
                      color: Colors.white,
                    ),
                    title: Text("Daily Task",
                        style: TextStyle(
                          fontFamily: "poppins",
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => view_daily_task()));
                            },
                            child: Text("View All",
                                style: TextStyle(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                      SizedBox(height: 2.0),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => add_daily_task()));
                            },
                            child: Text("Add new",
                                style: TextStyle(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),

//personal tickect
                  ListTile(
                    leading: Icon(
                      Icons.person_outline_outlined,
                      color: Colors.white,
                    ),
                    title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => view_personal_task()));
                        },
                        child: Text("Personal Tickets View",
                            style: TextStyle(
                                fontFamily: "poppins",
                                fontWeight: FontWeight.w500,
                                color: Colors.white))),
                  ),



                  ListTile(
                    leading: Icon(
                      Icons.person_pin_circle_outlined,
                      color: Colors.white,
                    ),
                    title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => view_individuals()));
                        },
                        child: Text("Individual View",
                            style: TextStyle(
                                fontFamily: "poppins",
                                fontWeight: FontWeight.w500,
                                color: Colors.white))),
                  ),


                  ListTile(
                    leading: Icon(
                      Icons.work,
                      color: Colors.white,
                    ),
                    title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => view_coperation()));
                        },
                        child: Text("Corporations View",
                            style: TextStyle(
                                fontFamily: "poppins",
                                fontWeight: FontWeight.w500,
                                color: Colors.white))),
                  ),

                  ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    leading: Icon(
                      Icons.phone_in_talk,
                      color: Colors.white,
                    ),
                    title: Text("Call directory",
                        style: TextStyle(
                            fontFamily: "poppins",
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => view_call()));
                            },
                            child: Text("View All",
                                style: TextStyle(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                      SizedBox(height: 2.0),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => add_call()));
                            },
                            child: Text("Add new",
                                style: TextStyle(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    leading: Icon(
                      Icons.perm_contact_cal_rounded,
                      color: Colors.white,
                    ),
                    title: Text("Appointments",
                        style: TextStyle(
                            fontFamily: "poppins",
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          view_appointments()));
                            },
                            child: Text("View All",
                                style: TextStyle(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                      SizedBox(height: 2.0),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => add_appoitment()));
                            },
                            child: Text("Add new",
                                style: TextStyle(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                  ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    leading: Icon(
                      Icons.contact_page,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Contact Directory",
                      style: TextStyle(
                          fontFamily: "poppins",
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => view_contact()));
                            },
                            child: Text("View All",
                                style: TextStyle(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                      SizedBox(height: 2.0),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => add_contact()));
                            },
                            child: Text("Add new",
                                style: TextStyle(
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
//                    ExpansionTile(
//                      iconColor: Colors.white,
//                      collapsedIconColor: Colors.white,
//                      leading: Icon(
//                        Icons.description_rounded,
//                        color: Colors.white,
//                      ),
//                      title: Text("Invoice",
//                          style: TextStyle(
//                              color: Colors.white
//                          )),
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(2.0),
//                          child: GestureDetector(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => view_invoice()));
//                              },
//                              child: Text("View All",
//                                  style: TextStyle(
//                                      color: Colors.white
//                                  ))),
//                        ),
//                        SizedBox(height: 2.0),
//                        Padding(
//                          padding: const EdgeInsets.all(2.0),
//                          child: GestureDetector(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => add_invoice()));
//                              },
//                              child: Text("Add new",
//                                  style: TextStyle(
//                                      color: Colors.white
//                                  ))),
//                        ),
//                        SizedBox(height: 5.0),
//                      ],
//                    ),
//                    ExpansionTile(
//                      iconColor: Colors.white,
//                      collapsedIconColor: Colors.white,
//                      leading: Icon(
//                        Icons.chat,
//                        color: Colors.white,
//                      ),
//                      title: Text("Sms",
//                          style: TextStyle(
//                              color: Colors.white
//                          )),
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(2.0),
//                          child: GestureDetector(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => add_task()));
//                              },
//                              child: Text("View All",
//                                  style: TextStyle(
//                                      color: Colors.white
//                                  ))),
//                        ),
//                        SizedBox(height: 2.0),
//                        Padding(
//                          padding: const EdgeInsets.all(2.0),
//                          child: GestureDetector(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => add_task()));
//                              },
//                              child: Text("Add new",
//                                  style: TextStyle(
//                                      color: Colors.white
//                                  ))),
//                        ),
//                        SizedBox(height: 5.0),
//                      ],
//                    ),
//                    ExpansionTile(
//                      iconColor: Colors.white,
//                      collapsedIconColor: Colors.white,
//                      leading: Icon(
//                        Icons.chat,
//                        color: Colors.white,
//                      ),
//                      title: Text("Messenger",
//                          style: TextStyle(
//                              color: Colors.white
//                          )),
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(2.0),
//                          child: GestureDetector(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => add_task()));
//                              },
//                              child: Text("View All",   style: TextStyle(
//                                  color: Colors.white
//                              ))),
//                        ),
//                        SizedBox(height: 2.0),
//                        Padding(
//                          padding: const EdgeInsets.all(2.0),
//                          child: GestureDetector(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => add_task()));
//                              },
//                              child: Text("Add new",
//                                  style: TextStyle(
//                                      color: Colors.white
//                                  ))),
//                        ),
//                        SizedBox(height: 5.0),
//                      ],
//                    ),

                  ListTile(
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.white,
                    ),
                    title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => profile()));
                        },
                        child: Text("Profile",
                            style: TextStyle(
                                fontFamily: "poppins",
                                fontWeight: FontWeight.w500,
                                color: Colors.white))),
                  ),

                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: GestureDetector(
                        onTap: () async {
//                        final SharedPreferences prefs = await SharedPreferences.getInstance();
//                     prefs.remove('email');
                          await usesecurestorage.delete_data();
                          Get.offAll(signin());
                        },
                        child: Text("Sign Out",
                            style: TextStyle(
                                fontFamily: "poppins",
                                fontWeight: FontWeight.w500,
                                color: Colors.white))),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: app_color,
          items: <BottomNavigationBarItem>[
            //complete
            BottomNavigationBarItem(
              icon: Badge(
                  badgeContent:
                      Text(complete_badges, style: TextStyle(color: Colors.white)),
                  animationType: BadgeAnimationType.scale,
                  shape: BadgeShape.circle,
                  position: BadgePosition.topEnd(top: -15, end: -10),
                  child: Icon(Icons.done_outline_rounded)),
              title: Text(" Complete",
                style: TextStyle(
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w800,
                ),),
            ),
            //inprocess
            BottomNavigationBarItem(
              icon: Badge(
                  badgeContent:
                      Text(inprogress_badges, style: TextStyle(color: Colors.white)),
                  animationType: BadgeAnimationType.scale,
                  shape: BadgeShape.circle,
                  position: BadgePosition.topEnd(top: -15, end: -10),
                  child: Icon(Icons.access_alarm_sharp)),
              title: Text("In-Process",
              style: TextStyle(
                fontFamily: "poppins",
                fontWeight: FontWeight.w800,
              ),),
            ),

            //home
            BottomNavigationBarItem(
              title: Text("Home",
                style: TextStyle(
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w800,
                ),
              ),
              //use this
              icon: RawMaterialButton(
//              onPressed: (){
//                pages().elementAt(_selectedIndex);
//                },
                elevation: 5.0,
                child: new Icon(Icons.home_outlined, color: app_color),
                shape: CircleBorder(),
                fillColor: w_color,
                highlightColor: app_color,
                padding: const EdgeInsets.all(10.0),
              ),
            ),

            //Not STARTED
            BottomNavigationBarItem(
              icon: Badge(
                child: Icon(
                  Icons.not_started,
                ),
                badgeContent: Text(notstarted_badges, style: TextStyle(color: Colors.white)),
                animationType: BadgeAnimationType.scale,
                shape: BadgeShape.circle,
                position: BadgePosition.topEnd(top: -15, end: -10),
              ),
              title: Text("Not-Started"),
            ),
            BottomNavigationBarItem(
              icon: Badge(
                  badgeContent:
                      Text(overdue_badges, style: TextStyle(color: Colors.white)),
                  animationType: BadgeAnimationType.scale,
                  shape: BadgeShape.circle,
                  position: BadgePosition.topEnd(top: -15, end: -10),
                  child: Icon(
                    Icons.info,
                  )),
              title: Text("Overdue",
                style: TextStyle(
                fontFamily: "poppins",
                fontWeight: FontWeight.w800,
              ),),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white60,
          selectedItemColor: w_color,
          unselectedLabelStyle: TextStyle(color: Colors.black),
          selectedLabelStyle: TextStyle(color: app_color),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: pages(_scaffoldState).elementAt(_selectedIndex),
      ),
    );
  }
}

//
//new BottomNavigationBar(
//
//type: BottomNavigationBarType.fixed,
//fixedColor: app_color,
//
//items:<BottomNavigationBarItem>[
//
////complete 1
//BottomNavigationBarItem(
//icon: new Stack(
//children: <Widget>[
//new Icon(Icons.done_outline_rounded),
//new Positioned(
//right: 0,
//child: new Container(
//padding: EdgeInsets.all(1),
//decoration: new BoxDecoration(
//color: in_color,
//borderRadius: BorderRadius.circular(6),
//),
//constraints: BoxConstraints(
//minWidth: 12,
//minHeight: 12,
//),
//child: new Text(
//'100',
//style: new TextStyle(
//color: Colors.white,
//fontSize: 8,
//),
//textAlign: TextAlign.center,
//),
//),
//)
//],
//),
//title: Text('Complete'),
//),
//
////inprocess 2
//BottomNavigationBarItem(
//icon: new Stack(
//children: <Widget>[
//new Icon(Icons.access_alarm_sharp),
//new Positioned(
//right: 0,
//child: new Container(
//padding: EdgeInsets.all(1),
//decoration: new BoxDecoration(
//color: in_color,
//borderRadius: BorderRadius.circular(6),
//),
//constraints: BoxConstraints(
//minWidth: 12,
//minHeight: 12,
//),
//child: new Text(
//'100',
//style: new TextStyle(
//color: Colors.white,
//fontSize: 8,
//),
//textAlign: TextAlign.center,
//),
//),
//)
//],
//),
//title: Text("In-Process"),
//),
//
//// home with notification
//new BottomNavigationBarItem(
//icon: new Icon(
//Icons.home,
//),
//title: new Text(
//"Home",
//),
//),
//
////not Started
//BottomNavigationBarItem(
//icon: new Stack(
//children: <Widget>[
//
//new Icon(Icons.not_started),
//new Positioned(
//right: 0,
//child: new Container(
//padding: EdgeInsets.all(1),
//decoration: new BoxDecoration(
//color: in_color,
//borderRadius: BorderRadius.circular(6),
//),
//constraints: BoxConstraints(
//minWidth: 12,
//minHeight: 12,
//),
//child: Expanded(
//child: new Text(
//'100',
//style: new TextStyle(
//color: Colors.white,
//fontSize: 8,
//),
//textAlign: TextAlign.center,
//),
//),
//),
//)
//],
//),
//title: Text('Not Started')
//),
//
////overdue
//BottomNavigationBarItem(
//icon: new Stack(
//children: <Widget>[
//new Icon(Icons.info),
//new Positioned(
//right: 0,
//child: new Container(
//padding: EdgeInsets.all(1),
//decoration: new BoxDecoration(
//color: in_color,
//borderRadius: BorderRadius.circular(6),
//),
//constraints: BoxConstraints(
//minWidth: 12,
//minHeight: 12,
//),
//child: new Text(
//'100',
//style: new TextStyle(
//color: Colors.white,
//fontSize: 8,
//),
//textAlign: TextAlign.center,
//),
//),
//)
//],
//),
//title: Text('Overdue'),
//),
//],
//currentIndex: _selectedIndex, //New
//onTap: _onItemTapped,
//
//),
