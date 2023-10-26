//import 'dart:convert';
//import 'package:flutter/cupertino.dart';
//import 'package:http/http.dart' as http;
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/task_manager.dart';
//
//class Task_Manager_Service{
//  static Future<List<TaskManager>> task_manager() async {
//    try {
//
//      String url = http_root+task_manager_path;
////      var map = Map<String, dynamic>();
////      map['action'] = "Task_manager";
//      final response = await http.get(url);
//      var result=[];
//
//      if (response.statusCode == 200) {
//        print("hello");
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
////        print(parsed.map<TaskManager>((json) => TaskManager.fromJson(json)).toList());
//        return parsed.map<TaskManager>((json) => TaskManager.fromJson(json)).toList();
//
//
//      }
//      else {
//        return List<TaskManager>();
//
//      }
//
//    }
//    catch(e){
//      return List<TaskManager>();
//    }
//  }
//
//
//
//}