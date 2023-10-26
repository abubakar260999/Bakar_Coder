//import 'dart:convert';
//import 'dart:io';
//import 'package:http/http.dart' as http;
//import 'package:triple_n/Global/global.dart';
//
//
//class Services {
//  static final root = http_root + add_path;
//  static final root1 = http_root + add_task_path;
//
//  //static const root = 'http://nnn.today/test_apiv2/add.php';
//  static const action_appointment = 'add_appointment';
//  static const action_calls = 'add_calls';
//  static const action_daily_task = 'add_daily_task';
//  static const action_contact = 'add_contact';
//  static const action_task = 'Task';
//
////
////  List<Map> toBase64(List<File> fileList){
////    List<Map> s = new List<Map>();
////    if(fileList.length>0)
////      fileList.forEach((element){
////        Map a = {
////          'fileName': basename(element.path),
////          'encoded' : base64Encode(element.readAsBytesSync())
////        };
////        s.add(a);
////      });
////    return s;
////  }
//
//  static Future<String> task(
//      String task_owner,
//      String client,
//      String assigned_by,
//      String assign_to,
//      String subject,
//      String priority,
//      String description,
//      String start_date,
//      String due_date,
//      String due_time,
//      String status,
//      List<File> _file) async {
//    try {
//      print(_file);
//
//      var map = Map<String, dynamic>();
//      map['action'] = action_task;
//
//      map['task_owner'] = task_owner;
//      map['client'] = client;
//      map['assigned_by'] = assigned_by;
//      map['assigned_to'] = assign_to;
//      map['subject'] = subject;
//      map['priority'] = priority;
//      map['description'] = description;
//      map['start_date'] = start_date;
//      map['due_date'] = due_date;
//      map['due_time'] = due_time;
//      map['status'] = status;
//
//      final response = await http.post(root1, body: map);
//
//      var request = http.MultipartRequest('POST', Uri.parse(root1));
//      request.fields['name'] = task_owner;
////
////      _file.map((e) async {
////        request.files.add(
////          http.MultipartFile.fromBytes(
////            'files',
////            await File.fromUri(Uri.parse(e.path)).readAsBytes(),
////          ),
////        );
////      }).toList();
//
////      await Future.forEach(
////        _file,
////        (file) async => {
////          request.files.add(
////            http.MultipartFile(
////              'files',
////              (http.ByteStream(file.openRead())).cast(),
////              await file.length(),
////              filename: basename(file.path),
////            ),
////          )
////        },
////      );
//
//      List<String> images = [];
//      _file.map((e) {
//          List<int> imageBytes = e.readAsBytesSync();
//          String baseimage = base64Encode(imageBytes);
//          images.add(baseimage);
//      }).toList();
//      request.fields['images'] = json.encode(images);
//
//      var image_response = await request.send();
//
//      print(request.files);
//
//      print("helo files");
//
//      print(response.body);
//      if (response.statusCode == 200) {
//        return response.body;
//      } else {
//        return "Error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }
//
//  static Future<String> add_appointment(String date, String name, String phone,
//      String description, String status, String company, String time) async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = action_appointment;
//      map['date'] = date;
//      map['name'] = name;
//      map['phone'] = phone;
//      map['description'] = description;
//      map['status'] = status;
//      map['company'] = company;
//      map['time'] = time;
//
//      final response = await http.post(root, body: map);
//
//      print(response.body);
//      if (response.statusCode == 200) {
//        return response.body;
//      } else {
//        return "Error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }
//
//  static Future<String> add_calls(
//      String attender,
//      String buisness_name,
//      String phone_no,
//      String call_for,
//      String subject,
//      String remarks,
//      String call_type,
//      String date) async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = action_calls;
//      map['attender'] = attender;
//      map['business_name'] = buisness_name;
//      map['phone_no'] = phone_no;
//      map['call_for'] = call_for;
//      map['subject'] = subject;
//      map['remarks'] = remarks;
//      map['call_type'] = call_type;
//      map['date'] = date;
//
//      final response = await http.post(root, body: map);
//
//      print(response.body);
//      if (response.statusCode == 200) {
//        return response.body;
//      } else {
//        return "Error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }
//
//  static Future<String> add_daily_task(
//      String title,
//      String start_time,
//      String end_time,
//      String detail,
//      String date,
//      String status,
//      String user) async {
//
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = action_daily_task;
//      map['title'] = title;
//      map['start_time'] = start_time;
//      map['end_time'] = end_time;
//      map['detail'] = detail;
//      map['date'] = date;
//      map['status'] = status;
//      map['user'] = user;
//      final response = await http.post(root, body: map);
//
//      print(response.body);
//      if (response.statusCode == 200) {
//        return response.body;
//      } else {
//        return "Error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }
//
////add contatct
//  static Future<String> add_contact(
//      String full_name,
//      String company_name,
//      String business_type,
//      String address,
//      String city,
//      String state,
//      String zip,
//      String country,
//      String contact,
//      String mobile,
//      String email,
//      String fax) async {
//    try {
//      var map = Map<String, dynamic>();
//      map['action'] = action_contact;
//      map['full_name'] = full_name;
//      map['company_name'] = company_name;
//      map['business_type'] = business_type;
//      map['address'] = address;
//      map['city'] = city;
//      map['state'] = state;
//      map['zip'] = zip;
//      map['country'] = country;
//      map['contact'] = contact;
//      map['mobille'] = mobile;
//      map['email'] = email;
//      map['fax'] = fax;
//
//      final response = await http.post(root, body: map);
//
//      var request = http.MultipartRequest('POST', Uri.parse(""));
//
//      request.fields['name'] = company_name;
//      request.fields['name'] = company_name;
//
////      request.files.add(await http.MultipartFile.fromPath('image1',_image1.path ));
////
////      request.files.add(await http.MultipartFile.fromPath('image2',_image2.path ));
//
//      var image_response = await request.send();
//
//      print(response.body);
//
//      if (image_response.statusCode == 200 || response.statusCode == 200) {
//        return response.body;
//      } else {
//        return "Error";
//      }
//    } catch (e) {
//      return "error";
//    }
//  }
//}
