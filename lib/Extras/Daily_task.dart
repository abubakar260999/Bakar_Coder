//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/daily_task_widget.dart';
//
//
//
//
//class Daily_taskService{
//  static Future<List<DailyTask>> daily_task() async {
//    try {
//      String url = http_root+daily_task_path;
//
//      var map = Map<String, dynamic>();
//      map['action'] = "Daily_task";
//      final response = await http.post(url, body: map);
//      var result=[];
//
//
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        return parsed.map<DailyTask>((json) => DailyTask.fromJson(json)).toList();
//
//
//      }
//      else {
//        return List<DailyTask>();
//
//      }
//
//    }
//    catch(e){
//      return List<DailyTask>();
//    }
//  }
//
//
//
//}