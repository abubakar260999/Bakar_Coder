import 'dart:convert';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Model/users.dart';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';
class Users_data{
  static Future<String> users(user_id) async {
    try {
      String url = http_root+users_path;
      var map = Map<String, dynamic>();
      map['action'] = "Users";
      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Users>((json) => Users.fromJson(json)).toList();

      }
      else {
        return "No name";

      }

    }
    catch(e){
      return "No Name";
    }
  }

}