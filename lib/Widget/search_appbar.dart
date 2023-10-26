import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triple_n/Global/global.dart';

class search_appbar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  String hint_text;
   bool close;

   search_appbar(
    this.title, this.hint_text, this.close,
       {
    Key key,
  }) : super(key: key);

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100.0);

  final TextEditingController searchtxt = TextEditingController();

//  var get_controller=Get.put(paging_controller());

  Widget build(BuildContext context) {

    return  AppBar(
      title: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w500),
      ),
      brightness: Brightness.light,
      backgroundColor: app_color,
      centerTitle: true,
      elevation: 10.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),

                Expanded(
                  flex: 8,
                  child: Text(
                    " Back",
                    style: TextStyle(
                        fontFamily: "popppins",
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )),
      ),


      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextField(
            onChanged: (value)  {

//         get_controller.textfield_change(true);
//               get_controller.filtered_list([]);
//               await get_controller.task_manager_onsearch(word: value);
            },
            onTap: () {},
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
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              fillColor: w_color,
              filled: true,
              hintText: hint_text,
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: "poppins",
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:get/get.dart';
//import 'package:http/http.dart';
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Pagination_Controller/tickets_controller.dart';
//
//Widget search_app_bar(context,Title){
//  var get_controller=Get.put(paging_controller());
//  return AppBar(
//    toolbarHeight: 90.0,
//    brightness: Brightness.light,
//    backgroundColor: app_color,
//    elevation: 10.0,
//    title: showbar,
//    leading: get_controller.close == true
//        ? GestureDetector(
//        onTap: () {
//          Navigator.pop(context);
//        },
//        child: Icon(
//          Icons.arrow_back_ios,
//          color: w_color,
//        ))
//        : null,
//    actions: [
//      get_controller.close == true
//          ? IconButton(
//        onPressed: () {
//          setState(() {
//            refresher = true;
////                key.currentState.pageTo(0);
//            showbar = TextField(
//              onChanged: (value) async {
//                get_controller.filtered_list([]);
//
//                await task_manager_onsearch(
//                  isReload: true,
//                  word: value.toLowerCase(),
//                );
//                setState(() {});
//
////                      get_controller.filtered_list = task_manager_list
////                          .where((element) => (element.subject
////                          .toLowerCase()
////                          .contains(value.toLowerCase())
////                      )).toList();
//
////                    if (search_list.isNotEmpty) {
////                      setState(() {
////                        custombody_list = search_list
////                            .where((string) => string
////                            .toLowerCase()
////                            .contains(value.toLowerCase()))
////                            .toList();
////                        print(custombody_list);
////                      });
////                    } else {
////                      print("list is empty");
////                    }
//              },
//              onTap: () {},
//              controller: searchtxt,
//              decoration: InputDecoration(
//                contentPadding: EdgeInsets.only(
//                    left: 10.0, right: 30.0, top: 10.0, bottom: 10.0),
//                isDense: true,
//                enabledBorder: OutlineInputBorder(
//                  borderSide: const BorderSide(
//                      color: Colors.white, width: 2.0),
//                  borderRadius: BorderRadius.circular(8.0),
//                ),
//                focusedBorder: OutlineInputBorder(
//                  borderSide: const BorderSide(
//                      color: Colors.white, width: 2.0),
//                  borderRadius: BorderRadius.circular(10.0),
//                ),
//                fillColor: w_color,
//                filled: true,
//                hintText: 'Search By Subject',
//                hintStyle: TextStyle(
//                  color: Colors.grey,
//                  fontSize: 16,
//                  fontWeight: FontWeight.w500,
//                  fontFamily: "poppins",
//                ),
//                border: InputBorder.none,
//              ),
//              style: TextStyle(
//                color: Colors.black,
//              ),
//            );
//            get_controller.close(false);
//          });
//        },
////            showSearch(
////                context: context,
////                delegate: search(search_list));
//
//        icon: Icon(
//          Icons.search,
//          color: w_color,
//        ),
//      )
//          : IconButton(
//        icon: Icon(
//          Icons.clear,
//          color: Colors.white,
//          size: 33.0,
//        ),
//        onPressed: () async {
////                      _refreshController.isLoading;
//
//          get_controller.close(true);
//          get_controller.filtered_list([]);
//          await task_manager(isReload: true);
//          setState(() {});
//          searchtxt.clear();
//          showbar = Text(
//            "Tickets",
//            style: TextStyle(
//              fontFamily: "poppins",
//              fontSize: 24.0,
//              color: Colors.white,
//            ),
//          );
//          refresher = false;
//        },
//      )
//    ],
//  ),
//
//}
//
//
//
