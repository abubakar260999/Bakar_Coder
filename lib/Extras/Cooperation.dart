//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/cooperation.dart';
//
//class CooperationService{
//  static Future<List<Cooperation>> cooperation() async {
//    try {
//
//      String url = http_root+cooperation_path;
//      var map = Map<String, dynamic>();
//      map['action'] = "Cooperation";
//      final response = await http.post(url, body: map);
//      var result=[];
//
//
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        return parsed.map<Cooperation>((json) => Cooperation.fromJson(json)).toList();
//
//
//      }
//      else {
//        return List<Cooperation>();
//
//      }
//
//    }
//    catch(e){
//      return List<Cooperation>();
//    }
//  }
//
//
//
//}