//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Global/paths.dart';
//
//class Token{
//
//  static final root = http_root+token_path;
//
//  static Future<String> Post_token(int user_id,String token,String type) async {
//    try {
//      var map = Map<String, dynamic>();
//
//      map['user_id'] = user_id;
//      map['token'] = token;
//      map['type'] = type;
//
//      final response = await http.post(root, body: map);
//
//
//      print("body");
//      print(response.body);
//
//      if (response.statusCode == 200){
//        print("hello");
//        print(response.body);
//        return response.body;
//      }
////      else {
////        return "Invalid";
////      }
//    } catch (e) {
//      print(e);
//      return "error";
//    }
//  }
//
//}
