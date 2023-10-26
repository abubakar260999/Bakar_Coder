import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:triple_n/Forms/add_contact.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Model/Contact.dart';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Views/detailview_contact.dart';
import 'package:triple_n/Widget/contact_widget.dart';
import 'package:triple_n/Widget/global_button.dart';



class view_contact extends StatefulWidget {
  @override
  _view_contactState createState() => _view_contactState();
}


class Debouncer {
  int milliseconds;
  VoidCallback action;
  Timer timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _view_contactState extends State<view_contact> {
  @override
  final TextEditingController searchtxt = TextEditingController();
  Widget showbar =view_appbar_txt("Contact Directory");

  final RefreshController _refreshController = RefreshController(
      initialRefresh: true);
  List<Contact> contact_list = [];
  int current_page = 0, current_search_page = 0;
  String searchedWord = "";


  final TextEditingController contact_mobile = TextEditingController();
  final TextEditingController contact_email = TextEditingController();
  final TextEditingController contact_phone = TextEditingController();
  String con_mobile = "";
  String con_email = "";
  String con_phone = "";

  bool onsearch = false;
  bool filter_flag =false;
  int current_filter_page = 0;
  bool no_data_present=false;

  //simple data
  Future<List<Contact>> Contact_manager({bool isReload = false}) async {
    try {
      if (isReload) {
        current_page = 0;
      }
      String flag = "onstart";
      String url = http_root + "contact_directory.php?page_no=$current_page&size=20&flag=$flag";

      final response = await http.get(url);
      List<Contact> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        print(parsed.map<Contact>((json) => Contact.fromJson(json)).toList());
        result = parsed.map<Contact>((json) => Contact.fromJson(json)).toList();


//        if (result != null && result.isNotEmpty) {
          contact_list.addAll(result);
          current_page++;
//        }
        setState(() {
          if(contact_list==[] || contact_list.isEmpty)
          {
            no_data_present=true;
          }
        });


        return result;
      }
//      else {
//        return <Contact>[];
//      }
    } catch (e) {
      return <Contact>[];
    }
  }

//searched data
  Future<List<Contact>> Contact_manager_onsearch(
      {bool isReload = false, String word}) async {
    try {
      if (isReload) {
        current_search_page = 0;
      }
      String flag = "onsearch";
      String url = http_root + "contact_directory.php?page_no=$current_search_page&size=5&word=$word&flag=$flag";

      final response = await http.get(url);
      List<Contact> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        result = parsed.map<Contact>((json) => Contact.fromJson(json)).toList();

//        if (result != null && result.isNotEmpty) {
          this.searchedWord = word;
          current_search_page++;
          contact_list.addAll(result);
          setState(() {
            if(contact_list==[] || contact_list.isEmpty)
            {
              no_data_present=true;
            }
          });
        }
//        if (result != null && result.isNotEmpty) {
          return result;
//        }
//      } else {
//        return <Contact>[];
//      }
    } catch (e) {
      return <Contact>[];
    }
  }

  onstart() async {
    await Contact_manager(isReload: true);
  }

  void initState() {
    super.initState();
    filter_flag = false;
    onstart();
  }

  Future<List<Contact>> Contact_filter_manager(
      {bool isReload = false, String con_email, String con_phone, String con_mobile}) async {
    try {
      if (isReload) {
        current_filter_page = 0;
      }

//      print(name);
//      print(phoneno);
//      print(date);

      String flag = "onfilter";
      String url = http_root + "contact_directory.php?page_no=$current_filter_page&size=20&email=$con_email&phone=$con_phone&mobile=$con_mobile&flag=$flag";
      final response = await http.get(url);
      List<Contact> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        result = parsed
            .map<Contact>((json) => Contact.fromJson(json))
            .toList();

        print(result);
//        if (result != null && result.isNotEmpty) {
//          this.app_name = appointment_name.text;
//          this.app_date=appintment_date.text;
//          this.app_phno=appointment_phoneno.text;
          current_filter_page++;
          contact_list.addAll(result);
          setState(() {
            if(contact_list==[] || contact_list.isEmpty)
            {
              no_data_present=true;
            }
          });
          return result;
//        } else {
//          return <Contact>[];
//        }
      }
    } catch (e) {
      return <Contact>[];
    }
  }


  final _debouncer = Debouncer();

  Widget build(BuildContext context) {

    AlertDialog Filter = AlertDialog(
      title: Center(
        child: Text(
          "Filters",
          style: TextStyle(
              fontSize: 24.0,
              fontFamily: "poppins",
              fontWeight: FontWeight.w500,
              color: app_color),
        ),
      ),
      content: Container(
        height: 170,
        child: Column(
          children: [

            Container(
              height: 45,
              child
                  : new TextField(
                controller: contact_email,
                decoration: new InputDecoration(
                  labelText: "Email",
                  fillColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: app_color,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: app_color, width: 0.0),
                  ),
                  labelStyle: TextStyle(fontSize: 18.0, color: app_color),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(color: Colors.blue),
                  ),
                ),
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
//
            SizedBox(
              height: 10.0,
            ),
            //phone
            Container(
              height: 45,
              child: TextField(
                controller: contact_phone,
                decoration: new InputDecoration(
                  labelText: "Phone number",
                  fillColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: app_color,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: app_color, width: 0.0),
                  ),
                  labelStyle: TextStyle(fontSize: 18.0, color: app_color),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(color: Colors.blue),
                  ),
                ),
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),

            SizedBox(
              height: 10.0,
            ),


            Container(
              height: 45,
              child: TextField(
                controller: contact_mobile,
                decoration: new InputDecoration(
                  labelText: "Mobile",
                  fillColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  prefixIcon: Icon(
                    Icons.mobile_screen_share_sharp,
                    color: app_color,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: app_color, width: 0.0),
                  ),
                  labelStyle: TextStyle(fontSize: 18.0, color: app_color),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(color: Colors.blue),
                  ),
                ),
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
//            SizedBox(
//              height: 30.0,
//            ),

          ],
        ),
      ),

      actions: [
        GestureDetector(
          onTap: () {
     if(contact_email.text.isEmpty && contact_email.text.isEmpty && contact_phone.text.isEmpty){
       _debouncer.run(() async {
         no_data_present=false;
         setState(() {
           contact_list = [];
           contact_mobile.clear();
           contact_phone.clear();
           contact_email.clear();
           searchtxt.clear();
           onsearch = false;
           filter_flag = false;
         });
         await Contact_manager(isReload: true);
         setState(() {});
       });


     }
     else{
       _debouncer.run(() async {
         setState(() {
           filter_flag = true;
           if (contact_list.isNotEmpty) {
             contact_list = [];
           }

           con_email = contact_email.text;
           con_mobile =contact_mobile.text;
           con_phone = contact_phone.text;
         });

         Contact_filter_manager(
           isReload: true,
           con_email : contact_email.text,
           con_mobile :contact_mobile.text,
           con_phone : contact_phone.text,
         );
         setState(() {});
       });

     }
            Navigator.of(context).pop();
          },
          child: Center(
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  color: app_color,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: Text(
                  'Apply'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );


    return SafeArea(
      child
          : Scaffold(
          floatingActionButton: home_button(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: background_view_color,
          appBar:PreferredSize(
            preferredSize: const Size.fromHeight(95.0),
            child: Container(
              color: app_color,
              child: Column(

                children: [
                  SizedBox(height: 10.0,),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        global_back_button(context),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.83,
                              child:  TextField(
                                onChanged: (value) {
                                  _debouncer.run(() async {
                                    no_data_present=false;
                                    setState(() {
                                      if (contact_list.isNotEmpty) {
                                        contact_list = [];
                                      }
                                      onsearch = true;
                                    });
                                    await Contact_manager_onsearch(
                                      isReload: true,
                                      word: value.toLowerCase(),
                                    );
                                    setState(() {});
                                  });
                                },
                                controller: searchtxt,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 5.0, right: 30.0, top: 10.0, bottom: 10.0),
                                  prefixIcon:  Icon(
                                    Icons.search_outlined,
                                    color: Colors.grey,
                                  ),
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  fillColor: w_color,
                                  filled: true,
                                  hintText: "By name or business name",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "poppins",
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              )

                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.12),


                        GestureDetector(
                          onTap: () async {
                            Get.to(add_contact());
                          },
                          child: add_button(context),
                        ),

                        Container(width: MediaQuery.of(context).size.width * 0.01),

                        GestureDetector(
                          onTap: () async {
                            _debouncer.run(() async {
                              no_data_present=false;
                              setState(() {
                                contact_list = [];
                                contact_mobile.clear();
                                contact_phone.clear();
                                contact_email.clear();
                                searchtxt.clear();
                                onsearch = false;
                                filter_flag = false;
                              });
                              await Contact_manager(isReload: true);
                              setState(() {});
                            });

                          },
                          child: refresh_button(context),
                        ),
                        Container(width: MediaQuery.of(context).size.width * 0.01),

                        GestureDetector(
                          onTap: () {
                            searchtxt.clear();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Filter;
                              },
                            );
                          },
                          child: filter_button(context),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          body: body_layout()
      ),
    );
  }


  body_layout() {
    return SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        enablePullDown: false,
        onRefresh: () async {
          if (filter_flag == true) {
            final result = await Contact_filter_manager(
                isReload: true,
                con_email : contact_email.text,
                con_mobile :contact_mobile.text,
                con_phone : contact_phone.text);
            print(result);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          } else if (onsearch == false && filter_flag == false) {
            final result = await Contact_manager(isReload: true);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          } else if (onsearch == true && filter_flag == false) {
            final result = await Contact_manager_onsearch(
                isReload: true, word: searchedWord);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          }
        },
        onLoading: () async {
          if (filter_flag == true) {
            final result = await Contact_filter_manager(
                con_email : contact_email.text,
                con_mobile :contact_mobile.text,
                con_phone : contact_phone.text);
            print(result);
            if (result != null && result.isNotEmpty) {
              _refreshController.loadComplete();
            } else {
              print("failed");
              _refreshController.loadFailed();
              Message();
            }
          } else if (onsearch == false && filter_flag == false) {
            var result = await Contact_manager();
            if (result != null && result.isNotEmpty) {
              _refreshController.loadComplete();
            } else {
              _refreshController.loadFailed();
              Message();
            }
          } else if (onsearch == true && filter_flag == false) {
            final result =
            await Contact_manager_onsearch(word: searchedWord);
            print(result);
            if (result != null && result.isNotEmpty) {
              _refreshController.loadComplete();
            } else {
              print("failed");
              _refreshController.loadFailed();
              Message();
            }
          }
        },
        child:  (no_data_present==true && contact_list.isEmpty)?
        my_nodata():contact_list.isNotEmpty
            ? ListView.builder(
            itemCount: contact_list == null ? 0 : contact_list.length,
            itemBuilder: (context, index) {
              print(contact_list.length);
              var list = contact_list[index];

//              String time= DateFormat("HH:mm:ss").format(list.start);
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => detailview_contact(
                            list.id!=null
//                                ||list.id.isNotEmpty
                                ?list.id:"",
                            list.name!=null?
//                            ||list.name.isNotEmpty?
                            list.name:"",
                            list.business!=null
//                                ||list.business.isNotEmpty
                                ?list.business:"",
                          list.city!=null
//                              ||list.city.isNotEmpty
                              ?list.city:"",
                          list.email!=null
//                              ||list.email.isNotEmpty
                              ? list.email:"",
                          list.mobile!=null
//                              ||list.mobile.isNotEmpty
                              ?list.mobile:"",
                          list.phone!=null
//                              ||list.phone.isNotEmpty
                              ?list.phone:"",
                          list.image1!=null
//                              ||list.image1.isNotEmpty
                              ?list.image1:"", list.image2!=null||list.image2.isNotEmpty?list.image2:"",
                          )));

                },
                child: Padding(
                  padding: const EdgeInsets.only(left:5.0,right: 10.0,top: 10.0,bottom: 10.0),
                  child: Container(
                      color: card_color,
                      height:165,
                      child: Row(
                        children: [

                          Container(
                            height: 165,
                            width:80,

                            child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                SizedBox(
                                  height: 5.0,
                                ),

                                ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),

                                child: FadeInImage(
                                   height: 70,
                                   width: 70,
                                  image: NetworkImage(http_root+contact_image_path+list.image1),
                                  placeholder: AssetImage("Assets/hover.gif",),
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                        'Assets/hover.gif',
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.fitWidth);
                                  },
                                  fit: BoxFit.fitWidth,
                                ),
                           ),
//
                           SizedBox(
                             height: 15.0,
                           ),


                           ClipRRect(
                             borderRadius: BorderRadius.circular(10.0),
                             child: FadeInImage(
                           height: 70,
                           width: 70,
                               image: NetworkImage(http_root+contact_image_path+list.image2,
                               ),
                               placeholder: AssetImage("Assets/hover.gif",),
                               imageErrorBuilder: (context, error, stackTrace) {
                                 return Image.asset(
                                     'Assets/hover.gif',
                                     height: 70,
                                     width: 70,
                                     fit: BoxFit.fitWidth);
                               },
                               fit: BoxFit.fitWidth,
                             ),
                           ),


                                SizedBox(
                                  height: 5.0,
                                ),

                              ],
                            ),
                          ),

                          SizedBox(
                            width: 5.0,
                          ),

                          Material(
                              elevation: 10.0,
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width-100,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:8.0,bottom:6.0,left: 10.0,right: 8.0),
                                  child: Column(
                                    children: [


                                      business_name(context, list.business==null ?"  ":list.business.replaceAll('-', ' ').toString(),),

                                      SizedBox(height: 2.0,),

                                       name(context,list.name==null?" ":list.name,),


                                      SizedBox(
                                        height: 2.0,
                                      ),

                                      email(context,list.email==null?" ":list.email,),

                                      SizedBox(
                                        height: 2.0,
                                      ),

                                      city(context,list.city==null?" ":list.city,),

                                      SizedBox(
                                        height: 2.0,
                                      ),

                                      phone(context,list.phone==null?" ":list.phone,),

                                      SizedBox(
                                        height: 2.0,
                                      ),


                                      phone(context,list.mobile==null?" ":list.mobile,),

                                      SizedBox(
                                        height: 10.0,
                                      ),


                                      id(list.id, true),



                                    ],
                                  ),
                                ),
                              )),
                        ],
                      )
                  ),
                ),
              );
            })
            : myrefresher(),
    );
  }
}
//Padding(
//                  padding: const EdgeInsets.all(10.0),
//                  child: Material(
//                    elevation: 10.0,
//                    borderRadius: BorderRadius.circular(10.0),
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Container(
//                        color:card_color,
//                        height: card_height,
//                        child: Row(
//                          children: [
//                       Expanded(
//                         flex: 3,
//                         child: Column(
//                           children: [
//
//                             Expanded(
//                               flex: 1,
//                               child: Align(
//                                 alignment: Alignment.topLeft,
//                                 child: ID_button(
//                                     null,
//                                     null,
//                                     list.id!=null
////                                         ||list.id.isNotEmpty
//                                         ?list.id:"",
//                                     8.0,
//                                     Colors.white,
//                                     blue_color),
//                               ),
//                             ),
//
//                             SizedBox(
//                               height: 5.0,
//                             ),
//
//
//                             Expanded(
//                               flex: 3,
//                               child:ClipRRect(
//                               borderRadius: BorderRadius.circular(10.0),
//
//                               child: FadeInImage(
//                             height: 120,
//                             width: 120,
//                                 image: NetworkImage(http_root+contact_image_path+list.image1),
//                                 placeholder: AssetImage("Assets/hover.gif",),
//                                 imageErrorBuilder: (context, error, stackTrace) {
//                                   return Image.asset(
//                                       'Assets/hover.gif',
//                                   height: 120,
//                                   width: 120,
//                                       fit: BoxFit.fitWidth);
//                                 },
//                                 fit: BoxFit.fitWidth,
//                               ),
//                             ),),
//
//
//
//                             SizedBox(
//                               height: 5.0,
//                             ),
//
//
//                             Expanded(
//                               flex: 3,
//                               child:            ClipRRect(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 child: FadeInImage(
//                               height: 120,
//                               width: 120,
//                                   image: NetworkImage(http_root+contact_image_path+list.image2,
//                                   ),
//                                   placeholder: AssetImage("Assets/hover.gif",),
//                                   imageErrorBuilder: (context, error, stackTrace) {
//                                     return Image.asset(
//                                         'Assets/hover.gif',
//                                     height: 120,
//                                     width: 120,
//                                         fit: BoxFit.fitWidth);
//                                   },
//                                   fit: BoxFit.fitWidth,
//                                 ),
//                               ),)
//
//
//                           ],
//
//                         ),
//                       ),
//
//
//
//                            SizedBox(
//                              width: 10.0,
//                            ),
//                            Expanded(
//
//                              flex: 7,
//                              child: Container(
//                                height: card_height,
//                                child: Column(
//                                  children: [
//
//                                    Expanded(
//                                      flex: 2,
//                                      child: Align(
//                                        alignment: Alignment.topLeft,
//                                        child: Container(
////                                              width: MediaQuery.of(context).size.width * 0.6,
//                                          height: null,
//                                          child: Text(
//                                            list.name==""?"No Name":list.name
//                                                .replaceAll('-', ' ')
//                                                .toString(),
//                                            maxLines: 2,
//                                            overflow: TextOverflow.ellipsis,
//                                            style: RowStyle_grey(12.0),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//
//                                    SizedBox(
//                                      height: 4.0,
//                                    ),
//
//                                    Expanded(
//                                      flex: 1,
//                                      child: Align(
//                                        alignment: Alignment.topLeft,
//                                        child: Container(
////                                              width: MediaQuery.of(context).size.width * 0.6,
//                                          height: null,
//                                          child: Text(
//                                            list.business==""?"No Business Name":list.business
//                                                .replaceAll('-', ' ')
//                                                .toString(),
//                                            maxLines: 1,
//                                            overflow: TextOverflow.ellipsis,
//                                            style: RowStyle_grey(10.0),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//
//                                    SizedBox(
//                                      height: 4.0,
//                                    ),
//
//                                    Expanded(
//                                      flex: 1,
//                                      child: email_button(
//                                          MediaQuery.of(context).size.width,
//                                          null,
//                                          list.email==""?"No Email":list.email,
//                                          8.0,
//                                          Colors.white,
//                                          blue_color),
//                                    ),
//
//                                    SizedBox(
//                                      height: 4.0,
//                                    ),
//
//                                    Expanded(
//                                      flex: 1,
//                                      child: button(
//                                          MediaQuery.of(context).size.width,
//                                        null,
//                                        list.city==""?"NO city Name":list.city,
//                                        8.0,
//                                        Colors.white,
//                                        blue_color),
//                                    ),
//
//                                    SizedBox(
//                                      height: 4.0,
//                                    ),
//
//                                    Expanded(
//                                      flex: 1,
//                                      child: phone_button(
//                                          MediaQuery.of(context).size.width,
//                                          null,
//                                          list.mobile==""?"No Moible Number":list.mobile,
//                                          8.0,
//                                          Colors.white,
//                                          blue_color),
//                                    ),
//
//                                    SizedBox(
//                                      height: 4.0,
//                                    ),
//
//                                    Expanded(
//                                      flex: 1,
//                                      child: phone_button(
//                                          MediaQuery.of(context).size.width,
//                                          null,
//                                          list.phone==""?"No phone no":list.phone,
//                                          8.0,
//                                          Colors.white,
//                                          blue_color),
//                                    ),
//
//
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                ),