import 'package:flutter/material.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Model/users.dart';
import 'package:triple_n/Service/Users.dart';
import 'package:triple_n/Views/view_task.dart';
import 'package:triple_n/Widget/custom_appbar.dart';

class add_invoice extends StatefulWidget {
  @override
  _add_invoiceState createState() => _add_invoiceState();
}

class _add_invoiceState extends State<add_invoice> {
  @override

  var client;
  var client_list = ["abc"];


  String task_owner;

  TextEditingController subject = TextEditingController();
  TextEditingController custname = TextEditingController();
  TextEditingController details= TextEditingController();
  TextEditingController insurance= TextEditingController();

  var invoice_subject;
  var invoice_custname;
  var invoice_details;

  static const label = "Insurance Campany";
  static const dummyList = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];

  final formkey=GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custom_appbar("Add Invoice",view_task()),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),

//subject
                  new TextFormField(
                    controller: subject,
                    onChanged: (text) {
                      setState(() {
                        invoice_subject = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty||value==null) {
                        return "Plz Enter Subject ";
                      }
                      else{
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Subject",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      prefixIcon: Icon(
                        Icons.subject,
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
                  SizedBox(
                    height: 30.0,
                  ),

                  //busness name
                  new TextFormField(
                    controller: custname,
                    onChanged: (text) {
                      setState(() {
                        invoice_custname = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty||value==null) {
                        return "Plz Enter Customer name ";
                      }
                      else{
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Customer/Business Name",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.person,
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

                  SizedBox(
                    height: 30.0,
                  ),

                  //Insurance
                  TextFieldSearch(
                    initialList: dummyList,
                    label: label,
                    controller: insurance,
                    decoration: new InputDecoration(
                      labelText: "Insurance Company",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.person,
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
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  //details
                  new TextFormField(
                    controller: details,
                    onChanged: (text) {
                      setState(() {
                        invoice_details = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty||value==null) {
                        return "Plz Enter Details ";
                      }
                      else{
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: new InputDecoration(
                      labelText: "Details",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.description,
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

                  SizedBox(
                    height: 30.0,
                  ),

                  //Task Owner


                  FutureBuilder<List<Users>>(
                      future: UsersService.users(),
                      builder: (context,snapshot){
                        if(snapshot.hasData)
                          {
                            return DropdownButtonFormField(
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return "Plz Enter Task Owner";
                                }
                              },
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
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              hint: task_owner == null
                                  ? Text(
                                'Task Owner',
                                style: TextStyle(color: app_color),
                              )
                                  : Text(
                                task_owner,
                                style: TextStyle(color: app_color),
                              ),
                              isExpanded: true,
                              iconEnabledColor: app_color,
                              iconDisabledColor: app_color,
                              iconSize: 30.0,
                              style: TextStyle(color: app_color),
                              items: snapshot.data.map(
                                    (val) {
                                  return DropdownMenuItem<String>(
                                    value: val.id,
                                    child: Text(val.name),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                      () {
                                    task_owner = val;
                                  },
                                );
                              },
                            );

                          }
                        else{

                          return Center(
                            child: CircularProgressIndicator(
                              color: app_color,
                            ),
                          );
                        }

                  }),


                  SizedBox(
                    height: 30.0,
                  ),

                  GestureDetector(
                    onTap: () {
                      if (formkey.currentState.validate()) {
                        print('valid');
                      }
                      else  if(insurance.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('plz fill Insurance')),
                        );
                      }
                      else{

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('plz fill the fields')),
                        );
                      }
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => Loginpage()),
//                  );
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width ,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              app_color,
                              app_color,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          'Submit'.toUpperCase(),
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
