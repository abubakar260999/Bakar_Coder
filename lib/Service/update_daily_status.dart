import 'package:http/http.dart' as http;
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';

class Services_daily_status {
  static final root = http_root + update_daily_status_path;

  static Future<String> update_daily_status(
      String id, String status) async {
    try {

      var map = Map<String, dynamic>();

      map['id'] = id;
      map['status'] = status;
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
