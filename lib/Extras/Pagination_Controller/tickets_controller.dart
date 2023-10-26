//import 'dart:convert';
//import 'package:flutter/cupertino.dart';
//import 'package:http/http.dart' as http;
//import 'package:get/get.dart';
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/task_manager.dart';
//import 'package:triple_n/Global/paths.dart';
//
//class paging_controller extends GetxController {
//
//  var filtered_list=<TaskManager>[].obs;
//
//  static const _pageSize = 5;
//  var currentPage = 0;
//  var search_current_page=0;
//  var showBackToTopButton = true.obs;
////  var filtered_list=<TaskManager>[].obs;
//  var close=false.obs;
//  String searchedWord="";
//  List<TaskManager> result = [];
//
//  var textfield_change=false.obs;
//
//  var scrollController;
//  final PagingController<int, TaskManager> pagingController =
//      PagingController(firstPageKey: 0);
//
//  @override
//  void onInit() {
//    // TODO: implement onInit
//    super.onInit();
//    scrollController = ScrollController()
//      ..addListener(
//        () {
//          if (scrollController.offset >= 400) {
//            showBackToTopButton(true); // show the back-to-top button
//          } else {
//            showBackToTopButton(false); // hide the back-to-top button
//          }
//        },
//      );
//    pagingController.addPageRequestListener((pageKey) {
//      _fetchPage(pageKey);
//    });
//  }
//
//  void scrollToTop() {
//    scrollController.animateTo(0,
//        duration: const Duration(seconds: 1), curve: Curves.linear);
//  }
//
//  @override
//  void onClose() {
//    super.onClose();
//    pagingController.dispose();
//  }
//
//  Future<void> _fetchPage(int pageKey) async {
//    try {
//      final newItems =
//          List.generate(_pageSize, (index) => "dd: ${pageKey + index}");
////      final isLastPage = newItems.length < _pageSize;
//////      if (isLastPage) {
//////        pagingController.appendLastPage(newItems);
//////      } else {
//////        final nextPageKey = pageKey + newItems.length;
//////        pagingController.appendPage(newItems, nextPageKey);
//////      }
//
//      task_manager(pageKey: pageKey);
//    } catch (error) {
//      pagingController.error = error;
//    }
//  }
//
//
//
//
//  Future<List<TaskManager>> task_manager({bool isReload = false, pageKey}) async {
//    try {
//      if (isReload) {
//        currentPage = 0;
//      }
//
//      //size on server
//      String url = http_root + "search_task_manager.php?page_no=$currentPage&size=20";
//
//      final response = await http.get(url);
//      List<TaskManager> result = [];
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        print(parsed.map<TaskManager>((json) => TaskManager.fromJson(json))
//            .toList());
//        result = parsed
//            .map<TaskManager>((json) => TaskManager.fromJson(json))
//            .toList();
//
//        if (result != null) {
//          final nextPageKey = pageKey + result.length;
//          pagingController.appendPage(result, nextPageKey);
//          currentPage++;
//          print(currentPage);
//        }
//
//        return result;
//      } else {
//        return <TaskManager>[];
//      }
//    } catch (e) {
//      return <TaskManager>[];
//    }
//  }
//
//
//
//  Future<List<TaskManager>> task_manager_onsearch(
//      {bool isReload = false, String word}) async {
//    try {
//
//
//      if (isReload) {
//        search_current_page = 0;
//      }
//
//      String url = http_root + "search_task_manager.php?page_no=$search_current_page&size=5&word=$word";
//
//      final response = await http.get(url);
//
//      if (response.statusCode == 200) {
//        print("onsearch");
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
////        print(parsed
////            .map<TaskManager>((json) => TaskManager.fromJson(json))
////            .toList());
//        result = parsed
//            .map<TaskManager>((json) => TaskManager.fromJson(json))
//            .toList();
//
//        if (result != null && result.isNotEmpty) {
//          filtered_list(result);
//          this.searchedWord = word;
//          search_current_page++;
//          print(search_current_page);
//
//          if (result != null && result.isNotEmpty) {
//            print(result);
//            return result;
//          }
//        } else {
//          return List<TaskManager>();
//        }
//      }
//    }
//    catch (e) {
//      return List<TaskManager>();
//    }
//  }
//}
//
