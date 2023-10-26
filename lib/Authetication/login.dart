import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';

class authetication{

  static final root = http_root+login_path;

  static Future<String> check_login(String email,String password,String token) async {
    try {
      var map = Map<String, dynamic>();

      map['email'] = email;
      map['password'] = password;
      map['token'] = token;

      final response = await http.post(root, body: map);
      print("body");
      print(response.body);

      if (response.statusCode == 200){
        print("hello");
        print(response.body);
        return response.body;
      }
//      else {
//        return "Invalid";
//      }
    } catch (e) {
      print(e);
      return "error";
    }
  }

}
