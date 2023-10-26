//
////          AppBar(
////            toolbarHeight: 90.0,
////            backgroundColor: app_color,
////            elevation: 10.0,
////            titleSpacing: MediaQuery.of(context).size.width,
//
//            bottom: PreferredSize(
//              preferredSize: const Size.fromHeight(50.0),
//              child: Padding(
//                padding: const EdgeInsets.all(5.0),
//                child: TextField(
//                  onChanged: (value) {
//                    _debouncer.run(() async {
//                      setState(() {
//                        if (appointment_list.isNotEmpty) {
//                          appointment_list = [];
//                        }
//                        onsearch = true;
//                      });
//                      await appointment_manager_onsearch(
//                        isReload: true,
//                        word: value.toLowerCase(),
//                      );
//                      setState(() {});
//                    });
//                  },
//                  onTap: () {},
//                  controller: searchtxt,
//                  decoration: InputDecoration(
//                    contentPadding: EdgeInsets.only(
//                        left: 5.0, right: 30.0, top: 10.0, bottom: 10.0),
//                    prefixIcon:  Icon(
//                      Icons.search_outlined,
//                      color: Colors.grey,
//                    ),
//
//                    isDense: true,
//                    enabledBorder: OutlineInputBorder(
//                      borderSide: const BorderSide(
//                          color: Colors.white, width: 2.0),
//                      borderRadius: BorderRadius.circular(8.0),
//                    ),
//                    focusedBorder: OutlineInputBorder(
//                      borderSide: const BorderSide(
//                          color: Colors.white, width: 2.0),
//                      borderRadius: BorderRadius.circular(10.0),
//                    ),
//                    fillColor: w_color,
//                    filled: true,
//                    hintText: "Appointments",
//                    hintStyle: TextStyle(
//                      color: Colors.grey,
//                      fontSize: 16,
//                      fontWeight: FontWeight.w500,
//                      fontFamily: "poppins",
//                    ),
//                    border: InputBorder.none,
//                  ),
//                  style: TextStyle(
//                    color: Colors.black,
//                  ),
//                ),
//              ),
//            ),
//            leading: Back_button(Colors.white),
//
////            actions: [
////              GestureDetector(
////           onTap: () async { Back_button(Colors.white)
////             setState(() {
////               appointment_list=[];
////               searchtxt.clear();
////               onsearch=false;
////               filter_flag=false;
////             });
////
////             await appointment_manager(isReload: true);
////             setState(() {});
////
////           },
////                child: Icon(Icons.refresh_outlined,
////                  color: Colors.white,
////                ),
////              ) ,
////             GestureDetector(
////               onTap: (){
////                 showDialog(
////                   context: context,
////                   builder: (BuildContext context) {
////                     return Filter;
////                   },
////                 );
////               },
////               child: Icon(Icons.filter_alt_outlined,
////               color: Colors.white,
////               ),
////             ) ,
////
////              SizedBox(
////                width: 10.0,
////              )
////            ],
//          ),