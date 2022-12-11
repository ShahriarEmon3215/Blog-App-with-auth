import 'package:blog_app/views/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../services/auth_services.dart';
import 'home_screen.dart';
import 'widgets/vTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool _emailValidate = false;
  bool _passValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 226, 255),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    'assets/images/persons.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "FlutBlog",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text("A simple micro blogging app"),
                SizedBox(height: 60),
                vTextField("Enter email.", emailController, _emailValidate),
                SizedBox(height: 15),
                vTextField("Enter password", passwordController, _passValidate),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () async {
                      CircularProgressIndicator();
                      setState(() {
                        emailController.text.isEmpty
                            ? _emailValidate = true
                            : _emailValidate = false;
                        passwordController.text.isEmpty
                            ? _passValidate = true
                            : _passValidate = false;
                      });

                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        CircularProgressIndicator();
                        String result;
                        result = await Auth().login(
                            emailController.text, passwordController.text);
                        if (result != "error") {
                          // add token to hive
                          await Hive.box("user_token").put("token", result);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => HomeScreen(
                                        token: result,
                                      )));
                        } else {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  content: Row(
                                    children: [
                                      Text("Error login user!"),
                                      Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Try agian")),
                                    ],
                                  ),
                                );
                              });
                        }
                      }
                    },
                    child: Text("LOGIN")),
                SizedBox(height: 40),
                Row(
                  children: [
                    Text("Not registerd yet?"),
                    SizedBox(width: 10),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                        child: Text("REGISTER NOW")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
