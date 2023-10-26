import 'package:http/http.dart' as http;
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';

class Services {
  static final root = http_root + add_comment_path;

  static Future<String> add_comment(
      String task_id,
      String user_id,
      String text) async {
    try {

      var map = Map<String, dynamic>();
      map['id'] = task_id;
      map['user'] = user_id;
      map['text'] = text;
//      map['date'] = date;

      print("in calls");


      final response = await http.post(root, body: map);

      print("done");

      print(response.body);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Error";
      }
    } catch (e) {
      return "error";
    }
  }


}
