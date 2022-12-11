import 'package:blog_app/models/user.dart';
import 'package:blog_app/services/blog_post_services.dart';
import 'package:blog_app/views/home_screen.dart';
import 'package:blog_app/views/widgets/vTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ModifyPostScreen extends StatefulWidget {
  String? token;
  ModifyPostScreen({super.key, this.token});

  @override
  State<ModifyPostScreen> createState() => _ModifyPostScreenState();
}

class _ModifyPostScreenState extends State<ModifyPostScreen> {
  var titleController = TextEditingController();
  var dscController = TextEditingController();
  var userIdController = TextEditingController();
  var posted_atController = TextEditingController();
  var imgController = TextEditingController();


  bool _titleValidator = false;
  bool _dscValidator = false;
   bool _imgValidator = false;

  User? user;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
    user = await PostService.getUserData(widget.token!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 226, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 218, 226, 255),
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> HomeScreen(token: "",)));
        }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
        title: Text("Modify post", style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(onPressed: ()async{
           await PostService.createPost(title: titleController.text, desc: dscController.text, user_id: user!.email!, posted_at: DateTime.now().toString(), img: imgController.text);
          }, icon: Icon(Icons.save, color: Colors.black,)),
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            vTextField("Paste image url here", imgController, _imgValidator),
            SizedBox(height: 4),
            vTextField("Title", titleController, _titleValidator),
            Expanded(
              child: TextField(
                controller: dscController,
                maxLength: 1000,
                maxLines: 100,
                decoration: InputDecoration(
                  errorText: _dscValidator? "Can\'t be empty!" : null,
                  hintText: "Type here...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
