import 'package:http/http.dart' as http;
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';

class Services {
  static final root = http_root + add_calls_path;
  static const action_calls = 'add_calls';


  static Future<String> add_calls(
      String attender,
      String buisness_name,
      String phone_no,
      String call_for,
      String subject,
      String remarks,
      String call_type,
      String date) async {
    try {

      var map = Map<String, dynamic>();
      map['action'] = action_calls;
      map['attender'] = attender;
      map['business_name'] = buisness_name;
      map['phone_no'] = phone_no;
      map['call_for'] = call_for;
      map['subject'] = subject;
      map['remarks'] = remarks;
      map['call_type'] = call_type;
      map['date'] = date;

      print("in calls");

//      headers: <String, String>{
//        'Content-Type': 'application/json; charset=UTF-8',
//        'Accept': "*/*",
//        'connection': 'keep-alive',
//        'Accept-Encoding' : 'gzip, deflate, br',
//      },

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
