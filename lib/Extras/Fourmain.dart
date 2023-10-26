//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/fourmain.dart';
//
//
//
//
//class Task_Service{
//  static Future<List<TaskManager>> complete() async {
//    try {
//
//      String url = http_root+four_main_task_path;
//      var map = Map<String, dynamic>();
//      map['action'] = "Completed";
//      final response = await http.post(url, body: map);
//      var result=[];
//
//
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
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
//  static Future<List<TaskManager>> inprocess() async {
//    try {
//
//      String url = http_root+four_main_task_path;
//      var map = Map<String, dynamic>();
//      map['action'] = "Inprocess";
//      final response = await http.post(url, body: map);
//      var result=[];
//
//
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        print(parsed.map<TaskManager>((json) => TaskManager.fromJson(json)).toList());
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
//
//  static Future<List<TaskManager>> notstarted() async {
//    try {
//
//      String url = http_root+four_main_task_path;
//      var map = Map<String, dynamic>();
//      map['action'] = "Notstarted";
//      final response = await http.post(url, body: map);
//      var result=[];
//
//
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
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
//  static Future<List<TaskManager>> overdue() async {
//    try {
//
//      String url = http_root+four_main_task_path;
//      var map = Map<String, dynamic>();
//      map['action'] = "Overdue";
//      final response = await http.post(url, body: map);
//      var result=[];
//
//
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
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