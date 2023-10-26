import 'dart:convert';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Model/users.dart';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';


class data{
  static Future<List<Users>> users(user_email) async {
    try {

      String url = http_root+user_info_path;
      var map = Map<String, dynamic>();
      map['email'] = user_email;

      final response = await http.post(url, body: map);
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        print("hell");
        print(parsed.map<Users>((json) => Users.fromJson(json)).toList());
        return parsed.map<Users>((json) => Users.fromJson(json)).toList();

      }
      else {
        print("no");
        return <Users>[];
      }
    }
    catch(e){
      print(e);
      print("nnnn");
      return <Users>[];
    }
  }

}

