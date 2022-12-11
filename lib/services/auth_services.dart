import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class Auth {
  static Future<String?> registerUser(
      String username, String email, String pass) async {
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url = Uri.parse('http://10.0.2.2:2023/api/v1/auth/register');

    var body = {"username": username, "email": email, "password": pass};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }

  Future<String> login(String email, String pass) async {
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url = Uri.parse('http://10.0.2.2:2023/api/v1/auth/login');

    var body = {"email": email, "password": pass};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);
    try {
      var res = await req.send();
      final resBody = await res.stream.bytesToString();
      var result = jsonDecode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(result['token']);
        return result['token'];
      } else {
       return "error";
      }
    } catch (ex) {
      throw ex;
    }
  }
}
