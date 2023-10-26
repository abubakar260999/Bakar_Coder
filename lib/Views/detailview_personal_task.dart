import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Model/appointments.dart';
import 'package:triple_n/Model/users.dart';
import 'package:triple_n/Service/add_comment.dart';
import 'package:triple_n/Service/update_status.dart';
import 'package:triple_n/Views/view_personal_task.dart';
import 'package:triple_n/Views/view_task.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:triple_n/Authetication/storage.dart';
import 'package:triple_n/Service/user_profile.dart';

class detailview_personal_task extends StatefulWidget {
  @override
  final String id;
  final String Assigned_by;
  final String Assigned_to;
  final String priority;
  final String subject;
  final String description;
  DateTime date_start;
  DateTime date_end;
  final String status;
  List<String> task_files;

  //if you have multiple values add here
  detailview_personal_task(
      this.id,
      this.Assigned_by,
      this.Assigned_to,
      this.priority,
      this.subject,
      this.description,
      this.date_start,
      this.date_end,
      this.status,
      this.task_files,
      {Key key})
      : super(key: key);

  _detailview_personal_taskState createState() => _detailview_personal_taskState();
}

class _detailview_personal_taskState extends State<detailview_personal_task> {
  @override

  bool comment_on = false;
  TextEditingController comment = TextEditingController();
  ScrollController postion=ScrollController();
  var email;
  String user_id;
  List<Users> user_data_list = [];

  Future get_email() async {
    email = await usesecurestorage.read_data();
    email="abubakar@abconline.us";
    setState(() {});
    print(email);
  }

  Future get_data() async {
    get_email().whenComplete(() async {
      user_data_list = await data.users(email);
      setState(() {
        user_id = user_data_list[0].id;
      });
    });
  }


  bool status_on = false;
  var status;
//  TextEditingController status_controller = TextEditingController();


  var status_list = [
    "Just Started",
    "Continue",
    "Updated",
    "Complete",
    "Under Review",
    "Waiting",
  ];
  Widget build(BuildContext context) {
    var previos_status=widget.status;
//    var Comment=widget.comment;
    print(widget.task_files);
    String start_date =
    DateFormat("dd-MM-yyyy").format(widget.date_start).toString();
    String end_date =
    DateFormat("dd-MM-yyyy").format(widget.date_end).toString();
    String start_time = DateFormat.Hm().format(widget.date_start).toString();
    String end_time = DateFormat.Hm().format(widget.date_end).toString();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.0,
            backgroundColor: Colors.white,
//        elevation: 6.0,
            leading: Back_button(Colors.black),

            title: Text(
              "Tickets",
              style: RowStyle_black(20.0),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 10.0, top: 20.0),
            child: ListView(
              children: [
                ListTile(
                  leading: Text(
                    "Id",
                    style: RowStyle_black_bold(12.0),
                  ),
                  title: Center(
                      child: Text(
                        widget.id,
                        style: RowStyle_black(12.0),
                      )),
                  trailing: Icon(
                    CupertinoIcons.number,
                    size: 20.0,
                  ),
                ),

                Divider(),
                ListTile(
                  leading: Text(
                    "Subject",
                    style: RowStyle_black_bold(12.0),
                  ),
                  title: Center(
                      child: Text(
                        widget.subject,
                        textAlign: TextAlign.center,
                        style: RowStyle_black(12.0),
                      )),
                  trailing: Icon(
                    Icons.subject,
                    size: 20.0,
                  ),
                ),

                Divider(),
                ListTile(
                  leading: Text(
                    "Assigned by",
                    style: RowStyle_black_bold(12.0),
                  ),
                  title: Center(
                      child: Text(
                        widget.Assigned_by,
                        style: RowStyle_black(12.0),
                      )),
                  trailing: Icon(
                    Icons.person_outline,
                    size: 20.0,
                  ),
                ),

                Divider(),
                ListTile(
                  leading: Text(
                    "Assigned To",
                    style: RowStyle_black_bold(12.0),
                  ),
                  title: Center(
                      child: Text(
                        widget.Assigned_to,
                        style: RowStyle_black(12.0),
                      )),
                  trailing: Icon(
                    Icons.person_outline,
                    size: 20.0,
                  ),
                ),

                Divider(),
                ListTile(
                  leading: Text(
                    "Start From",
                    style: RowStyle_black_bold(12.0),
                  ),
                  title: Center(
                      child: Text(
                        start_date + "   " + start_time,
                        style: RowStyle_black(12.0),
                      )),
                  trailing: Icon(
                    Icons.access_time,
                    size: 20.0,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text(
                    "End At",
                    style: RowStyle_black_bold(12.0),
                  ),
                  title: Center(
                      child: Text(
                        end_date + "   " + end_time,
                        style: RowStyle_black(12.0),
                      )),
                  trailing: Icon(
                    Icons.access_time,
                    size: 20.0,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text(
                    "Priority",
                    style: RowStyle_black_bold(12.0),
                  ),
                  title: Center(
                      child: Text(
                        widget.priority,
                        style: RowStyle_black(12.0),
                      )),
                  trailing: Container(
                    height: 20,
                    width: 20,
                    color: parsePriorityIntoColor(widget.priority),
                  ),
                ),
                Divider(),

                ListTile(
                  leading: Text(
                    "Description",
                    style: RowStyle_black_bold(12.0),
                  ),
                  title: Center(
                      child: Text(
                        widget.description,
                        textAlign: TextAlign.center,
                        style: RowStyle_black(12.0),
                      )),
                  trailing: Icon(
                    Icons.description_outlined,
                    size: 20.0,
                  ),
                ),
                Divider(),

                ListView.builder(
//                    physics: NeverScrollableScrollPhysics(),
//                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.task_files.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var url = http_root +
                                task_files_path +
                                widget.task_files[index];
                            if (await canLaunch(url) != null) {
                              await launch(url);
                            } else {
                              files_error();
                              throw 'Could not launch $url';
                            }
                          },
                          child: ListTile(
                            leading: Text(
                              "Files",
                              style: RowStyle_black_bold(12.0),
                            ),
                            title: Center(
                                child: Text(
                                  widget.task_files[index],
                                  textAlign: TextAlign.center,
                                  style: RowStyle_black(12.0),
                                )),
                            trailing: Icon(
                              Icons.description_outlined,
                              size: 20.0,
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),


                //status

                ListTile(
                  leading: Text(
                    "Status ",
                    style: RowStyle_black_bold(12.0),
                  ),
                  title: Center(
                      child: Text(
//                        widget.status,
                        previos_status,
                        style: RowStyle_black(12.0),
                      )),

                  trailing:GestureDetector(
                    onTap: (){

                      status_on=true;
                      setState(() {});
                    },
                    child: Icon(
                      Icons.edit_outlined,
                      color: Colors.black,
                      size: 24.0,
                    ),
                  ),

                ),


                SizedBox(
                  height: 10.0,
                ),


                Visibility(
                  visible: status_on,
                  child: Column(
                    children: [
                      DropdownButtonFormField(

                        decoration: InputDecoration(

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: app_color, width: 0.0),
                          ),
//                      errorText: "",
                          errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(color: app_color),
                          ),
                        ),
                        hint: status == null
                            ? Text(
                          'Status',
                          style: TextStyle(color: app_color),
                        )
                            : Text(
                          status,
                          style: TextStyle(color: app_color),
                        ),
                        isExpanded: true,
                        iconEnabledColor: app_color,
                        iconDisabledColor: app_color,
                        iconSize: 30.0,
                        style: TextStyle(color: app_color),
                        items: status_list.map(
                              (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                                () {
                              status = val;
                            },
                          );
                        },
                      ),


                      SizedBox(height: 10.0,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {

                            setState(() {
                              status_on=false;
                              previos_status=status;
                            });

                            Services_update.update_status(widget.id,status).then((value){
                              if(value.isNotEmpty)
                              {
                                any_data_show('Status Updated');

                              }
                            });
                            Get.back();
                            Get.off(view_task());

//                            else{
//                              any_data_show('No status yet');
//
//                            }
                          },
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              color: app_color,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Center(
                              child: Text(
                                'Update'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 15.0,
                ),


                //alag

                ///aldg



                SizedBox(
                  height: 20.0,
                ),

                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.task_files.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        tileColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
//                        leading: Text("username",style: RowStyle_black_bold(12.0),),

                        title: Text(
                          "username",
                          style: RowStyle_black_bold(12.0),
                        ),

                        subtitle: Text(
                          widget.task_files[index],
                          style: RowStyle_black(14.0),
                        ),

                        trailing: Text(
                          "12-08-2022",
                          style: RowStyle_black_bold(12.0),
                        ),
                      ),
                    );
                  },
                ),


                //comments

                Row(
                  children: [
                    Text(
                      "Comments",
                      textAlign: TextAlign.left,
                      style: RowStyle_black_bold(16.0),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {


                        if(comment_on==false){
                          setState(() {
                            comment_on = true;
                          });


                        }

                      },
                      child: Icon(
                        Icons.add_outlined,
                        color: Colors.black,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10.0,
                ),




                Visibility(
                  visible: comment_on,
                  child: Column(
                    children: [
                      TextField(

                        controller: comment,
//                    onChanged: (text) {
//                      setState(() {
//                        task_description = text;
//                      });
//                    },

                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: null,
                        decoration: new InputDecoration(
                          labelText: "Comment",
                          fillColor: Colors.white,
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: 12.0),
                          prefixIcon: Icon(
                            Icons.description,
                            color: app_color,
                          ),
//                      enabledBorder: OutlineInputBorder(
//                        borderSide: BorderSide(color: app_color, width: 0.0),
//                      ),
                          labelStyle:
                          TextStyle(fontSize: 14.0, color: app_color),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(color: Colors.blue),
                          ),
                        ),
                        style: new TextStyle(
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            if (comment.text.isNotEmpty) {
                              setState(() {

                                Services.add_comment(
                                  widget.id,
                                  user_id,
                                  comment.text,
                                );

                                if(comment_on==true){
                                  comment_on = false;
                                }

                              });
                            }
                            else{
                              any_data_show('No Comment yet');

                            }
                          },
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              color: app_color,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Center(
                              child: Text(
                                'Done'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10.0,
                      ),

                    ],
                  ),
                ),


              ],
            ),
          )),
    );
  }
}
