import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import 'widgets/vTextField.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  String? res = "";

  bool _userNameValidate = false;
  bool _emailValidate = false;
  bool _passValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 226, 255),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          "Create new account",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 218, 226, 255),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Text("Sign-up for explore latest blogs"),
                SizedBox(height: 50),
                vTextField(
                    "Enter username.", usernameController, _userNameValidate),
                SizedBox(height: 15),
                vTextField("Enter Email.", emailController, _emailValidate),
                SizedBox(height: 15),
                vTextField(
                    "Enter password.", passwordController, _passValidate),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: () async {
                     
                      if (usernameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        await Auth.registerUser(usernameController.text,
                            emailController.text, passwordController.text);
                      }else{
                         setState(() {
                        usernameController.text.isEmpty
                            ? _userNameValidate = true
                            : _userNameValidate = false;
                        emailController.text.isEmpty
                            ? _emailValidate = true
                            : _emailValidate = false;
                        passwordController.text.isEmpty
                            ? _passValidate = true
                            : _passValidate = false;
                      });

                      }

                     
                    },
                    child: Text("CREATE ACCOUNT")),
                SizedBox(height: 50),
                Row(
                  children: [
                    Text("Agree to the terms & conditions"),
                    SizedBox(width: 5),
                    Checkbox(value: true, onChanged: (v) {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
