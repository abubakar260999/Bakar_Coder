import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/notification.dart';
import 'package:triple_n/Service/add_contacts.dart';
import 'package:triple_n/Views/view_contact.dart';
import 'package:triple_n/Widget/custom_appbar.dart';

class add_contact extends StatefulWidget {
  @override
  _add_contactState createState() => _add_contactState();
}

class _add_contactState extends State<add_contact> {
  @override
  String title = "Add Contact";

  TextEditingController name = TextEditingController();
  TextEditingController compname = TextEditingController();
  TextEditingController businesstype = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  TextEditingController moibleno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fax = TextEditingController();

  var contact_name;
  var contact_compname;
  var contact_businesstype;
  var contact_address;
  var contact_country;
  var contact_state;
  var contact_zipcode;
  var contact_city;
  var contact_phoneno;
  var contact_moibleno;
  var contact_email;
  var contact_fax;

  File _image1;
  File _image2;

//  Future<File> getImageFileFromAssets(String path) async {
//    final byteData = await rootBundle.load('Assets/$path');
//
//    final file = File('${(await getTemporaryDirectory()).path}/$path');
//    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//
//    return file;
//  }
//
//  get_file()async{
//    _image1 =File("C:\Users\DG Computer\AndroidStudioProjects\triple_n\lib\ind3.jpeg");
//    _image2 =File("C:\Users\DG Computer\AndroidStudioProjects\triple_n\lib\ind3.jpeg");
//  }


  void initState(){

//    get_file();
    super.initState();

  }

  _imgFromCamera1() async {
    File image = (await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50)) as File;


    setState(() {
      _image1 = image;

    });
  }

  _imgFromGallery1() async {
    File image = (await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50)) as File;
    setState(() {
      _image1 = image;
    });
  }

  void _showPicker1(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library,color: app_color,),
                      title: new Text('Photo Library',style: TextStyle(color: app_color),),
                      onTap: () {
                        _imgFromGallery1();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera,color: app_color,),
                    title: new Text('Camera',style: TextStyle(color: app_color),),
                    onTap: () {
                      _imgFromCamera1();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }



  _imgFromCamera2() async {
    File image = (await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50)) as File;

//    File croppedFile = await ImageCropper.cropImage(
//      sourcePath: image.path,
//
//    );

    setState(() {
      _image2 = image;
    });
  }

  _imgFromGallery2() async {
    File image = (await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50)) as File;
    setState(() {
      _image2 = image;
    });
  }

  void _showPicker2(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library,color: app_color,),
                      title: new Text('Photo Library',style: TextStyle(color: app_color),),
                      onTap: () {
                        _imgFromGallery2();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera,color: app_color,),
                    title: new Text('Camera',style: TextStyle(color: app_color),),
                    onTap: () {
                      _imgFromCamera2();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  final formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custom_appbar(title,4),
      body: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  //full name
                  new TextFormField(
                    controller: name,
                    onChanged: (text) {
                      setState(() {
                        contact_name = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter name ";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Full Name",
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

//company name
                  new TextFormField(
                    controller: compname,
                    onChanged: (text) {
                      setState(() {
                        contact_compname = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter Company Name ";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Company Name",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.house_sharp,
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

//Business Type
                  new TextFormField(
                    controller: businesstype,
                    onChanged: (text) {
                      setState(() {
                        contact_businesstype = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter Business type";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Business Type",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.business,
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

                  //Country

                  new TextFormField(
                    controller: country,
                    onChanged: (text) {
                      setState(() {
                        contact_country = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter Country ";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Country",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.location_city,
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
//state
                  new TextFormField(
                    controller: state,
                    onChanged: (text) {
                      setState(() {
                        contact_state = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter State ";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "State",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.location_city,
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

                  //city

                  new TextFormField(
                    controller: city,
                    onChanged: (text) {
                      setState(() {
                        contact_city = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter city ";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "City",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.location_city,
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

                  //Address
                  new TextFormField(
                    controller: address,
                    onChanged: (text) {
                      setState(() {
                        contact_address = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter Address";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Address",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.location_history,
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
//Zipcode

                  new TextFormField(
                    controller: zipcode,
                    onChanged: (text) {
                      setState(() {
                        contact_zipcode = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter zipcode ";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Zip code",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.location_city,
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

//Contact

                  new TextFormField(
                    controller: phoneno,
                    onChanged: (text) {
                      setState(() {
                        contact_phoneno = text;
                      });
                    },
                    validator: (value) {
//                      if (value.isEmpty || value == null) {
//                        return "Plz Enter Phone Number";
//                      } else {
//                        return null;
//                      }
    String pattern =  r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
    return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
    }
    return null;
    },
//                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Phone Number",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.contact_page_outlined,
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

//moible no
                  new TextFormField(
                    controller: moibleno,
                    onChanged: (text) {
                      setState(() {
                        contact_moibleno = text;
                      });
                    },
                    validator: (value) {
//                      if (value.isEmpty || value == null) {
//                        return "Plz Enter Moible no ";
//                      } else {
//                        return null;
//                      }
    String pattern =  r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
    return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
    return 'Please enter valid mobile number';
    }
    return null;
    },
//                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Mobile Number",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
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

                  SizedBox(
                    height: 30.0,
                  ),

//Email
                  new TextFormField(
                    controller: email,
                    onChanged: (text) {
                      setState(() {
                        contact_email = text;
                      });
                    },
                    validator: (value) {
//                      if (value.isEmpty || value == null) {
//                        return "Plz Enter Email";
//                      } else {
//                        return null;
//                      }

    String pattern =  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
    return 'Please enter Email';
    }
    else if (!regExp.hasMatch(value)) {
    return 'Please enter valid Email';
    }
    return null;
    },

//                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Email",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.email,
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

//Fax
                  new TextFormField(
                    controller: fax,
                    onChanged: (text) {
                      setState(() {
                        contact_fax = text;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty || value == null) {
                        return "Plz Enter Fax";
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: new InputDecoration(
                      labelText: "Fax",
                      fillColor: Colors.white,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      prefixIcon: Icon(
                        Icons.contact_mail,
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

                  //button

//                  GestureDetector(
//                    onTap: (){
//                      _showPicker1(context);
//
//
//                    },
//                    child: Container(
//                      height: 55,
//                      width: MediaQuery.of(context).size.width ,
//                      decoration: BoxDecoration(
////                    color: w_color,
//                          border: Border.all(
//                            color: app_color,
//                            width: 2.0,
//                          ),
//                          borderRadius: BorderRadius.all(Radius.circular(10))),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Padding(
//                            padding: const EdgeInsets.only(left: 10.0),
//                            child: Icon(
//                              Icons.camera_alt_outlined,
//                              color: app_color,
//                            ),
//                          ),
//                          Expanded(
//                            child: FittedBox(
//                              fit: BoxFit.scaleDown,
//                              child: Text(
//                                " Select V-Card Front",
////                                "Visiting Card Front",
//                                style: TextStyle(
//                                  color: app_color,
//                                  fontWeight: FontWeight.w500,
//                                  fontSize: 20.0,
//                                ),
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),

                  SizedBox(
                   height: 30.0,
                  ),

Row(
  children: [

    _image1 !=null
        ? GestureDetector(
      onTap: (){
        _showPicker1(context);

      },
      child: Container(
      decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0)
      ),
      height: 150,
      width: MediaQuery.of(context).size.width*0.45,

      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Image.file(
            _image1,
//                        height: 55,
//                        width: MediaQuery.of(context).size.width ,
            fit: BoxFit.fill,
          ),
      ),
    ),
        ):
    GestureDetector(
      onTap: (){
        _showPicker1(context);

      },
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width*0.45 ,
        decoration: BoxDecoration(
//                    color: w_color,
            border: Border.all(
              color: app_color,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 35,
                  color: app_color,
                ),
              ),
              Expanded(
                flex: 7,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Select V-Card front",
                    style:  TextStyle(
                      color: app_color,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),


    SizedBox(
      width: MediaQuery.of(context).size.width*0.03,
    ),



    _image2 !=null ?
    GestureDetector(
      onTap: (){
        _showPicker2(context);

      },
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width*0.45 ,

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0)
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.file(
            _image2 ,
//                        height: 55,
//                        width: MediaQuery.of(context).size.width ,
            fit: BoxFit.fill,
          ),
        ),
      ),
    ):
    GestureDetector(
      onTap: (){
        _showPicker2(context);

      },
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width *0.45,
        decoration: BoxDecoration(
//                    color: w_color,
            border: Border.all(
              color: app_color,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
      flex: 3,
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 35,
                  color: app_color,
                ),
              ),
              Expanded(
                flex: 7,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Select V-Card Back",
                    style:  TextStyle(
                      color: app_color,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),

  ],
),


//                  Container(
//                    height: 250,
//                    width: MediaQuery.of(context).size.width ,
//                    color: app_color,
//                    child: ClipRRect(
//                      borderRadius: BorderRadius.circular(20.0),
//                      child: Padding(
//                        padding: const EdgeInsets.all(20.0),
//                        child: Image.asset(
//                          "Assets/v_card_image.png",
//color: Colors.white,
////                        height: 55,
////                        width: MediaQuery.of(context).size.width ,
//                          fit: BoxFit.fill,
//                        ),
//                      ),
//                    ),
//                  ),

                  SizedBox(
                    height: 30.0,
                  ),


                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState.validate()) {

                        Data_processing_Message();
                        Services.add_contact(
                          name.text,
                          compname.text,
                          businesstype.text,
                          country.text,
                          state.text,
                          city.text,
                          address.text,
                          zipcode.text,
                          phoneno.text,
                          moibleno.text,
                          email.text,
                          fax.text,
                           _image1,
                          _image2
                        ) .whenComplete(() {

                            Data_added_Message();

                            Timer(Duration(seconds: 2), () {

                              Get.back();
                              Get.off(add_contact());

                            });


                        }).onError((error, stackTrace) {
                          Error_message(error);
                        });
                        print('valid');
                      }
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => Loginpage()),
//                  );
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.2,
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
                          'Done'.toUpperCase(),
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
