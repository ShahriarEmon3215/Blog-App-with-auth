import 'dart:io';

import 'package:blog_app/views/login_screen.dart';
import 'package:blog_app/views/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'views/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('user_token');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: box.get("token") == null
        ? LoginScreen()
        : HomeScreen(token: box.get("token")),
  ));
}
