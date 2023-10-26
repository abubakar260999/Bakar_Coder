import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';

class badges{

  static Future<String> count(String action) async {
     final root = http_root+"badges.php?action=$action";
    try {

      final response = await http.get(root);
      print(response.body);

      if (response.statusCode == 200){
        print("hello");
        print(response.body);
        return response.body;
      } else {
        return "0";
      }
    } catch (e) {
      print(e);
      return "0";
    }
  }



}
