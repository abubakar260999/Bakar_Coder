import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class usesecurestorage{

  static final _key="email";
  static final _token="token";
  static final storage = new FlutterSecureStorage();
  static Future write_data(String email) async =>await storage.write(key: _key, value: email);
  static Future write_token(String token) async =>await storage.write(key: _token, value: token);


  static Future read_data() async =>await storage.read(key: _key);
  static Future read_token() async =>await storage.read(key: _token);


  static Future delete_data() async =>await storage.delete(key: _key);
//  static Future read_email() async =>await storage.read(key: _key);

}