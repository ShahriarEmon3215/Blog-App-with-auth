import 'dart:convert';

import 'package:blog_app/models/post.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class PostService {
  static Future<List<Post>?> getAllPosts() async {
    var headersList = {
      'Accept': '*/*',
    };
    var url = Uri.parse('http://10.0.2.2:2023/api/v1/posts');

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    try {
      var res = await req.send();

      var response = await http.Response.fromStream(res);
      var resBody = jsonDecode(response.body);

      List<Post> posts = [];
      for (int i = 0; i < resBody.length; i++) {
        posts.add(Post(
            title: resBody[i]['title'],
            description: resBody[i]['description'],
            user_id: resBody[i]['user_id'],
            posted_at: resBody[i]['posted_at'],
            img: resBody[i]['img']));
      }

      if (res.statusCode == 200) {
        print(resBody[0]['title']);
        return posts;
      } else {
        print(res.reasonPhrase);
        return posts;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<User?> getUserData(String token) async {
    var headers = {
      'Accept': '*/*',
      'auth-token': token,
    };
    var url = Uri.parse('http://10.0.2.2:2023/api/v1/user/getuser');

    var req = http.Request('POST', url);
    req.headers.addAll(headers);

    var res = await req.send();
//final resBody = await res.stream.bytesToString();

    var response = await http.Response.fromStream(res);
    final resBody = jsonDecode(response.body);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      var user =
          User(username: resBody[0]['username'], email: resBody[0]['email']);
      print(user);

      return user;
    } else {
      print(res.reasonPhrase);
      return User(username: "----", email: "-----");
    }
  }

  static createPost(
      {String? title,
      String? desc,
      String? user_id,
      String? posted_at,
      String? img}) async {
    var headersList = {
      'Accept': '*/*',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('http://10.0.2.2:2023/api/v1/posts/create');

    var body = {
      "title": title,
      "description": desc,
      "user_id": user_id,
      "posted_at": posted_at,
      "img": img
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
   
    var response = await http.Response.fromStream(res);
    final resBody = jsonDecode(response.body);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }
}
