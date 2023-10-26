import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Global/paths.dart';
//import 'package:triple_n/Global/status_global.dart';
import 'package:triple_n/Model/appointments.dart';
import 'package:triple_n/Model/comment.dart';
import 'package:triple_n/Model/users.dart';
import 'package:triple_n/Service/add_comment.dart';
import 'package:triple_n/Service/get_comment.dart';
import 'package:triple_n/Service/update_status.dart';
import '../Widget/task_widget.dart';
import 'package:triple_n/Views/view_personal_task.dart';
import 'package:triple_n/Views/view_task.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:triple_n/Authetication/storage.dart';
import 'package:triple_n/Service/user_profile.dart';

class detailview_task extends StatefulWidget {
  @override
  final String id;
  final String Assigned_by;
  List<String> Assigned_to;
  final String priority;
  final String subject;
  final String description;
  DateTime date_start;
  DateTime date_end;
 String status;
  List<String> task_files;

  //if you have multiple values add here
  detailview_task(
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

  _detailview_taskState createState() => _detailview_taskState();
}

class _detailview_taskState extends State<detailview_task> {
  @override

//  final status_value = Get.put(update_status());


  bool comment_on = false;
  TextEditingController comment = TextEditingController();
  ScrollController postion=ScrollController();
  var email;
  var roler;
  String user_id;
  List<Users> user_data_list = [];


//  Future get_email() async {
//
////    email="abubakar@abconline.us";
//
//    setState(() {});
//    print(email);
//  }

  Future get_data() async {
    email = await usesecurestorage.read_data();
//    get_email().whenComplete(() async {
      user_data_list = await data.users(email);
print(user_data_list[0].contact);
        user_id = user_data_list[0].id;
        print("user id"+user_id);
        roler=user_data_list[0].role;
//      });
    setState(() {});
    print("role is");
    print(roler);
    print("done role");
  }


  void initState() {
    super.initState();
    get_data();
  }

  bool status_on = false;
  var status;
//  TextEditingController status_controller = TextEditingController();


  List<String> user_status_list = [
    "Just Started",
    "Continue",
    "Updated",
    "Under Review",
    "Waiting",
  ];

  List<String> admin_status_list = [
    "Just Started",
    "Continue",
    "Updated",
    "Complete",
    "Under Review",
    "Waiting",
  ];



//  roler=="user"?status_list=user_status_list:status_list=admin_status_list;

  Widget build(BuildContext context) {



//    var update_status=widget.status;
//    var Comment=widget.comment;
    print(widget.task_files);
    String start_date =
    DateFormat("dd-MM-yyyy").format(widget.date_start).toString();
    String end_date =
    DateFormat("dd-MM-yyyy").format(widget.date_end).toString();

    String start_time = DateFormat.jm().format(widget.date_start).toString();
    String end_time = DateFormat.jm().format(widget.date_end).toString();



    var  start=DateFormat.d().format(widget.date_start)+" "+DateFormat.MMM().format(widget.date_start)+" at "+start_time;
    var end=DateFormat.d().format(widget.date_end)+" "+DateFormat.MMM().format(widget.date_end)+" at "+end_time;


    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
//          height: MediaQuery.of(context).size.height,
//          width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
//            color: app_color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 10.0,bottom: 10.0,top: 10.0),
                  child: Column(
                    children: [



                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: (){
//                           updated_status =updated_status==""?widget.status:updated_status;
//                           updated_status =updated_status==""?widget.status:updated_status;

                            Navigator.pop(context,widget.status);
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
                      ),


                      SizedBox(
                        height: 10.0,
                      ),


                      Row(
                        children: [
                          Container(
                            height:20.0,
                            child:Icon(Icons.label_outline_rounded,
                              color:app_color,
                              size: 20.0,),
                          ),

                          SizedBox(
                            width: 4.0,
                          ),

                          Container(
                            height: 20.0,
                            child: Text(
                              widget.id,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: RowStyle_grey(14.0),
                            ),
                          ),
                          Spacer(),

                          detail_priority(widget.priority),

                        ],
                      ),

                      SizedBox(
                        height: 5.0,
                      ),
                      detail_subject(context,widget.subject),
                      SizedBox(
                        height: 5.0,
                      ),
//                      detail_progress(update_status),

                  Align(
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
                              widget.status,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: RowStyle_grey(12.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),



                      SizedBox(
                        height: 5.0,
                      ),

//                      detail_progress_linear_indicator(update_status),

                      Container(
                          height: 8.0,
//                               alignment: Alignment.topCenter,
                          margin: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                          ),
                          child: LinearProgressIndicator(
                            value: parseStatusindicatorvalue( widget.status),
                            valueColor: parseStatusAnimationIntoColor( widget.status),
                            backgroundColor:  parseStatusIntoOpacityColorandpercentage( widget.status),
                          )
                      ),


                      SizedBox(
                        height: 5.0,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width*0.8,

                        child: Row(
                          children: [
                            detail_date(context,  start.toString(),),

                            Spacer(),
//                      SizedBox(
//                        width: MediaQuery.of(context).size.width*0.01,
//                      ),

//                    Spacer(),
//                      Align(
//                        alignment: Alignment.topLeft,
//                        child: Container(
////                          width: MediaQuery.of(context).size.width*0.01,
//                          child: Text("-",
//                            style: RowStyle_app_color(12.0),
//                          ),
//                        ),
//                      ),


//                      SizedBox(
//                        width: MediaQuery.of(context).size.width*0.01
//                      ),

                            detail_date(context, end.toString(),),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 5.0,
                      ),

                      detail_assigned_to(context, widget.Assigned_by),

                      SizedBox(
                        height: 2.0,
                      ),

                      Align(
                        alignment: Alignment.topLeft,
                        child: Icon(Icons.arrow_downward_outlined,
                          color: parseStatusIntoColor( widget.status),
                          size: 20.0,),
                      ),

                      SizedBox(
                        height: 2.0,
                      ),

//                      Assigned_to(context, widget.Assigned_to.cast<String>()),


                  Align(
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
                                width: MediaQuery.of(context).size.width-140,
                                height: 20.0,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.Assigned_to.length,
                                    itemBuilder: (context,index){
                                      return Text(
                                        widget.Assigned_to[index],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: RowStyle_grey(10.0),
                                      );
                                    })
                            ),
                          ),



                        ],
                      ),
                    ),
                  ),

                      SizedBox(
                        height: 5.0,
                      ),
                      detail_Description(context, widget.description),



                      ListView.builder(
//                    physics: NeverScrollableScrollPhysics(),
//                  scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.task_files.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
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

                            child:Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Container(
                                  width: MediaQuery.of(context).size.width*0.76,
                                  child: Row(
                                    children: [

                                      Container(
                                        width: MediaQuery.of(context).size.width*0.04,
                                        child: Icon(
                                          Icons.attach_file_sharp,
                                          color: app_color,
                                          size: 20.0,
                                        ),
                                      ),

                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.02,
                                      ),

                                      Container(
                                        width: MediaQuery.of(context).size.width*0.7,
                                        child: Text(
                                          widget.task_files[index],
                                          textAlign: TextAlign.center,
                                          style: RowStyle_grey(12.0),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                      ),



                      SizedBox(
                        height: 5.0,
                      ),



                      Column(
                        children: [
                          Container(
                            height: 60,
                            child: DropdownButtonFormField(

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
                              items: roler=="user"?user_status_list.map(
                                    (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList() :admin_status_list.map(
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
                          ),


                          SizedBox(height: 10.0,),


                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {

//                          setState(() {
//                            status_on=false;
//                            previos_status=status;
//                          });

                                Services_update.update_status(widget.id,status).then((value){
                                  if(value.isNotEmpty)
                                  {
//                                    status_value.status.value=status;
                                    widget.status=status;
  setState(() {

  });
  print( widget.status);
                                    any_data_show('Status Updated');

                                  }
                                  else{
                                    any_data_show('No status yet');
                                  }
                                });

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

                      SizedBox(
                        height: 15.0,
                      ),

//alag



                      //comments

                      Row(
                        children: [
                          Text(
                            "Comments",
                            textAlign: TextAlign.left,
                            style: RowStyle_black_bold(16.0),
                          ),
                          Spacer(),
                          Icon(
                            Icons.add_outlined,
                            color: Colors.black,
                            size: 24.0,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10.0,
                      ),



                      Column(
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
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: app_color, width: 0.0),
                              ),
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
                                print("user id"+user_id);

                                if (comment.text.isNotEmpty) {
                                  Services.add_comment(
                                    widget.id,
                                    user_id,
                                    comment.text,
                                  ).then((value) {
                                    if(value.isNotEmpty)
                                    {
                                      any_data_show('Comment Done');
                                      setState(() {});
//                                      Get.back();
//                                      Get.off(view_task());

                                    }
                                    else{
                                      any_data_show('Comment not posted');
                                    }

                                  });
                                  setState(() {
                                    comment.clear();
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



                      SizedBox(
                        height: 10.0,
                      ),


                      FutureBuilder<List<Comment>>(

                          future: Comment_data.comment_data(widget.id),
                          builder:(context,snapshot){
                            return  snapshot.hasData?
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  child: ListTile(
                                    tileColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
//                        leading: Text("username",style: RowStyle_black_bold(12.0),),

                                    title: Text(
                                      snapshot.data[index].name,
                                      style: RowStyle_black_bold(12.0),
                                    ),

                                    subtitle: Text(
                                      snapshot.data[index].text,
                                      style: RowStyle_black(10.0),
                                    ),

                                    trailing: Text(
                                      DateFormat('yyyy-MM-dd hh:mm').format( snapshot.data[index].date),
                                      style: RowStyle_black_bold(8.0),
                                    ),
                                  ),
                                );
                              },
                            ):Center(
                                child:CircularProgressIndicator(color: app_color,)
                            );
                          } ),







                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
//      child: Scaffold(
//          appBar: AppBar(
//            toolbarHeight: 70.0,
//            backgroundColor: Colors.white,
////        elevation: 6.0,
//            leading: Back_button(Colors.black),
//
//            title: Text(
//              "Tickets",
//              style: RowStyle_black(20.0),
//            ),
//            centerTitle: true,
//          ),
//          backgroundColor: Colors.white,
//          body: Padding(
//            padding: const EdgeInsets.only(
//                left: 10.0, right: 10.0, bottom: 10.0, top: 20.0),
//            child: ListView(
//              children: [
//                ListTile(
//                  leading: Text(
//                    "Id",
//                    style: RowStyle_black_bold(12.0),
//                  ),
//                  title: Center(
//                      child: Text(
//                        widget.id,
//                        style: RowStyle_black(12.0),
//                      )),
//                  trailing: Icon(
//                    CupertinoIcons.number,
//                    size: 20.0,
//                  ),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text(
//                    "Subject",
//                    style: RowStyle_black_bold(12.0),
//                  ),
//                  title: Center(
//                      child: Text(
//                        widget.subject,
//                        textAlign: TextAlign.center,
//                        style: RowStyle_black(12.0),
//                      )),
//                  trailing: Icon(
//                    Icons.subject,
//                    size: 20.0,
//                  ),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text(
//                    "Assigned by",
//                    style: RowStyle_black_bold(12.0),
//                  ),
//                  title: Center(
//                      child: Text(
//                        widget.Assigned_by,
//                        style: RowStyle_black(12.0),
//                      )),
//                  trailing: Icon(
//                    Icons.person_outline,
//                    size: 20.0,
//                  ),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text(
//                    "Assigned To",
//                    style: RowStyle_black_bold(12.0),
//                  ),
//                  title: Center(
//                      child: Text(
//                        widget.Assigned_to,
//                        style: RowStyle_black(12.0),
//                      )),
//                  trailing: Icon(
//                    Icons.person_outline,
//                    size: 20.0,
//                  ),
//                ),
//
//                Divider(),
//                ListTile(
//                  leading: Text(
//                    "Start From",
//                    style: RowStyle_black_bold(12.0),
//                  ),
//                  title: Center(
//                      child: Text(
//                        start_date + "   " + start_time,
//                        style: RowStyle_black(12.0),
//                      )),
//                  trailing: Icon(
//                    Icons.access_time,
//                    size: 20.0,
//                  ),
//                ),
//                Divider(),
//                ListTile(
//                  leading: Text(
//                    "End At",
//                    style: RowStyle_black_bold(12.0),
//                  ),
//                  title: Center(
//                      child: Text(
//                        end_date + "   " + end_time,
//                        style: RowStyle_black(12.0),
//                      )),
//                  trailing: Icon(
//                    Icons.access_time,
//                    size: 20.0,
//                  ),
//                ),
//                Divider(),
//                ListTile(
//                  leading: Text(
//                    "Priority",
//                    style: RowStyle_black_bold(12.0),
//                  ),
//                  title: Center(
//                      child: Text(
//                        widget.priority,
//                        style: RowStyle_black(12.0),
//                      )),
//                  trailing: Container(
//                    height: 20,
//                    width: 20,
//                    color: parsePriorityIntoColor(widget.priority),
//                  ),
//                ),
//                Divider(),
//
//                ListTile(
//                  leading: Text(
//                    "Description",
//                    style: RowStyle_black_bold(12.0),
//                  ),
//                  title: Center(
//                      child: Text(
//                        widget.description,
//                        textAlign: TextAlign.center,
//                        style: RowStyle_black(12.0),
//                      )),
//                  trailing: Icon(
//                    Icons.description_outlined,
//                    size: 20.0,
//                  ),
//                ),
//                Divider(),
//
//                ListView.builder(
////                    physics: NeverScrollableScrollPhysics(),
////                  scrollDirection: Axis.vertical,
//                  physics: NeverScrollableScrollPhysics(),
//                  shrinkWrap: true,
//                  itemCount: widget.task_files.length,
//                  itemBuilder: (context, index) {
//                    return Column(
//                      children: [
//                        GestureDetector(
//                          onTap: () async {
//                            var url = http_root +
//                                task_files_path +
//                                widget.task_files[index];
//                            if (await canLaunch(url) != null) {
//                              await launch(url);
//                            } else {
//                              files_error();
//                              throw 'Could not launch $url';
//                            }
//                          },
//                          child: ListTile(
//                            leading: Text(
//                              "Files",
//                              style: RowStyle_black_bold(12.0),
//                            ),
//                            title: Center(
//                                child: Text(
//                                  widget.task_files[index],
//                                  textAlign: TextAlign.center,
//                                  style: RowStyle_black(12.0),
//                                )),
//                            trailing: Icon(
//                              Icons.description_outlined,
//                              size: 20.0,
//                            ),
//                          ),
//                        ),
//                        Divider(),
//                      ],
//                    );
//                  },
//                ),
//
//
//                //status
//
//                ListTile(
//                  leading: Text(
//                    "Status ",
//                    style: RowStyle_black_bold(12.0),
//                  ),
//                  title: Center(
//                      child: Text(
////                        widget.status,
//                        previos_status,
//                        style: RowStyle_black(12.0),
//                      )),
//
//                  trailing:GestureDetector(
//                    onTap: (){
//
//                      status_on=true;
//                      setState(() {});
//                    },
//                    child: Icon(
//                      Icons.edit_outlined,
//                      color: Colors.black,
//                      size: 24.0,
//                    ),
//                  ),
//
//                ),
//
//
////                SizedBox(
////                  height: 10.0,
////                ),
////
////
////                Column(
////                  children: [
////                    DropdownButtonFormField(
////
////                      decoration: InputDecoration(
////
////                        enabledBorder: OutlineInputBorder(
////                          borderSide: BorderSide(color: app_color, width: 0.0),
////                        ),
//////                      errorText: "",
////                        errorStyle:
////                        TextStyle(color: Colors.redAccent, fontSize: 12.0),
////                        border: new OutlineInputBorder(
////                          borderRadius: new BorderRadius.circular(10.0),
////                          borderSide: new BorderSide(color: app_color),
////                        ),
////                      ),
////                      hint: status == null
////                          ? Text(
////                        'Status',
////                        style: TextStyle(color: app_color),
////                      )
////                          : Text(
////                        status,
////                        style: TextStyle(color: app_color),
////                      ),
////                      isExpanded: true,
////                      iconEnabledColor: app_color,
////                      iconDisabledColor: app_color,
////                      iconSize: 30.0,
////                      style: TextStyle(color: app_color),
////                      items: status_list.map(
////                            (val) {
////                          return DropdownMenuItem<String>(
////                            value: val,
////                            child: Text(val),
////                          );
////                        },
////                      ).toList(),
////                      onChanged: (val) {
////                        setState(
////                              () {
////                            status = val;
////                          },
////                        );
////                      },
////                    ),
////
////
////                    SizedBox(height: 10.0,),
////                    Align(
////                      alignment: Alignment.centerRight,
////                      child: GestureDetector(
////                        onTap: () {
////
//////                          setState(() {
//////                            status_on=false;
//////                            previos_status=status;
//////                          });
////
////                            Services_update.update_status(widget.id,status).then((value){
////                              if(value.isNotEmpty)
////                                {
////                                  any_data_show('Status Updated');
////                                  Get.back();
////                                  Get.off(view_task());
////
////                                }
////                                   else{
////                                  any_data_show('No status yet');
////                                   }
////                            });
////
////                        },
////                        child: Container(
////                          height: 25,
////                          width: MediaQuery.of(context).size.width * 0.3,
////                          decoration: BoxDecoration(
////                            color: app_color,
////                            borderRadius: BorderRadius.circular(5.0),
////                          ),
////                          child: Center(
////                            child: Text(
////                              'Update'.toUpperCase(),
////                              style: TextStyle(
////                                  fontSize: 14.0,
////                                  color: Colors.white,
////                                  fontWeight: FontWeight.bold),
////                            ),
////                          ),
////                        ),
////                      ),
////                    ),
////                  ],
////                ),
////
////                SizedBox(
////                  height: 15.0,
////                ),
////
//////alag
////
////
////
////                //comments
////
////                Row(
////                  children: [
////                    Text(
////                      "Comments",
////                      textAlign: TextAlign.left,
////                      style: RowStyle_black_bold(16.0),
////                    ),
////                    Spacer(),
////                    Icon(
////                      Icons.add_outlined,
////                      color: Colors.black,
////                      size: 24.0,
////                    ),
////                  ],
////                ),
////
////                SizedBox(
////                  height: 10.0,
////                ),
////
////
////
////                Column(
////                  children: [
////                    TextField(
////
////                      controller: comment,
//////                    onChanged: (text) {
//////                      setState(() {
//////                        task_description = text;
//////                      });
//////                    },
////
////                      keyboardType: TextInputType.multiline,
////                      minLines: 2,
////                      maxLines: null,
////                      decoration: new InputDecoration(
////                        labelText: "Comment",
////                        fillColor: Colors.white,
////                        errorStyle: TextStyle(
////                            color: Colors.redAccent, fontSize: 12.0),
////                        prefixIcon: Icon(
////                          Icons.description,
////                          color: app_color,
////                        ),
//////                      enabledBorder: OutlineInputBorder(
//////                        borderSide: BorderSide(color: app_color, width: 0.0),
//////                      ),
////                        labelStyle:
////                        TextStyle(fontSize: 14.0, color: app_color),
////                        border: new OutlineInputBorder(
////                          borderRadius: new BorderRadius.circular(10.0),
////                          borderSide: new BorderSide(color: Colors.blue),
////                        ),
////                      ),
////                      style: new TextStyle(
////                        fontFamily: "Poppins",
////                      ),
////                    ),
////                    SizedBox(height: 10.0,),
////                    Align(
////                      alignment: Alignment.centerRight,
////                      child: GestureDetector(
////                        onTap: () {
////                          if (comment.text.isNotEmpty) {
////                            Services.add_comment(
////                              widget.id,
////                              user_id,
////                              comment.text,
////                            ).then((value) {
////                              if(value.isNotEmpty)
////                              {
////                                any_data_show('Comment Done');
////                                Get.back();
////                                Get.off(view_task());
////
////                              }
////                              else{
////                                any_data_show('Comment not posted');
////                              }
////
////                            });
////                            setState(() {
////                          comment.clear();
////                            });
////                          }
////                          else{
////                            any_data_show('No Comment yet');
////
////                          }
////                        },
////                        child: Container(
////                          height: 25,
////                          width: MediaQuery.of(context).size.width * 0.3,
////                          decoration: BoxDecoration(
////                            color: app_color,
////                            borderRadius: BorderRadius.circular(5.0),
////                          ),
////                          child: Center(
////                            child: Text(
////                              'Done'.toUpperCase(),
////                              style: TextStyle(
////                                  fontSize: 14.0,
////                                  color: Colors.white,
////                                  fontWeight: FontWeight.bold),
////                            ),
////                          ),
////                        ),
////                      ),
////                    ),
////
////                    SizedBox(
////                      height: 10.0,
////                    ),
////
////                  ],
////                ),
////
////
////
////                SizedBox(
////                  height: 10.0,
////                ),
////
////                ListView.builder(
////                    physics: NeverScrollableScrollPhysics(),
////                  shrinkWrap: true,
////                  itemCount: widget.task_files.length,
////                  itemBuilder: (context, index) {
////                    return Padding(
////                      padding: const EdgeInsets.symmetric(vertical: 10.0),
////                      child: ListTile(
////                        tileColor: Colors.black12,
////                        shape: RoundedRectangleBorder(
////                          borderRadius: BorderRadius.circular(10.0),
////                        ),
//////                        leading: Text("username",style: RowStyle_black_bold(12.0),),
////
////                        title: Text(
////                          "username",
////                          style: RowStyle_black_bold(10.0),
////                        ),
////
////                        subtitle: Text(
////                          widget.task_files[index],
////                          style: RowStyle_black(12.0),
////                        ),
////
////                        trailing: Text(
////                          "12-08-2022",
////                          style: RowStyle_black_bold(12.0),
////                        ),
////                      ),
////                    );
////                  },
////                ),
////
////
////
////
////
//
//              ],
//            ),
//          )),