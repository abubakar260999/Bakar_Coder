import 'package:http/http.dart' as http;
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';

class Services_update {
  static final root = http_root + update_status_path;

  static Future<String> update_status(
     String id, String status) async {
    try {

      var map = Map<String, dynamic>();
      map['task_status'] = status;
      map['task_id'] = id;

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
