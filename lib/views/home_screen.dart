import 'package:blog_app/models/post.dart';
import 'package:blog_app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';

import '../models/user.dart';
import '../services/auth_services.dart';
import '../services/blog_post_services.dart';
import 'modify_posts_screen.dart';
import 'user_profile.dart';
import 'widgets/postCart.dart';

class HomeScreen extends StatefulWidget {
  String? token;
  HomeScreen({super.key, this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var hivedb = Hive.box('user_token');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 226, 255),
      appBar: AppBar(
        title: Text(
          "BlogFeed",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 218, 226, 255),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => Profile(token: hivedb.get('token'))));
              },
              icon: Icon(
                Icons.person_rounded,
                color: Colors.black,
              )),
          SizedBox(width: 10),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        content: Text("Are you sure want to logout?"),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await hivedb.delete("token").then((value) =>
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => LoginScreen())));
                              },
                              child: Text("Yes")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"))
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              )),
        ],
      ),
      body: FutureBuilder<List<Post>?>(
          future: PostService.getAllPosts(),
          builder: (BuildContext context, AsyncSnapshot<List<Post>?> snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return postCard(
                        snapshot.data![index].img,
                        snapshot.data![index].title,
                        snapshot.data![index].user_id,
                        snapshot.data![index].posted_at,
                      );
                    },
                  )
                : Center(
                    child: Text("No data found yet!"),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (ctx) => ModifyPostScreen(
                        token: hivedb.get('token'),
                      )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
