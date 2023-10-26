//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:triple_n/Global/global.dart';
//import 'package:triple_n/Model/Contact.dart';
//
//
//class ContactService{
//  static Future<List<Contact>> contact() async {
//    try {
//
//      String url = http_root+contact_path;
//      var map = Map<String, dynamic>();
//      map['action'] = "Contact";
//      final response = await http.post(url, body: map);
//      if (response.statusCode == 200) {
//        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
//        return parsed.map<Contact>((json) => Contact.fromJson(json)).toList();
//
//
//      }
//      else {
//        return List<Contact>();
//
//      }
//
//    }
//    catch(e){
//      return List<Contact>();
//    }
//  }
//
//
//
//}