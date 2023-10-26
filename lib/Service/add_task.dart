import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class Services {

  static final root = http_root + add_task_path;
  static const action_task = 'Task';


  static Future<String> task(
      String task_owner,
      String client,
      String assigned_by,
      List assign_to,
      String subject,
      String priority,
      String description,
      String start_date,
      String due_date,
      String status,
      List<File> _file) async {
    try {
      print(_file.length);

//      var map = Map<String, dynamic>();
//      map['action'] = action_task;
//      map['task_owner'] = task_owner;
//      map['client'] = client;
//      map['assigned_by'] = assigned_by;
//      map['assigned_to'] = assign_to;
//      map['subject'] = subject;
//      map['priority'] = priority;
//      map['description'] = description;
//      map['start_date'] = start_date;
//      map['due_date'] = due_date;
//      map['status'] = status;

      List<http.MultipartFile> newList = [];


      var uri = Uri.parse(root);
      var request = new http.MultipartRequest("POST", uri);

      for (int i=0;i<assign_to.length;i++) {

        request.files.add(http.MultipartFile.fromString('assign_to[]', assign_to[i]));

//        newList.addAll({“assign_to[$i]”:assign_to[i]});

      }


      //image file or file
      for (int i=0;i<_file.length;i++){
        var stream1 = new http.ByteStream(DelegatingStream.typed(_file[i].openRead()));
        var length1 = await _file[i].length();

        var multipartFile1 = new http.MultipartFile('$i', stream1, length1,
            filename: basename(_file[i].path));
        newList.add(multipartFile1);
        print(multipartFile1);
      }

      request.files.addAll(newList);

if(_file.length!=0)
  {
    var length=_file.length.toString();

    request.fields['length'] = length ;

    print(length);

  }else{
  var length=0.toString();

  request.fields['length'] = length ;

  print(length);

}



//print(newList);
      print(assign_to);
print("hello");
print(assigned_by);
print(client);

//      request.headers['Content-Type']='application/json; charset=UTF-8';
//      request.headers['Content-Type']=' multipart/form-data';
//
//      request.headers['Accept']="*/*";
//
//      request.headers['connection']='keep-alive';
//
//      request.headers['Accept-Encoding']='gzip, deflate, br';


      request.fields['task_owner'] = task_owner;
      request.fields['client'] = client;
      request.fields['assigned_by'] = assigned_by;
      request.fields['assign_to_length'] = assign_to.length.toString();
      request.fields['subject'] = subject;
      request.fields['priority'] = priority;
      request.fields['description'] = description;
      request.fields['start_date'] = start_date;
      request.fields['due_date'] = due_date;
      request.fields['status'] = status;


      var response_image = await request.send();

//      print(response.statusCode);
      response_image.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });

    } catch (e) {
      return "error";
    }
  }


}



//final response = await http.post(root, body: map);
//
//var request = http.MultipartRequest('POST', Uri.parse(root));
//request.fields['name'] = task_owner;
//
//
//List<String> images = [];
//_file.map((e) {
//List<int> imageBytes = e.readAsBytesSync();
//String baseimage = base64Encode(imageBytes);
//images.add(baseimage);
//}).toList();
//request.fields['images'] = json.encode(images);
//
//var image_response = await request.send();
//
//print(request.files);
//
//print("helo files");
//print(response.body);
//      if (response.statusCode == 200) {
//        return response.body;
//      } else {
//        return "Error";
//      }