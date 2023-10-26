import 'package:http/http.dart' as http;
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Global/paths.dart';


class Services {
  static final root = http_root + add_appointments_path;
  static const action_appointment = 'add_appointment';

  static Future<String> add_appointment(String date, String name, String phone,
      String description, String status, String company, String time) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = action_appointment;
      map['date'] = date;
      map['name'] = name;
      map['phone'] = phone;
      map['description'] = description;
      map['status'] = status;
      map['company'] = company;
      map['time'] = time;


//      headers: <String, String>{
////        'Content-Type': 'application/json; charset=UTF-8',
////        'Accept': "*/*",
////        'connection': 'keep-alive',
////        'Accept-Encoding' : 'gzip, deflate, br',
////      },


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
