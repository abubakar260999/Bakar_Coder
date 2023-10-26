//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/call.dart';
//
//
//class CallsService{
//  static Future<List<Calls>> calls() async {
//    try {
//
//      String url = http_root+calls_path;
//
//      var map = Map<String, dynamic>();
//      map['action'] = "Calls";
//      final response = await http.post(url, body: map);
//      var result=[];
//
//
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        return parsed.map<Calls>((json) => Calls.fromJson(json)).toList();
//
//
//      }
//      else {
//        return List<Calls>();
//
//      }
//
//    }
//    catch(e){
//      return List<Calls>();
//    }
//  }
//
//
//
//}