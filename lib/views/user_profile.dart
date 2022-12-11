import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/blog_post_services.dart';

class Profile extends StatefulWidget {
  String? token;
  Profile({super.key, this.token});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 226, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 218, 226, 255),
        elevation: 0,
        title: Text("Me", style: TextStyle(color: Colors.black),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: SafeArea(
        child: FutureBuilder<User?>(
          future: PostService.getUserData(widget.token!),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            return snapshot.hasData
                ? SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_rounded,
                          size: 100,
                        ),
                        SizedBox(height: 10),
                        Text(
                          snapshot.data!.username!,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(snapshot.data!.email!),
                      ],
                    ),
                  )
                : Center(
                    child: Text("No data"),
                  );
          },
        ),
      ),
    );
  }
}
