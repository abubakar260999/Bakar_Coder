import 'package:triple_n/Authetication/storage.dart';
import 'package:flutter/material.dart';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';
import 'package:triple_n/Model/users.dart';
import 'package:triple_n/Service/user_profile.dart';



class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}


class _profileState extends State<profile> {
  @override

  List<Users> user_data_list=[];
  var email;
  String image_id;

  void initState() {
    super.initState();
get_data();

  }

Future get_email() async {
  email=  await usesecurestorage.read_data();
  setState(() {});
  print(email);
}

  Future get_data() async {
  get_email().whenComplete(() async {
    user_data_list=await data.users(email);
    setState(() {
      image_id=user_data_list[0].id;
      image_id=image_id+".jpg";
    });
  });

  }



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",style: TextStyle(
          color: textcolor1,
        ),),
        elevation: 0.0,
        centerTitle: true,
        toolbarHeight: 50.0,
        backgroundColor: Colors.transparent,
//        brightness: Brightness.light,
        leading: Back_button(Colors.black),

      ),
      body: user_data_list!=null && user_data_list.isNotEmpty?Padding(
        padding: const EdgeInsets.only(left: 10.0,top: 20.0,bottom: 20.0,right: 10.0),
        child: Container(
//          width: MediaQuery.of(context).size.width,
//          height:MediaQuery.of(context).size.height,
          child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
            children: [

//              Expanded(
//                flex: 2,
//                child: Card(
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(12.0),
//                  ),
//                  elevation: 10.0,
//                  child: ClipRRect(
//                    borderRadius: BorderRadius.circular(12.0),
//                    child: Image.network("http://192.168.10.177/triplen/avatars/avatars/$image_id",
//                      fit: BoxFit.cover,
//                    ),
//                  ),
//                ),
//              )

//              CircleAvatar(
//                radius: 60.0,
//                backgroundImage: NetworkImage("http://192.168.10.177/triplen/avatars/avatars/$image_id"),
//                backgroundColor: Colors.transparent,
//              ),


              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),

                child: FadeInImage(
                  height: 90,
                  width: 90,
                  image: NetworkImage(http_root+folder_path+"$image_id"),
                  placeholder: AssetImage("Assets/hover.gif",),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                        'Assets/hover.gif',
                        height: 90,
                        width: 90,
                        fit: BoxFit.fitWidth);
                  },
                  fit: BoxFit.fitWidth,
                ),
              ),

              SizedBox(
                height: 20.0,
              ),

              Expanded(
                flex:1,
                child: Row(
                  children: [
                    Expanded(
                        flex:2,child: Icon(Icons.person_outline_outlined,color:grey_color,)),
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: Text(user_data_list[0].name==null&& user_data_list[0].name.isEmpty?"No Name":user_data_list[0].name,
                          style: TextStyle(
                              color: grey_color,
                              fontFamily: "poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex:1,
                child: Row(
                  children: [
                    Expanded(
                        flex:2,child: Icon(Icons.phone_outlined,color: grey_color,)),
                    Expanded(
                      flex: 8
                      ,
                      child: Container(
                        child: Text(user_data_list[0].contact==null&& user_data_list[0].contact.isEmpty?"No Name":user_data_list[0].contact,

                          style: TextStyle(
                              color: grey_color,
                              fontFamily: "poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex:1,
                child: Row(
                  children: [
                    Expanded(
                        flex:2,child: Icon(Icons.email_outlined,color: grey_color,)),
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: Text(user_data_list[0].email==null&& user_data_list[0].email.isEmpty?"No Name":user_data_list[0].email,
                          style: TextStyle(
                              color: grey_color,
                              fontFamily: "poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                  flex:5,
                child:Text(""),
            ),


            ],
          ),
        ),
      ):
          Center(
            child: CircularProgressIndicator(
            color: app_color,
            ),
          ),
    );
  }
}



//              CircleAvatar(
//                radius: MediaQuery.of(context).size.height*0.1,
//                backgroundImage: AssetImage("Assets/profile.jpg"),
//                child: Stack(
//                    children: [
//                      Align(
//                        alignment: Alignment.bottomRight,
//                        child: CircleAvatar(
//                          radius: 2,
//                          backgroundColor: Colors.white70,
//                          child: Icon(Icons.camera_alt_outlined,color: app_color,),
//                        ),
//                      ),
//                    ]
//                ),