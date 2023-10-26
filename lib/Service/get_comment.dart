import 'dart:convert';
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Model/comment.dart';
import 'package:triple_n/Model/users.dart';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';


class Comment_data{

  static Future<List<Comment>> comment_data(task_id) async {
    try {
      String url = http_root+comment_path+"?task_id=$task_id";



      final response = await http.get(url);

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();

      }


    }
    catch(e){
      return e;
    }
  }

}