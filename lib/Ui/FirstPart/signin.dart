import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:triple_n/Authetication/login.dart';
import 'package:triple_n/Authetication/storage.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Service/token.dart';
import 'forgotpassword.dart';
import 'package:triple_n/Ui/home.dart';

class signin extends StatefulWidget {
  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
  @override
  static const _key = 'email';
  final storage = new FlutterSecureStorage();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token;

  var email;
  var password;
  bool icon_flag = false;
  TextEditingController email_txt = TextEditingController();
  TextEditingController password_txt = TextEditingController();
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();

  }

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((value){

      token=value;
      setState(() {});
      print(token);
    });

  }

  final formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: formkey,
          child: Container(
            height: height,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
//              Container(
//                width: width,
//                height: height*0.2,
//                child: Image.asset('Assets/loginscreen.jpeg',fit: BoxFit.fill,),
//              ),

                  SizedBox(
                    height: 80.0,
                  ),

                  Center(
                    child: Text(
                      "NNN",
                      style: TextStyle(
                        fontFamily: "poppins",
                        color: app_color,
                        fontWeight: FontWeight.w800,
                        fontSize: 24.0,
                      ),
                    ),
                  ),

                  Center(
                    child: Text(
                      "Fast Professional",
                      style: TextStyle(
                        fontFamily: "poppins",
                        color:app_color,
                        fontWeight: FontWeight.w800,
                        fontSize: 24.0,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 30.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {
                          email = text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return "Enter Your Email ";
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        suffixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      onChanged: (text) {
                        setState(() {
                          password = text;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return "Enter Your Password ";
                        } else {
                          return null;
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: icon_flag == false ? true : false,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (icon_flag == false) {
                                  icon_flag = true;
                                } else if (icon_flag == true) {
                                  icon_flag = false;
                                }
                              });
                            },
                            child: Icon(icon_flag == false
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Forget password?',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10.0),
                      color: app_color,
                      child: MaterialButton(
                        height: 50.0,
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          if (formkey.currentState.validate()) {

                            processing_Message();
//                            var snackBar1 = SnackBar(
//                              duration: Duration(seconds: 2),
//                              content: Container(
//                                  height: 30.0,
//                                  child:
//                                      Center(child: Text('Processing.......'))),
//                            );
//                            ScaffoldMessenger.of(context)
//                                .showSnackBar(snackBar1);


                            authetication.check_login(email, password,token)
                                .then((user_id) async {

                                  invalid_Message();
                              print(user_id);

                              if (user_id == "invalid") {
//                                var snackBar = SnackBar(
//                                  content: Container(
//                                      height: 30.0,
//                                      child: Center(
//                                          child: Text('Invalid Credential'))),
//                                );
//                                ScaffoldMessenger.of(context)
//                                    .showSnackBar(snackBar);

                              } else {
                                print(user_id);
//
                                authentication_Message();

//                                var snackBar = SnackBar(
//                                  duration: Duration(seconds: 2),
//                                  content: Container(
//                                      height: 30.0,
//                                      child: Center(
//                                          child: Text(
//                                              'Authetication successful'))),
//                                );
//
//                                ScaffoldMessenger.of(context)
//                                    .showSnackBar(snackBar);
                                await usesecurestorage.write_data(email);

                                Timer(Duration(seconds: 3),
                                    () => Get.off(home()));

                               //String readed_token=await usesecurestorage.read_token();

//                                if( readed_token ==null)
//                                  {
//                                    _firebaseMessaging.getToken().then((value2) async {
//                                      token = value2;
//                                      setState(() {});
//                                      print(token);
//                                        await usesecurestorage.write_token(token);
//                                        print("token has first time");
//                                     String add="add";
//
////                                      Token.Post_token(int.parse(user_id), token,"add")
////                                          .then((value) async {
////                                        print(value);
////                                      }).toString();
//
//
//                                    });
//
//                                  }else{
//
//
//                                    _firebaseMessaging.getToken().then((value) async {
//                                      token = value;
//                                      setState(() {});
//                                      print(token);
//                                      if(token == readed_token){
//                                        await usesecurestorage.write_token(token);
//                                        print("token is not changed");
//                                      }else{
//                                        await usesecurestorage.write_token(token);
//                                        print("token has been changed");
//
//                                        String change="change";
//
////                                        Token.Post_token(int.parse(user_id) ,token,change)
////                                            .then((value) async {
////                                          print(value);
////                                        }).toString();
//
//                                      }

//                                    });

//
//                                }



                              }
                            });
                          }
                        },
                        child: Text("Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
