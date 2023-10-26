import 'package:http/http.dart' as http;
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';

class Services {
  static final root = http_root + add_dailytask_path;
  static const action_daily_task = 'add_daily_task';

  static Future<String> add_daily_task(
      String title,
      String start_time,
      String end_time,
      String detail,
      String date,
      String status,
      String user) async {

    try {
      var map = Map<String, dynamic>();
      map['action'] = action_daily_task;
      map['title'] = title;
      map['start_time'] = start_time;
      map['end_time'] = end_time;
      map['detail'] = detail;
      map['date'] = date;
      map['status'] = status;
      map['user'] = user;

//      headers: <String, String>{
//        'Content-Type': 'application/json; charset=UTF-8',
//        'Accept': "*/*",
//        'connection': 'keep-alive',
//        'Accept-Encoding' : 'gzip, deflate, br',
//      }
      final response = await http.post(root, body: map,);

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
