import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Model/users.dart';
import 'package:triple_n/Service/Users.dart';
import 'package:triple_n/Widget/cooperation_widget.dart';
import 'package:triple_n/Widget/global_button.dart';

class detailview_coperation extends StatefulWidget {
  @override
  final String id;
  final String yearend;
  final String companytitle;
  final String name;
  final String groupofcompanies;
  final String email;
  final String contact;
  final String ein;
  final String fax;
  final String insurance;
  final String payrol;
  final String license;
  final String salestax;
  final String businesstype;
  final String companystatus;
  final String dateincooperation;
  final String lastfillingdate;
  final String companywebsite;
  final String createdby;
  final String createdon;

  detailview_coperation(
      this.id,
      this.yearend,
      this.companytitle,
      this.name,
      this.groupofcompanies,
      this.email,
      this.contact,
      this.ein,
      this.fax,
      this.insurance,
      this.payrol,
      this.license,
      this.salestax,
      this.businesstype,
      this.companystatus,
      this.dateincooperation,
      this.lastfillingdate,
      this.companywebsite,
      this.createdby,
      this.createdon,
      {Key key})
      : super(key: key);

  _detailview_coperationState createState() => _detailview_coperationState();
}

class _detailview_coperationState extends State<detailview_coperation> {
  @override
  Widget build(BuildContext context) {
    String incooperation_date = widget.dateincooperation != ""
        ? DateFormat("dd-MM-yyyy hh:mm")
            .format(DateTime.parse(widget.dateincooperation))
            .toString()
        : "";
    String created_on_date = widget.createdon != ""
        ? DateFormat("dd-MM-yyyy hh:mm")
            .format(DateTime.parse(widget.createdon))
            .toString()
        : " ";
    String last_filling_date =
        widget.lastfillingdate != "" || widget.lastfillingdate != null
            ? " "
            : DateFormat("dd-MM-yyyy hh:mm")
                .format(DateTime.parse(widget.lastfillingdate))
                .toString();
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
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 10.0, bottom: 10.0, top: 10.0),
                  child: Column(
                    children: [
                      detail_back(),
                      SizedBox(
                        height: 10.0,
                      ),
                      detail_id(context, widget.id),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_company(context, widget.companytitle),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_company(context, widget.groupofcompanies),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_name(context, widget.name),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_email(context, widget.email),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_phone(context, widget.contact),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_fax(context, widget.fax),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_ein(context, widget.ein),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_other_cooperation(
                          context, "Insurance", widget.insurance),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_other_cooperation(
                          context, "Payrol", widget.payrol),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_other_cooperation(
                          context, "License", widget.license),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_other_cooperation(
                          context, "SalesTax", widget.salestax),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_other_cooperation(
                          context, "Business Type", widget.businesstype),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_other_cooperation(
                          context, "Company Status", widget.companystatus),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_other_cooperation_date(
                          context, "Date in cooperation", incooperation_date),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_other_cooperation_date(
                          context, "Last Filling Date", last_filling_date),
                      SizedBox(
                        height: 5.0,
                      ),
                      detail_other_cooperation_date(context, "Created_on", created_on_date),

                      
                      SizedBox(
                        height: 5.0,
                      ),

                      detail_company_website(context, "company Website", widget.companywebsite),

                      SizedBox(
                        height: 5.0,
                      ),

                      FutureBuilder<List<Users>>(
                          future: UsersService.users(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var name;
                              List<String> id_s =
                                  snapshot.data.map((e) => e.id).toList();
                              for (int i = 0; i < id_s.length; i++) {
                                if (widget.createdby == id_s[i]) {
                                  name = snapshot.data[i].name;
                                }
                              }

                              return detail_created_by_name(context, name);
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                color: app_color,
                              ));
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// return SafeArea(
//      child: Scaffold(
//          appBar: AppBar(
//            toolbarHeight: 70.0,
//            backgroundColor: Colors.white,
////        elevation: 6.0,
//            leading: Back_button(Colors.black),
//
//            title:Text("Cooperation",style: RowStyle_black(20.0),),
//            centerTitle: true,
//
//          ),
//
//
//          backgroundColor: Colors.white,
//          body:Padding(
//            padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0,top: 20.0),
//            child: ListView(
//              children: [
//
//                ListTile(
//                  leading: Text("Id",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.id,style: RowStyle_black(12.0),)),
//                  trailing: Icon(CupertinoIcons.number,size: 20.0,),
//                ),
//                Divider(),
//
//
//                ListTile(
//                  leading: Text("Owner Name",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.name,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.person_outline,size: 20.0,),
//                ),
//                Divider(),
//
//
//                ListTile(
//                  leading: Text("Email",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.email,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.mail_outline,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Contact",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.contact,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.mail_outline,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Group of Companies",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.groupofcompanies,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.business,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Documents",style: RowStyle_black_bold(12.0),),
//                  title: cooperation_file_button(
//                      MediaQuery.of(context).size.width,
//                      140,
//                      "Documents",
//                      8.0,
//                      Colors.white,
//                      blue_color),
//
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Ein",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.ein,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.person_outline_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Fax",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.fax,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.contact_phone_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//
//                ListTile(
//                  leading: Text("Insurance",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.insurance,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.business,size: 20.0,),
//                ),
//
//                Divider(),
//
//
//                ListTile(
//                  leading: Text("Payroll",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.payrol,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.business,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("License",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.license,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.business,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("SalesTax",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.salestax,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.business,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Business Type",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.businesstype,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.business,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Company Status",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.companystatus,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.business,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Date of In cooperation",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(incooperation_date,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.calendar_today_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Last Date of Filling",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(last_filling_date,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.calendar_today_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Company Website",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(widget.companywebsite,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.web,size: 20.0,),
//                ),
//
//                Divider(),
//    FutureBuilder<List<Users>>(
//    future: UsersService.users(),
//    builder:(context,snapshot) {
//
//      if(snapshot.hasData)
//        {
//          var name;
//          List<String> id_s=snapshot.data.map((e) => e.id).toList();
//          for(int i=0;i<id_s.length;i++)
//          {
//            if(widget.createdby==id_s[i])
//            {
//              name=snapshot.data[i].name;
//            }
//
//          }
//
//          return  ListTile(
//            leading: Text("Created By", style: RowStyle_black_bold(12.0),),
//            title: Center(
//                child: Text(name.toString(), style: RowStyle_black(12.0),)),
//            trailing: Icon(Icons.person_outline_outlined, size: 20.0,),
//          );
//        }
//      else{
//        return Center(child: CircularProgressIndicator(color: app_color,));
//      }
//    }
//    ),
//
//                Divider(),
//
//                ListTile(
//                  leading: Text("Created on",style: RowStyle_black_bold(12.0),),
//                  title: Center(child: Text(created_on_date,style: RowStyle_black(12.0),)),
//                  trailing: Icon(Icons.calendar_today_outlined,size: 20.0,),
//                ),
//
//                Divider(),
//
//              ],
//            ),
//          )
//
//      ),
//    );
