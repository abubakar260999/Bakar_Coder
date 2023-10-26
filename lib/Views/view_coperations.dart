import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Model/Companies.dart';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Views/detailview_coperations.dart';
import 'package:triple_n/Widget/cooperation_widget.dart';
import 'package:triple_n/Widget/global_button.dart';
import 'package:url_launcher/url_launcher.dart';



class view_coperation extends StatefulWidget {
  @override
  _view_coperationState createState() => _view_coperationState();
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

class _view_coperationState extends State<view_coperation> {
  @override


  Widget showbar = view_appbar_txt("Cooperation");

  final RefreshController _refreshController = RefreshController(initialRefresh: true);
  List<Companies> company_list = [];
  int current_page = 0, current_search_page = 0;
  String searchedWord = "";

  final TextEditingController searchtxt = TextEditingController();
  final TextEditingController company_title = TextEditingController();
  final TextEditingController company_email = TextEditingController();
  final TextEditingController company_phone = TextEditingController();
  String comp_title = "";
  String comp_email = "";
  String comp_phone = "";
  bool onsearch = false;
  bool filter_flag =false;
  int current_filter_page = 0;
  bool no_data_present=false;

  onstart() async {
    await Company_manager(isReload: true);
  }

  void initState() {
    super.initState();
    filter_flag = false;
    onstart();
  }

  //simple data
  Future<List<Companies>> Company_manager({bool isReload = false}) async {
    try {
      if (isReload) {
        current_page = 0;
      }

      String flag = "onstart";
      String url = http_root + "companies.php?page_no=$current_page&size=20&flag=$flag";

      final response = await http.get(url);
      List<Companies> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        print(parsed.map<Companies>((json) => Companies.fromJson(json)).toList());
        result = parsed.map<Companies>((json) => Companies.fromJson(json)).toList();


//        if (result != null && result.isNotEmpty) {
          company_list.addAll(result);
          current_page++;
//        }
        setState(() {
          if(company_list==[] || company_list.isEmpty)
          {
            no_data_present=true;
          }});
        return result;
      }
//      else {
//        return <Companies>[];
//      }
    } catch (e) {
      return <Companies>[];
    }
  }

//searched data
  Future<List<Companies>> Company_manager_onsearch(
      {bool isReload = false, String word}) async {
    try {
      if (isReload) {
        current_search_page = 0;
      }
      String flag = "onsearch";
      String url = http_root + "companies.php?page_no=$current_search_page&size=5&word=$word&flag=$flag";

      final response = await http.get(url);
      List<Companies> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        result = parsed.map<Companies>((json) => Companies.fromJson(json)).toList();

//        if (result != null && result.isNotEmpty) {
          this.searchedWord = word;
          current_search_page++;
          company_list.addAll(result);
          setState(() {
            if(company_list==[] || company_list.isEmpty)
            {
              no_data_present=true;
            }
          });
//        }
//        if (result != null && result.isNotEmpty) {
          return result;
        }
//      } else {
//        return <Companies>[];
//      }
    } catch (e) {
      return <Companies>[];
    }
  }


  Future<List<Companies>> Company_filter_manager(
      {bool isReload = false, String title, String email, String phoneno}) async {
    try {
      if (isReload) {
        current_filter_page = 0;
      }


      String flag = "onfilter";
      String url = http_root + "companies.php?page_no=$current_filter_page&size=20&title=$title&email=$email&phone=$phoneno&flag=$flag";
      final response = await http.get(url);
      List<Companies> result = [];
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        result = parsed
            .map<Companies>((json) => Companies.fromJson(json))
            .toList();

        print(result);
//        if (result != null && result.isNotEmpty) {
//          this.app_name = company_name.text;
//          this.app_date=appintment_date.text;
//          this.app_phno=company_phoneno.text;
          current_filter_page++;
          company_list.addAll(result);
          setState(() {
            if(company_list==[] || company_list.isEmpty)
          {
            no_data_present=true;
          }});

          return result;
//        } else {
//          return <Companies>[];
//        }
      }
    } catch (e) {
      return <Companies>[];
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
        height:170,
        child: Column(
          children: [
            Container(
              height: 45,
              child: new TextField(
                controller: company_title,
                decoration: new InputDecoration(
                  labelText: "Company address",
                  fillColor: Colors.white,
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  prefixIcon: Icon(
                    Icons.business_outlined,
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
            //phone
            Container(
              height: 45,
              child: TextField(
                controller: company_email,
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

            SizedBox(
              height: 10.0,
            ),

            //phone
            Container(
              height: 45,
              child: TextField(
                controller: company_phone,
                decoration: new InputDecoration(
                  labelText: "Phone number",
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


//            SizedBox(
//              height: 30.0,
//            ),

          ],
        ),
      ),

      actions: [
        GestureDetector(
          onTap: () {
          if(company_title.text.isEmpty && company_email.text.isEmpty && company_phone.text.isEmpty){

            _debouncer.run(() async {
              setState(() {
                no_data_present=false;
                company_list = [];
                searchtxt.clear();
                onsearch = false;
                filter_flag = false;
              });
              await Company_manager(isReload: true);
              setState(() {});
            });

          }
          else{
            _debouncer.run(() async {

              setState(() {
                filter_flag = true;
                if (company_list.isNotEmpty) {
                  company_list = [];
                }

                comp_title = company_title.text;
                comp_email = company_email.text;
                comp_phone = company_phone.text;
              });

              Company_filter_manager(
                  isReload: true,
                  title: company_title.text,
                  email: company_email.text,
                  phoneno: company_phone.text);
              setState(() {});
            });

          }

//            company_title.clear();
//            company_email.clear();
//            company_phone.clear();

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
      child: Scaffold(
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
                                    setState(() {
                                      no_data_present=false;
                                      if (company_list.isNotEmpty) {
                                        company_list = [];
                                      }
                                      onsearch = true;
                                    });
                                    await Company_manager_onsearch(
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
                                  hintText: "By Owner name or group of company",
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
                            _debouncer.run(() async {
                              setState(() {
                                no_data_present=false;
                                company_list = [];
                                searchtxt.clear();
                                onsearch = false;
                                filter_flag = false;
                              });
                              await Company_manager(isReload: true);
                              setState(() {});
                            });

                          },
                          child: refresh_button(context),
                        ),


                        Container(
                            width: MediaQuery.of(context).size.width * 0.3),

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
            final result = await Company_filter_manager(
                isReload: true,
                title: company_title.text,
                email: company_email.text,
                phoneno: company_phone.text);
            print(result);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          } else if (onsearch == false && filter_flag == false) {
            final result = await Company_manager(isReload: true);
            if (result != null && result.isNotEmpty) {
              _refreshController.refreshCompleted();
            } else {
              _refreshController.refreshFailed();
            }
          } else if (onsearch == true && filter_flag == false) {
            final result = await Company_manager_onsearch(
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
            final result = await Company_filter_manager(
                title: company_title.text,
                email: company_email.text,
                phoneno: company_phone.text);
            print(result);
            if (result != null && result.isNotEmpty) {
              _refreshController.loadComplete();
            } else {
              print("failed");
              _refreshController.loadFailed();
              Message();
            }
          } else if (onsearch == false && filter_flag == false) {
            var result = await Company_manager();
            if (result != null && result.isNotEmpty) {
              _refreshController.loadComplete();
            } else {
              _refreshController.loadFailed();
              Message();
            }
          } else if (onsearch == true && filter_flag == false) {
            final result =
            await Company_manager_onsearch(word: searchedWord);
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
        child:  (no_data_present==true && company_list.isEmpty)?
        my_nodata():company_list.isNotEmpty
            ? ListView.builder(
            itemCount: company_list == null ? 0 : company_list.length,
            itemBuilder: (context, index) {
              print(company_list.length);


              var list = company_list[index];

//              String time= DateFormat("HH:mm:ss").format(list.start);
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => detailview_coperation(
                              list.id !=null?list.id:" ",
                              list.yearend!=null?list.yearend:" ",
                              list.companyTitle!=null?list.companyTitle:" ",
                              list.ownerFirstName +list.ownerLastName !=null?list.ownerFirstName +"   "+list.ownerLastName:" ",
                              list.groupOfCompanies !=null?list.groupOfCompanies:" ",
                              list.companyEmail !=null?list.companyEmail:" ",
                              list.companyContact!=null?list.companyContact:" ",
                            list.ein!=null?list.ein:" ",
                            list.companyFax !=null?list.companyFax:" ",
                            list.companyInsurance!=null?list.companyInsurance:" ",
                            list.companyPayroll!=null?list.companyPayroll:" ",
                            list.companyLicense!=null?list.companyLicense:" ",
                            list.companySalestax!=null?list.companySalestax:" ",
                            list.businessType!=null?list.businessType:" ",
                            list.companyStatus!=null?list.companyStatus:" ",
                            list.dateOfIncorporation!=null?list.dateOfIncorporation:" ",
                            list.lastfilingDate!=null?list.lastfilingDate:" ",
                            list.companyWebsite!=null?list.companyWebsite:" ",
                            list.createdBy!=null?list.createdBy:" ",
                            list.createdOn!=null?list.createdOn:" ",
                          )));

                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      color: card_color,
                      height:160,
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              height: 120,
                              width:70,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 130,
                                  width: 4,
                                  decoration: BoxDecoration(
                                    color: (int.parse(list.id)%2) ==0? Color(0xff00C6F8):Color(0xffFFFF00),

                                  ),
                                ),
                              ),
                            ),
                          ),


                          Material(
                              elevation: 10.0,
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width-90,
                                child: Padding(
                                  padding: const EdgeInsets.only(top:8.0,bottom:6.0,left: 20.0,right: 8.0),
                                  child: Column(
                                    children: [


                                      Company_title(context, list.companyTitle.toString() == null ? "  ":list.companyTitle.toString()),

                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      group_of_company(context,list.groupOfCompanies==null?" ":list.groupOfCompanies,),


                                      SizedBox(height: 2.0,),

                                      owner_name(context,list.ownerFirstName==null || list.ownerLastName==null?" ":list.ownerFirstName+" "+list.ownerLastName,),


                                  SizedBox(
                                    width: 2.0,
                                  ),
                                     email(context,list.companyEmail==null ?"" :list.companyEmail),

                                      SizedBox(
                                        height: 2.0,
                                      ),

                                      phone(context,list.companyContact==null ?"" :list.companyContact),

                                      SizedBox(
                                        height: 2.0,
                                      ),

                                      yearend(context,list.yearend==null ?"" :list.yearend),


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
//                      padding: const EdgeInsets.all(10.0),
//                      child: Container(
//                        color: card_color,
//                        height: card_height,
//                        child: Row(
//                          children: [
//                           Expanded(
//                             flex: 2,
//                             child: Column(
//                               children: [
//
//                                 Expanded(
//                                   flex: 1,
//                                   child: ID_button(
//                                       null,
//                                       null,
//                                       list.id,
//                                       8.0,
//                                       Colors.white,
//                                       blue_color),
//                                 ),
//
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//
//                                 Expanded(
//                                   flex: 2,
//                                   child: cooperation_file_button(
//                                       null,
//                                       null,
//                                       "Documents",
//                                       8.0,
//                                       Colors.white,
//                                       blue_color),
//                                 ),
//
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//
//
//                                 Expanded(
//                                   flex: 1,
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: button(
//                                         null,
//                                         null,
////                                         list.yearend=="" ||
//                                             list.yearend==null?"NO Year End":list.yearend,
//                                         8.0,
//                                         Colors.white,
//                                         blue_color),
//
//                                   ),
//                                 ),
//
//
//
//                               ],
//                             ),
//                           ),
//
//                            SizedBox(
//                              width: 10.0,
//                            ),
//                            Expanded(
//
//                              flex: 8,
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
////                                            list.companyTitle=="" ||
//                                                list.companyTitle==null?"":list.companyTitle,
//                                            maxLines: 2,
//                                            overflow: TextOverflow.ellipsis,
//                                            style: RowStyle_grey(13.0),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//
//                                    SizedBox(
//                                      height: 5.0,
//                                    ),
//
//                                    Expanded(
//                                      flex:1,
//                                      child: cooperation_name_button(MediaQuery.of(context).size.width, null,list.ownerFirstName==null||list.ownerFirstName==""?"No Name":list.ownerFirstName +"   "+list.ownerLastName, 10.0,
//                                          Colors.white, blue_color),
//                                    ),
//
//                                    SizedBox(
//                                      height: 5.0,
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
////                                            list.groupOfCompanies==""||
//                                          list.groupOfCompanies==null?"No Group of company":list.groupOfCompanies,
//                                            maxLines: 1,
//                                            overflow: TextOverflow.ellipsis,
//                                            style: RowStyle_grey(10.0),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//
//                                    SizedBox(
//                                      height: 5.0,
//                                    ),
//
////                     Expanded(
////                       flex: 1,
////                       child: Row(
////                         children: [
////                           Expanded(
////                             flex: 3,
////                             child: button(
////                                 null,
////                                 null,
////                                 list.ownerFirstName=="" || list.ownerFirstName==null?"No Name":list.ownerFirstName,
////                                 8.0,
////                                 Colors.white,
////                                 blue_color),
////                           ),
////
////                           Spacer(),
////                           Expanded(
////                             flex: 7,
////                             child: phone_button(
////                                 null,
////                                 null,
////                                 list.companyContact=="" || list.companyContact==null?"No phone no":list.companyContact,
////                                 8.0,
////                                 Colors.white,
////                                 blue_color),
////                           ),
////                         ],
////                       ),
////                     ),
//
//                                    Expanded(
//                                      flex: 1,
//                                      child: email_button(
//                                          MediaQuery.of(context).size.width,
//                                          null,
////                                          list.companyEmail==""||
//                                              list.companyEmail==null?"No Email":list.companyEmail,
//                                          8.0,
//                                          Colors.white,
//                                          blue_color),
//                                    ),
//
//                                    SizedBox(
//                                      height: 5.0,
//                                    ),
//                                    Expanded(
//                               flex: 1,
//                               child: phone_button(
//                                         MediaQuery.of(context).size.width,
//                                         null,
////                                         list.companyContact=="" ||
//                                             list.companyContact==null?"No phone no":list.companyContact,
//                                         8.0,
//                                         app_color,
//                                         blue_color),
//                             )
//
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