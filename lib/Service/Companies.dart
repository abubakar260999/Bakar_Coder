import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/global.dart';
import 'package:triple_n/Model/companies.dart';
import 'package:triple_n/Global/paths.dart';

class CompaniesService{
  static Future<List<Companies>> companies() async {
    try {

//      192.168.10.135
      String url = http_root+cooperation_path;
      var map = Map<String, dynamic>();
      map['action'] = "Company";
      final response = await http.get(url);
     var result=[];


      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        print(parsed.map<Companies>((json) => Companies.fromJson(json)).toList());
        return parsed.map<Companies>((json) => Companies.fromJson(json)).toList();


      }
      else {
        return List<Companies>();

      }

    }
    catch(e){
      return List<Companies>();
    }
  }



}


//int i=0;
//while(i<parsed.length){
//
//result.add(Companies.fromJson(parsed[i]).companyTitle);
//i++;
//
//
//}
//return result;