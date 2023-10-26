import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:triple_n/Global/paths.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class Services {
  static final root = http_root + add_contact_paths;
  static const action_contact = 'add_contact';


//add contatct
  static Future<String> add_contact(
      String full_name,
      String company_name,
      String business_type,
      String address,
      String city,
      String state,
      String zip,
      String country,
      String contact,
      String mobile,
      String email,
      String fax,
      File _image1,
      File _image2
      ) async {
    try {
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
//      map['mobile'] = mobile;
//      map['email'] = email;
//      map['fax'] = fax;
//      map['image1'] = _image1.path;
//      map['image2'] = _image2.path;
//
//      final response = await http.post(root, body: map);

      var uri = Uri.parse(root);
      var request = new http.MultipartRequest("POST", uri);

    if(_image1!=null)
      {
        var stream1 = new http.ByteStream(DelegatingStream.typed(_image1.openRead()));
        var length1 = await _image1.length();
        var multipartFile1 = new http.MultipartFile('image1', stream1, length1,
            filename: basename(_image1.path));
        request.files.add(multipartFile1);
        String image_name1=company_name.replaceAll(' ', '-')+'front';
        request.fields['image1_name'] = image_name1;


      }
    if(_image2!=null){
      var stream2 = new http.ByteStream(DelegatingStream.typed(_image2.openRead()));
      var length2 = await _image2.length();

      var multipartFile2= new http.MultipartFile('image2', stream2, length2,
          filename: basename(_image2.path));
      request.files.add(multipartFile2);
      var image_name2=company_name.replaceAll(' ', '-')+'back';
      request.fields['image2_name'] = image_name2;
    }

      //contentType: new MediaType('image', 'png'));
//      headers: <String, String>{
//        'Content-Type': 'application/json; charset=UTF-8',
//        'Accept': "*/*",
//        'connection': 'keep-alive',
//        'Accept-Encoding' : 'gzip, deflate, br',
//      },

//    request.headers['Content-Type']='application/json; charset=UTF-8';
//
//    request.headers['Accept']="*/*";
//
//    request.headers['connection']='keep-alive';
//
//    request.headers['Accept-Encoding']='gzip, deflate, br';

      request.fields['full_name'] = full_name;
      request.fields['company_name'] = company_name;
      request.fields['business_type'] = business_type;
      request.fields['address'] = address;
      request.fields['city'] = city;
      request.fields['state'] = state;
      request.fields['zip'] = zip;
      request.fields['country'] = country;
      request.fields['contact'] = contact;
      request.fields['mobile'] = mobile;
      request.fields['email'] = email;
      request.fields['fax'] = fax;


      var response_image = await request.send();

//      print(response.statusCode);
      response_image.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });


//      print(response.body);
//      if (image_response.statusCode == 200 || response.statusCode == 200) {
//        return response.body;
//      } else {
//        return "Error";
//      }
    } catch (e) {
      return "error";
    }
  }
}



//      http.MultipartRequest request = new http.MultipartRequest("POST",Uri.parse(root));
//
//      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
//          'image1', _image1.path, filename: 'image1');
//
//       multipartFile = await http.MultipartFile.fromPath(
//          'image2',_image2.path,filename: 'image2' );
//      request.files.add(multipartFile);
//
//      http.StreamedResponse image_response = await request.send();
//
//      print(image_response.statusCode);
//print(response.body);


//      var request = http.MultipartRequest('POST', Uri.parse(root));
////      request.fields['image_title'] = company_name;
//      request.files.add(await http.MultipartFile.fromPath('image', _image1.path,filename: 'image', ));
//      request.files.add(await http.MultipartFile.fromPath('imagee',_image2.path,filename: 'imagee' ));
//      print(_image1.path);
//      print(request.files[0]);
//      var image_response = await request.send();